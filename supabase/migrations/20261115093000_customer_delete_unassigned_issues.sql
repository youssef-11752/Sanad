-- Customers may delete only their own unassigned pending issues.
grant delete on table public.issues to authenticated;

drop policy if exists sanad_issues_delete_own_unassigned
on public.issues;
create policy sanad_issues_delete_own_unassigned
on public.issues
for delete
to authenticated
using (
  (select auth.uid()) = user_id
  and status = 'pending'
  and provider_id is null
);
