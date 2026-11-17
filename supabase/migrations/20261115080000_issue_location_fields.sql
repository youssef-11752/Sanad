-- Store the selected city and address on an unassigned customer issue.
alter table public.issues
  add column if not exists city_id integer
  references public.cities(id);

alter table public.issues
  add column if not exists address text;
