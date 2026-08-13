create table if not exists public.passbook_entries (id bigint primary key, room_id text not null, person smallint not null check (person in (0,1)), type text not null check (type in ('right','wrong')), points integer not null check (points between 1 and 99), description text not null, event_date date not null, created_at timestamptz not null default now());
create index if not exists passbook_entries_room_id_idx on public.passbook_entries (room_id, event_date, created_at);
alter table public.passbook_entries enable row level security;
grant select, insert, update, delete on table public.passbook_entries to anon, authenticated;
create policy "passbook room read" on public.passbook_entries for select to anon, authenticated using (room_id = '7d4b0d7e-4f55-4d1f-9e8b-5a8d6d1c2b90');
create policy "passbook room insert" on public.passbook_entries for insert to anon, authenticated with check (room_id = '7d4b0d7e-4f55-4d1f-9e8b-5a8d6d1c2b90');
create policy "passbook room update" on public.passbook_entries for update to anon, authenticated using (room_id = '7d4b0d7e-4f55-4d1f-9e8b-5a8d6d1c2b90') with check (room_id = '7d4b0d7e-4f55-4d1f-9e8b-5a8d6d1c2b90');
create policy "passbook room delete" on public.passbook_entries for delete to anon, authenticated using (room_id = '7d4b0d7e-4f55-4d1f-9e8b-5a8d6d1c2b90');
alter publication supabase_realtime add table public.passbook_entries;