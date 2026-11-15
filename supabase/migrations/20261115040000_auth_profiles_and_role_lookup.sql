-- Sanad auth profile integration.
-- Expected existing schema:
--   public.users(id, user_type_id, full_name, email, phone, profile_image, ...)
--   public.user_types(id, name, ...)
--   public.users.id references auth.users.id
--
-- Before testing sign-up, public.user_types must contain a customer/client
-- row and a provider/service-provider row (English or the Arabic labels below).

create or replace function public.handle_new_sanad_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  requested_role text := lower(btrim(coalesce(new.raw_user_meta_data ->> 'role', 'customer')));
  accepted_type_names text[];
  resolved_user_type_id integer;
  resolved_full_name text;
begin
  if requested_role in ('customer', 'client', 'محتاج خدمة', 'محتاج خدمه', 'عميل') then
    accepted_type_names := array['customer', 'client', 'محتاج خدمة', 'محتاج خدمه', 'عميل'];
  elsif requested_role in ('provider', 'service provider', 'مقدم الخدمة', 'مقدم خدمه') then
    accepted_type_names := array['provider', 'service provider', 'مقدم الخدمة', 'مقدم خدمه'];
  else
    raise exception 'Unsupported Sanad account role: %', requested_role
      using errcode = '23514';
  end if;

  select user_type.id
    into resolved_user_type_id
    from public.user_types as user_type
   where lower(btrim(user_type.name::text)) = any(accepted_type_names)
   order by array_position(accepted_type_names, lower(btrim(user_type.name::text)))
   limit 1;

  if resolved_user_type_id is null then
    raise exception 'No matching customer/provider row exists in public.user_types for role: %', requested_role
      using errcode = '23503';
  end if;

  resolved_full_name := nullif(
    btrim(coalesce(
      new.raw_user_meta_data ->> 'full_name',
      new.raw_user_meta_data ->> 'name',
      ''
    )),
    ''
  );

  insert into public.users (
    id,
    user_type_id,
    full_name,
    email,
    phone,
    profile_image
  )
  values (
    new.id,
    resolved_user_type_id,
    resolved_full_name,
    new.email,
    new.phone,
    nullif(new.raw_user_meta_data ->> 'profile_image', '')
  )
  on conflict (id) do nothing;

  return new;
end;
$$;

drop trigger if exists on_auth_user_created_sanad_profile on auth.users;

create trigger on_auth_user_created_sanad_profile
after insert on auth.users
for each row
execute function public.handle_new_sanad_user();

-- The app only needs to read the signed-in user's profile and the role lookup
-- table. Profile creation is performed by the security-definer trigger above.
alter table public.users enable row level security;
alter table public.user_types enable row level security;

grant select on table public.users to authenticated;
grant select on table public.user_types to authenticated;

drop policy if exists sanad_users_select_own_profile on public.users;
create policy sanad_users_select_own_profile
on public.users
for select
to authenticated
using ((select auth.uid()) = id);

drop policy if exists sanad_user_types_read_authenticated on public.user_types;
create policy sanad_user_types_read_authenticated
on public.user_types
for select
to authenticated
using (true);

revoke all on function public.handle_new_sanad_user() from public, anon, authenticated;
