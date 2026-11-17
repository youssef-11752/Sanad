-- Authenticated users can read the service and city lookup tables.
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
