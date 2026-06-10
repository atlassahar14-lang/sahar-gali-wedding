-- תיקון עמודות חסרות (הריצו ב-SQL Editor אחרי יצירת הטבלאות)
-- מתקן: Could not find the 'phone' column of 'guests' in the schema cache

alter table guests add column if not exists phone text;
alter table guests add column if not exists count int default 1;
alter table guests add column if not exists days text;
alter table guests add column if not exists status text default 'מגיע';
alter table guests add column if not exists transfer text;
alter table guests add column if not exists notes text;
alter table guests add column if not exists room_id uuid;
alter table guests add column if not exists created_at timestamptz default now();

alter table rooms add column if not exists building text;
alter table rooms add column if not exists capacity int default 2;
alter table rooms add column if not exists notes text;
alter table rooms add column if not exists created_at timestamptz default now();

alter table expenses add column if not exists cat text;
alter table expenses add column if not exists total numeric default 0;
alter table expenses add column if not exists paid numeric default 0;
alter table expenses add column if not exists status text;
alter table expenses add column if not exists created_at timestamptz default now();

alter table tasks add column if not exists due date;
alter table tasks add column if not exists cat text;
alter table tasks add column if not exists done boolean default false;
alter table tasks add column if not exists created_at timestamptz default now();

alter table files add column if not exists size text;
alter table files add column if not exists date text;
alter table files add column if not exists file_date text;
alter table files add column if not exists storage_path text;
alter table files add column if not exists mime_type text;
alter table files add column if not exists data text;
alter table files add column if not exists created_at timestamptz default now();

alter table content add column if not exists title text;
alter table content add column if not exists wedding_date text;
alter table content add column if not exists msg text;
alter table content add column if not exists budget_total numeric default 0;
insert into content (id) values (1) on conflict (id) do nothing;

alter table suppliers add column if not exists company text;
alter table suppliers add column if not exists cat text;
alter table suppliers add column if not exists phone text;
alter table suppliers add column if not exists email text;
alter table suppliers add column if not exists origin text;
alter table suppliers add column if not exists lodging text default 'לא';
alter table suppliers add column if not exists transfer text default 'לא';
alter table suppliers add column if not exists status text;
alter table suppliers add column if not exists arrival date;
alter table suppliers add column if not exists notes text;
alter table suppliers add column if not exists created_at timestamptz default now();

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
alter table suppliers enable row level security;
drop policy if exists "public_all_suppliers" on suppliers;
create policy "public_all_suppliers" on suppliers for all using (true) with check (true);

-- רענון cache של Supabase API
notify pgrst, 'reload schema';
