-- סכמת Supabase לאתר החתונה של סהר & גלי
-- הריצו ב-SQL Editor בדשבורד Supabase

create extension if not exists "pgcrypto";

create table if not exists rooms (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  building text,
  capacity int default 2,
  notes text,
  created_at timestamptz default now()
);

create table if not exists guests (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  phone text,
  count int default 1,
  days text,
  status text default 'מגיע',
  transfer text,
  notes text,
  room_id uuid references rooms(id) on delete set null,
  created_at timestamptz default now()
);

create table if not exists expenses (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  cat text,
  total numeric default 0,
  paid numeric default 0,
  status text,
  created_at timestamptz default now()
);

create table if not exists tasks (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  due date,
  cat text,
  done boolean default false,
  created_at timestamptz default now()
);

create table if not exists files (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  size text,
  file_date text,
  mime_type text,
  data text,
  created_at timestamptz default now()
);

create table if not exists content (
  id int primary key default 1 check (id = 1),
  title text,
  wedding_date text,
  msg text,
  budget_total numeric default 0
);

insert into content (id) values (1) on conflict (id) do nothing;

create table if not exists suppliers (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  company text,
  cat text,
  phone text,
  email text,
  origin text,
  lodging text default 'לא',
  transfer text default 'לא',
  status text,
  arrival date,
  notes text,
  created_at timestamptz default now()
);

alter table rooms enable row level security;
alter table guests enable row level security;
alter table expenses enable row level security;
alter table tasks enable row level security;
alter table files enable row level security;
alter table content enable row level security;
alter table suppliers enable row level security;

drop policy if exists "public_all_rooms" on rooms;
drop policy if exists "public_all_guests" on guests;
drop policy if exists "public_all_expenses" on expenses;
drop policy if exists "public_all_tasks" on tasks;
drop policy if exists "public_all_files" on files;
drop policy if exists "public_all_content" on content;
drop policy if exists "public_all_suppliers" on suppliers;
create policy "public_all_rooms" on rooms for all using (true) with check (true);
create policy "public_all_guests" on guests for all using (true) with check (true);
create policy "public_all_expenses" on expenses for all using (true) with check (true);
create policy "public_all_tasks" on tasks for all using (true) with check (true);
create policy "public_all_files" on files for all using (true) with check (true);
create policy "public_all_content" on content for all using (true) with check (true);
create policy "public_all_suppliers" on suppliers for all using (true) with check (true);

-- אם הטבלאות נוצרו בלי כל העמודות, הריצו גם את supabase-fix-columns.sql
