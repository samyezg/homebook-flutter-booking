-- HomeBook core tables (text client ids; standalone schema)

create table if not exists public.services (
  id text primary key,
  name text not null,
  category text not null,
  description text,
  price_cents integer not null,
  duration_minutes integer not null,
  provider_id text not null,
  image_url text,
  created_at timestamptz not null default timezone('utc', now())
);

create table if not exists public.providers (
  id text primary key,
  user_id uuid references auth.users (id) on delete set null,
  name text not null,
  avatar_url text,
  rating_avg numeric(3,2) not null default 5.0,
  rating_count integer not null default 0,
  bio text,
  services_offered text[] not null default '{}'
);

create table if not exists public.bookings (
  id text primary key,
  user_id uuid not null references auth.users (id) on delete cascade,
  provider_id text not null references public.providers (id),
  service_id text not null references public.services (id),
  service_name text not null,
  scheduled_at timestamptz not null,
  status text not null default 'pending'
    check (status in ('pending', 'accepted', 'in_progress', 'completed', 'cancelled')),
  address text not null,
  notes text not null default '',
  total_cents integer not null,
  created_at timestamptz not null default timezone('utc', now())
);

create index if not exists bookings_user_id_scheduled_at_idx
  on public.bookings (user_id, scheduled_at desc);

create index if not exists bookings_provider_id_status_idx
  on public.bookings (provider_id, status);

create table if not exists public.reviews (
  id text primary key,
  booking_id text not null unique references public.bookings (id) on delete cascade,
  user_id uuid not null references auth.users (id) on delete cascade,
  provider_id text not null references public.providers (id),
  rating integer not null check (rating >= 1 and rating <= 5),
  comment text not null default '',
  created_at timestamptz not null default timezone('utc', now())
);

alter table public.services enable row level security;
alter table public.providers enable row level security;
alter table public.bookings enable row level security;
alter table public.reviews enable row level security;

-- Catalog: readable by everyone; writes via SQL seed / dashboard
drop policy if exists services_select_all on public.services;
create policy services_select_all
  on public.services for select to anon, authenticated
  using (true);

drop policy if exists providers_select_all on public.providers;
create policy providers_select_all
  on public.providers for select to anon, authenticated
  using (true);

drop policy if exists providers_update_own on public.providers;
create policy providers_update_own
  on public.providers for update to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- Bookings: customer owns row; linked provider can read/update status
drop policy if exists bookings_select_own_or_provider on public.bookings;
create policy bookings_select_own_or_provider
  on public.bookings for select to authenticated
  using (
    auth.uid() = user_id
    or exists (
      select 1 from public.providers p
      where p.id = provider_id and p.user_id = auth.uid()
    )
  );

drop policy if exists bookings_insert_own on public.bookings;
create policy bookings_insert_own
  on public.bookings for insert to authenticated
  with check (auth.uid() = user_id);

drop policy if exists bookings_update_own_or_provider on public.bookings;
create policy bookings_update_own_or_provider
  on public.bookings for update to authenticated
  using (
    auth.uid() = user_id
    or exists (
      select 1 from public.providers p
      where p.id = provider_id and p.user_id = auth.uid()
    )
  )
  with check (
    auth.uid() = user_id
    or exists (
      select 1 from public.providers p
      where p.id = provider_id and p.user_id = auth.uid()
    )
  );

drop policy if exists bookings_delete_own on public.bookings;
create policy bookings_delete_own
  on public.bookings for delete to authenticated
  using (auth.uid() = user_id);

-- Reviews: author CRUD; others can read provider reviews
drop policy if exists reviews_select_authenticated on public.reviews;
create policy reviews_select_authenticated
  on public.reviews for select to authenticated
  using (true);

drop policy if exists reviews_insert_own on public.reviews;
create policy reviews_insert_own
  on public.reviews for insert to authenticated
  with check (auth.uid() = user_id);

drop policy if exists reviews_update_own on public.reviews;
create policy reviews_update_own
  on public.reviews for update to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists reviews_delete_own on public.reviews;
create policy reviews_delete_own
  on public.reviews for delete to authenticated
  using (auth.uid() = user_id);

grant usage on schema public to anon, authenticated;
grant select on table public.services to anon, authenticated;
grant select on table public.providers to anon, authenticated;
grant update on table public.providers to authenticated;
grant select, insert, update, delete on table public.bookings to authenticated;
grant select, insert, update, delete on table public.reviews to authenticated;

-- Seed catalog (English canonical; matches Mock ids)
insert into public.providers (id, name, rating_avg, rating_count, bio, services_offered)
values
  ('prov-zhang', 'Master Zhang', 4.9, 128, 'Ten years in home care — deep cleaning and home organization.', array['svc-deep-clean','svc-daily-clean']),
  ('prov-li', 'Master Li', 4.8, 86, 'Licensed plumbing & electrical repairs. On-time visits.', array['svc-pipe-repair','svc-elec-repair']),
  ('prov-wang', 'Wang · Paint', 4.7, 42, 'Interior refresh and partial painting. Local Kunming crew.', array['svc-paint']),
  ('prov-chen', 'Master Chen', 4.6, 55, 'Residential moves and furniture disassembly. Per-truck quotes available.', array['svc-moving'])
on conflict (id) do nothing;

insert into public.services (
  id, name, category, description, price_cents, duration_minutes, provider_id
)
values
  ('svc-deep-clean', 'Deep Cleaning', 'cleaning', 'Whole-home deep clean — ideal before move-in or holiday hosting.', 8800, 120, 'prov-zhang'),
  ('svc-daily-clean', 'Daily Cleaning', 'cleaning', 'Routine upkeep to keep the home tidy.', 4800, 60, 'prov-zhang'),
  ('svc-pipe-repair', 'Plumbing Repair', 'repair', 'Leaks, clogs, and fitting swaps — on-site diagnosis.', 12000, 60, 'prov-li'),
  ('svc-elec-repair', 'Electrical Repair', 'repair', 'Outlets, breakers, and lighting circuit checks.', 15000, 60, 'prov-li'),
  ('svc-paint', 'Interior Painting', 'renovation', 'Single room or partial wall refresh (materials billed separately).', 200000, 1440, 'prov-wang'),
  ('svc-moving', 'Moving Help', 'moving', 'Same-city residential move with basic hauling (note oversized items).', 30000, 120, 'prov-chen')
on conflict (id) do nothing;
