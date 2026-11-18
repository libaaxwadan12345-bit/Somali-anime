-- SOMALI ANIME starter schema. Run once in Supabase SQL Editor.
create table if not exists public.profiles (
 id uuid primary key references auth.users(id) on delete cascade,
 email text,
 role text not null default 'user' check (role in ('user','admin')),
 created_at timestamptz default now()
);
create table if not exists public.anime (
 id uuid primary key default gen_random_uuid(),
 title text not null,
 description text,
 cover_url text,
 video_url text,
 subtitle_url text,
 genre text,
 release_year integer,
 is_featured boolean default false,
 created_at timestamptz default now()
);
create table if not exists public.favorites (
 id uuid primary key default gen_random_uuid(),
 user_id uuid references auth.users(id) on delete cascade,
 anime_id uuid references public.anime(id) on delete cascade,
 created_at timestamptz default now(),
 unique(user_id,anime_id)
);
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path=''
as $$
begin
 insert into public.profiles(id,email) values(new.id,new.email);
 return new;
end; $$;
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created after insert on auth.users
for each row execute procedure public.handle_new_user();
create or replace function public.is_admin()
returns boolean language sql security definer stable set search_path=''
as $$
 select exists(select 1 from public.profiles where id=(select auth.uid()) and role='admin');
$$;
alter table public.profiles enable row level security;
alter table public.anime enable row level security;
alter table public.favorites enable row level security;
create policy "Read own profile" on public.profiles for select to authenticated
using(id=(select auth.uid()) or (select public.is_admin()));
create policy "Admin updates profiles" on public.profiles for update to authenticated
using((select public.is_admin())) with check((select public.is_admin()));
create policy "Everyone views anime" on public.anime for select using(true);
create policy "Admin manages anime" on public.anime for all to authenticated
using((select public.is_admin())) with check((select public.is_admin()));
create policy "Users manage own favorites" on public.favorites for all to authenticated
using(user_id=(select auth.uid())) with check(user_id=(select auth.uid()));
insert into storage.buckets(id,name,public)
values('anime-posters','anime-posters',true),('anime-videos','anime-videos',true)
on conflict(id) do nothing;
create policy "Public view anime media" on storage.objects for select
using(bucket_id in ('anime-posters','anime-videos'));
create policy "Admin uploads media" on storage.objects for insert to authenticated
with check(bucket_id in ('anime-posters','anime-videos') and (select public.is_admin()));
create policy "Admin updates media" on storage.objects for update to authenticated
using(bucket_id in ('anime-posters','anime-videos') and (select public.is_admin()))
with check(bucket_id in ('anime-posters','anime-videos') and (select public.is_admin()));
create policy "Admin deletes media" on storage.objects for delete to authenticated
using(bucket_id in ('anime-posters','anime-videos') and (select public.is_admin()));
