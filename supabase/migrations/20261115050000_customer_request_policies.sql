-- Authenticated customers can read the lookup data used by the request form.
alter table public.categories enable row level security;
alter table public.cities enable row level security;

grant select on table public.categories, public.cities to authenticated;

drop policy if exists sanad_categories_read_authenticated
on public.categories;
create policy sanad_categories_read_authenticated
on public.categories
for select
to authenticated
using (true);

drop policy if exists sanad_cities_read_authenticated
on public.cities;
create policy sanad_cities_read_authenticated
on public.cities
for select
to authenticated
using (true);

-- Customers can only read their own issues and orders, and create their own
-- issues. Orders are created only after a provider has been assigned.
alter table public.issues enable row level security;
alter table public.orders enable row level security;

grant select, insert on table public.issues to authenticated;
grant select on table public.orders to authenticated;

drop policy if exists sanad_issues_select_own
on public.issues;
create policy sanad_issues_select_own
on public.issues
for select
to authenticated
using ((select auth.uid()) = user_id);

drop policy if exists sanad_issues_insert_own
on public.issues;
create policy sanad_issues_insert_own
on public.issues
for insert
to authenticated
with check ((select auth.uid()) = user_id);

drop policy if exists sanad_orders_select_own
on public.orders;
create policy sanad_orders_select_own
on public.orders
for select
to authenticated
using ((select auth.uid()) = user_id);
