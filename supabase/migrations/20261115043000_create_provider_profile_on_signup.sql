-- Create the provider-specific profile alongside the common user profile.
-- This is a new migration because the initial auth migration has already been
-- applied to the target Supabase project.
--
-- Confirmed schema relationship:
--   public.providers.id -> public.users.id
--
-- Only the provider role receives a row in public.providers. The category,
-- location, bio, experience, rating, and verification fields remain unset
-- until the provider completes the profile form.

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
  should_create_provider boolean := false;
begin
  -- Map the selected role to the existing user_types labels.
  if requested_role in ('customer', 'client', 'محتاج خدمة', 'محتاج خدمه', 'عميل') then
    accepted_type_names := array['customer', 'client', 'محتاج خدمة', 'محتاج خدمه', 'عميل'];
  elsif requested_role in ('provider', 'service provider', 'مقدم الخدمة', 'مقدم خدمه') then
    accepted_type_names := array['provider', 'service provider', 'مقدم الخدمة', 'مقدم خدمه'];
    should_create_provider := true;
  else
    -- Do not allow admin or an unknown role to enter either public signup flow.
    raise exception 'Unsupported Sanad account role: %', requested_role
      using errcode = '23514';
  end if;

  -- Resolve the numeric foreign key from the database, not from hardcoded IDs.
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

  -- Create the shared Sanad profile for both customers and providers.
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

  -- providers.id is a foreign key to users.id, so reuse the Auth UUID.
  -- Omitted provider fields are nullable or have database defaults.
  if should_create_provider then
    insert into public.providers (id)
    values (new.id)
    on conflict (id) do nothing;
  end if;

  return new;
end;
$$;

-- Keep the trigger function callable only through the auth.users trigger.
revoke all on function public.handle_new_sanad_user() from public, anon, authenticated;
