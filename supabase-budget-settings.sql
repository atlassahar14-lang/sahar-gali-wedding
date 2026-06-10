-- הרשאות לטבלת budget_settings (הריצו ב-SQL Editor)
-- נדרש כדי ששמירת התקציב מהאתר תעבוד

alter table budget_settings enable row level security;

drop policy if exists "public_all_budget_settings" on budget_settings;
create policy "public_all_budget_settings" on budget_settings
  for all using (true) with check (true);

insert into budget_settings (id, total_budget) values (1, 0)
on conflict (id) do nothing;

notify pgrst, 'reload schema';
