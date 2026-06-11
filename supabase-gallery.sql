-- גלריית תמונות לאתר החתונה
-- הריצו ב-SQL Editor בדשבורד Supabase (אחרי supabase-storage.sql)

create table if not exists gallery_images (
  id uuid primary key default gen_random_uuid(),
  caption text,
  storage_path text not null,
  mime_type text,
  sort_order int default 0,
  created_at timestamptz default now()
);

alter table gallery_images enable row level security;

drop policy if exists "public_all_gallery_images" on gallery_images;
create policy "public_all_gallery_images" on gallery_images
  for all using (true) with check (true);

notify pgrst, 'reload schema';
