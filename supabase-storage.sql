-- Supabase Storage לקבצי החתונה
-- הריצו ב-SQL Editor בדשבורד Supabase

insert into storage.buckets (id, name, public)
values ('wedding-files', 'wedding-files', false)
on conflict (id) do nothing;

drop policy if exists "wedding_files_select" on storage.objects;
drop policy if exists "wedding_files_insert" on storage.objects;
drop policy if exists "wedding_files_delete" on storage.objects;

create policy "wedding_files_select" on storage.objects
  for select using (bucket_id = 'wedding-files');

create policy "wedding_files_insert" on storage.objects
  for insert with check (bucket_id = 'wedding-files');

create policy "wedding_files_delete" on storage.objects
  for delete using (bucket_id = 'wedding-files');
