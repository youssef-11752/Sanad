-- Add only service categories that are not already present.
insert into public.categories (name)
select category.name
from (
  values
    (
      'Home appliance maintenance',
      array[
        'home appliance maintenance',
        'appliance maintenance',
        'صيانة الأجهزة المنزلية'
      ]::text[]
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
