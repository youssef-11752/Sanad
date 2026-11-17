-- Let customers update only their own editable profile fields.
grant update (full_name, phone) on table public.users to authenticated;

drop policy if exists sanad_users_update_own_profile
on public.users;
create policy sanad_users_update_own_profile
on public.users
for update
to authenticated
using ((select auth.uid()) = id)
with check ((select auth.uid()) = id);
