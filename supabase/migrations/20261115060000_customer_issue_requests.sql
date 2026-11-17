-- Unassigned customer issues hold the location until a provider is assigned
-- and an order can be created with its required provider_id.
alter table public.issues
  add column if not exists city_id integer
  references public.cities(id);

alter table public.issues
  add column if not exists address text;

-- Remove privileges from the earlier customer-order flow. Orders require an
-- assigned provider and are not created directly by the request form.
drop policy if exists sanad_orders_insert_own on public.orders;
drop policy if exists sanad_issues_delete_own_unassigned on public.issues;
revoke insert on table public.orders from authenticated;
revoke delete on table public.issues from authenticated;

insert into public.countries (name, code)
values ('Egypt', 'EG')
on conflict (code) do nothing;

insert into public.cities (country_id, name)
select egypt.id, city.name
from public.countries as egypt
cross join (
  values
    ('Cairo'),
    ('Giza'),
    ('Alexandria'),
    ('Mansoura'),
    ('Tanta'),
    ('Zagazig'),
    ('Ismailia'),
    ('Port Said'),
    ('Suez'),
    ('Asyut'),
    ('Luxor'),
    ('Aswan')
) as city(name)
where egypt.code = 'EG'
  and not exists (
    select 1
    from public.cities as existing_city
    where existing_city.country_id = egypt.id
      and lower(btrim(existing_city.name)) = lower(city.name)
  );

insert into public.categories (name)
select category.name
from (
  values
    (
      'Home appliance maintenance',
      array['home appliance maintenance', 'appliance maintenance', 'صيانة الأجهزة المنزلية']::text[]
    ),
    ('Painting', array['painting', 'النقاشة']::text[]),
    ('Carpentry', array['carpentry', 'النجارة']::text[]),
    ('Electrical', array['electrical', 'الكهرباء']::text[]),
    (
      'Air conditioning',
      array['air conditioning', 'air conditioner', 'صيانة المكيفات']::text[]
    ),
    ('Plumbing', array['plumbing', 'السباكة']::text[])
) as category(name, aliases)
where not exists (
  select 1
  from public.categories as existing_category
  where lower(btrim(existing_category.name)) = any(category.aliases)
);
