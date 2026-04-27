-- KAMFA server reset SQL
-- Supabase SQL Editor에서 먼저 실행하세요.

create table if not exists users (
  id bigint primary key generated always as identity,
  email text unique,
  pw_hash text default '',
  name text default '',
  phone text default '',
  phone_verified boolean default false,
  pos text default '',
  region text default '',
  foot text default '',
  height text default '',
  weight text default '',
  team_id bigint,
  team_name text default '',
  is_admin boolean default false,
  is_expro boolean default false,
  goals int default 0,
  assists int default 0,
  games int default 0,
  intro text default '',
  profile_image text default '',
  cash_balance bigint default 0,
  base_value bigint default 1000,
  grade text default '',
  age text default '',
  formation text default '',
  fav_player text default '',
  stat_pass int default 0,
  stat_speed int default 0,
  stat_power int default 0,
  stat_sense int default 0,
  created_at timestamptz default now()
);

create table if not exists teams (
  id bigint primary key generated always as identity,
  name text not null,
  region text default '',
  color text default '#1B55E8',
  description text default '',
  logo_url text default '',
  stadium text default '',
  uniform text default '',
  activity_area text default '',
  captain_id bigint,
  captain_name text default '',
  created_at timestamptz default now()
);

create table if not exists matches (
  id bigint primary key generated always as identity,
  tournament text default '',
  round text default '',
  home_team text default '',
  away_team text default '',
  home_color text default '#1B55E8',
  away_color text default '#DC2626',
  match_date text default '',
  match_time text default '',
  venue text default '',
  status text default 'upcoming',
  home_score int,
  away_score int,
  created_at timestamptz default now()
);

create table if not exists market_players (
  id bigint primary key generated always as identity,
  user_id bigint,
  name text default '',
  pos text default '',
  region text default '',
  team_name text default '',
  profile_image text default '',
  color text default '#374151',
  starting_bid bigint default 1000,
  market_status text default 'open',
  created_at timestamptz default now()
);

create table if not exists bids (
  id bigint primary key generated always as identity,
  player_id bigint,
  team_id bigint,
  team_name text default '',
  user_id bigint,
  amount bigint default 0,
  created_at timestamptz default now()
);

create table if not exists join_requests (
  id bigint primary key generated always as identity,
  team_id bigint,
  user_id bigint,
  user_name text default '',
  user_pos text default '',
  user_region text default '',
  message text default '',
  status text default 'pending',
  created_at timestamptz default now()
);

create table if not exists app_config (
  key text primary key,
  value text default ''
);

create table if not exists eval_requests (
  id bigint primary key generated always as identity,
  user_id bigint,
  name text default '',
  contact text default '',
  pos text default '',
  level text default '',
  video_link text default '',
  eval_items text default '',
  memo text default '',
  status text default 'pending',
  review_grade text default '',
  created_at timestamptz default now()
);

create table if not exists community_posts (
  id bigint primary key generated always as identity,
  category text default 'free',
  author_id bigint,
  author_name text default '',
  author_image text default '',
  title text not null,
  content text default '',
  video_url text default '',
  image_url text default '',
  link_url text default '',
  like_count int default 0,
  created_at timestamptz default now()
);

create table if not exists community_comments (
  id bigint primary key generated always as identity,
  post_id bigint not null,
  author_id bigint,
  author_name text default '',
  content text not null,
  created_at timestamptz default now()
);

create table if not exists team_invites (
  id bigint primary key generated always as identity,
  team_id bigint not null,
  team_name text default '',
  captain_id bigint,
  player_id bigint not null,
  player_name text default '',
  message text default '',
  status text default 'pending',
  created_at timestamptz default now()
);

create table if not exists market_requests (
  id bigint primary key generated always as identity,
  user_id bigint not null,
  user_name text default '',
  pos text default '',
  region text default '',
  note text default '',
  video_url text default '',
  status text default 'pending',
  created_at timestamptz default now()
);

alter table users add column if not exists phone text default '';
alter table users add column if not exists phone_verified boolean default false;
alter table users add column if not exists foot text default '';
alter table users add column if not exists intro text default '';
alter table users add column if not exists profile_image text default '';
alter table users add column if not exists cash_balance bigint default 0;
alter table users add column if not exists base_value bigint default 1000;
alter table users add column if not exists grade text default '';
alter table users add column if not exists age text default '';
alter table users add column if not exists formation text default '';
alter table users add column if not exists fav_player text default '';
alter table users add column if not exists stat_pass int default 0;
alter table users add column if not exists member_type text default 'player';
alter table users add column if not exists highlight_url text default '';
alter table users add column if not exists gallery_urls text default '';
alter table users add column if not exists stat_speed int default 0;
alter table users add column if not exists stat_power int default 0;
alter table users add column if not exists stat_sense int default 0;

alter table teams add column if not exists logo_url text default '';
alter table teams add column if not exists stadium text default '';
alter table teams add column if not exists uniform text default '';
alter table teams add column if not exists activity_area text default '';
alter table teams add column if not exists formation text default '';
alter table teams add column if not exists lineup text default '';
alter table teams add column if not exists fee text default '';
alter table teams add column if not exists team_video text default '';
alter table teams add column if not exists uniform_image text default '';
alter table teams add column if not exists history text default '';

alter table market_players add column if not exists profile_image text default '';
alter table market_players add column if not exists market_status text default 'open';
alter table market_players add column if not exists starting_bid bigint default 1000;

alter table community_posts add column if not exists user_id bigint;
alter table community_posts add column if not exists author_id bigint;
alter table community_posts add column if not exists author_name text default '';
alter table community_posts add column if not exists author_image text default '';
alter table community_posts add column if not exists category text default 'free';
alter table community_posts add column if not exists video_url text default '';
alter table community_posts add column if not exists image_url text default '';
alter table community_posts add column if not exists link_url text default '';
alter table community_posts add column if not exists like_count int default 0;

alter table eval_requests add column if not exists user_id bigint;
alter table eval_requests add column if not exists review_grade text default '';

create table if not exists chats (
  id bigint primary key generated always as identity,
  from_id bigint not null,
  to_id bigint not null,
  message text not null,
  read boolean default false,
  created_at timestamptz default now()
);
alter table chats enable row level security;
drop policy if exists public_all on public.chats;
create policy public_all on public.chats for all using (true) with check (true);
grant all on public.chats to anon, authenticated;
grant usage, select, update on sequence chats_id_seq to anon, authenticated;

create table if not exists team_chats (
  id bigint primary key generated always as identity,
  team_id bigint not null,
  user_id bigint not null,
  user_name text not null,
  user_image text default '',
  message text not null,
  created_at timestamptz default now()
);
alter table team_chats enable row level security;
grant all on team_chats to anon, authenticated;
create policy "allow all team_chats" on team_chats for all using (true) with check (true);

create table if not exists market_items (
  id bigint primary key generated always as identity,
  user_id bigint not null,
  author_name text not null,
  author_image text default '',
  title text not null,
  content text default '',
  price text default '',
  region text default '',
  image_url text default '',
  contact text default '',
  status text default 'pending',
  created_at timestamptz default now()
);
alter table market_items enable row level security;
grant all on market_items to anon, authenticated;
create policy "allow all market_items" on market_items for all using (true) with check (true);

insert into app_config (key, value) values
  ('home_ad_title', ''),
  ('home_ad_sub', ''),
  ('home_ad_image', ''),
  ('home_ad_link', ''),
  ('market_finalized_at', ''),
  ('notice', ''),
  ('hero_badge', 'KAMFA'),
  ('hero_title', '아마추어 축구의\n새로운 리그'),
  ('hero_sub', '지금 바로 시작하세요'),
  ('market_open', 'false'),
  ('market_deadline', ''),
  ('reg_open', 'true'),
  ('bgm_url', ''),
  ('news_title', ''),
  ('news_sub', ''),
  ('news_image', ''),
  ('news_link', ''),
  ('show_stats', 'false'),
  ('show_market_home', 'false'),
  ('show_transfer_nav', 'false')
on conflict (key) do nothing;

-- ── 초기 관리자 계정 (비밀번호: admin1234) ──
-- 로그인 후 반드시 비밀번호를 변경하세요.
insert into users (email, pw_hash, name, phone, phone_verified, pos, region, is_admin, goals, assists, games, cash_balance, base_value)
values ('admin@kamfa.com', 'admin1234', '관리자', '01000000000', true, '', '미설정', true, 0, 0, 0, 0, 1000)
on conflict (email) do nothing;

grant usage on schema public to anon, authenticated;
grant all on all tables in schema public to anon, authenticated;
grant usage, select, update on all sequences in schema public to anon, authenticated;

do $$
declare
  t text;
begin
  foreach t in array array[
    'users',
    'teams',
    'matches',
    'market_players',
    'bids',
    'join_requests',
    'app_config',
    'eval_requests',
    'community_posts',
    'community_comments',
    'team_invites',
    'market_requests'
  ] loop
    if to_regclass('public.' || t) is not null then
      execute format('alter table public.%I enable row level security', t);
      execute format('drop policy if exists public_all on public.%I', t);
      execute format('create policy public_all on public.%I for all using (true) with check (true)', t);
    end if;
  end loop;
end $$;

alter table users add column if not exists career text default '';

-- ── 팀 일정 투표 ──
create table if not exists team_schedules (
  id bigint primary key generated always as identity,
  team_id bigint not null,
  title text default '',
  schedule_date text default '',
  schedule_time text default '',
  venue text default '',
  deadline timestamptz,
  status text default 'open',
  created_by bigint,
  created_at timestamptz default now()
);
alter table team_schedules enable row level security;
grant all on team_schedules to anon, authenticated;
drop policy if exists "allow all team_schedules" on team_schedules;
create policy "allow all team_schedules" on team_schedules for all using (true) with check (true);
grant usage, select, update on sequence team_schedules_id_seq to anon, authenticated;

create table if not exists schedule_votes (
  id bigint primary key generated always as identity,
  schedule_id bigint not null,
  user_id bigint not null,
  user_name text default '',
  vote text default 'yes',
  created_at timestamptz default now()
);
alter table schedule_votes enable row level security;
grant all on schedule_votes to anon, authenticated;
drop policy if exists "allow all schedule_votes" on schedule_votes;
create policy "allow all schedule_votes" on schedule_votes for all using (true) with check (true);
grant usage, select, update on sequence schedule_votes_id_seq to anon, authenticated;

-- ── 팀 간 경기 신청 ──
create table if not exists match_requests (
  id bigint primary key generated always as identity,
  home_team_id bigint not null,
  home_team_name text default '',
  home_team_color text default '#1B55E8',
  away_team_id bigint not null,
  away_team_name text default '',
  away_team_color text default '#DC2626',
  match_date text default '',
  match_time text default '',
  venue text default '',
  message text default '',
  status text default 'pending',
  home_score_input int,
  away_score_input int,
  result_by_home boolean default false,
  result_by_away boolean default false,
  final_home_score int,
  final_away_score int,
  created_at timestamptz default now()
);
alter table match_requests enable row level security;
grant all on match_requests to anon, authenticated;
drop policy if exists "allow all match_requests" on match_requests;
create policy "allow all match_requests" on match_requests for all using (true) with check (true);
grant usage, select, update on sequence match_requests_id_seq to anon, authenticated;

-- ── 비밀번호 재설정 신청 ──
create table if not exists pw_reset_requests (
  id bigint primary key generated always as identity,
  name text default '',
  email text default '',
  contact text default '',
  memo text default '',
  status text default 'pending',
  temp_pw text default '',
  created_at timestamptz default now()
);
alter table pw_reset_requests enable row level security;
grant all on pw_reset_requests to anon, authenticated;
drop policy if exists "allow all pw_reset_requests" on pw_reset_requests;
create policy "allow all pw_reset_requests" on pw_reset_requests for all using (true) with check (true);
grant usage, select, update on sequence pw_reset_requests_id_seq to anon, authenticated;

-- ── 다중 사진 컬럼 ──
alter table community_posts add column if not exists image_urls text default '';
alter table market_items add column if not exists image_urls text default '';

-- ── 팀 전적 컬럼 ──
alter table teams add column if not exists wins int default 0;
alter table teams add column if not exists draws int default 0;
alter table teams add column if not exists losses int default 0;
alter table teams add column if not exists goals_for int default 0;
alter table teams add column if not exists goals_against int default 0;

-- ── 선수 능력치 DEF / PHY (직접 입력) ──
alter table users add column if not exists stat_def int default 0;
alter table users add column if not exists stat_phy int default 0;

-- ── 팀 공지사항 ──
create table if not exists team_notices (
  id bigint primary key generated always as identity,
  team_id bigint not null,
  author_id bigint,
  author_name text default '',
  title text not null,
  content text default '',
  created_at timestamptz default now()
);
alter table team_notices enable row level security;
grant all on team_notices to anon, authenticated;
drop policy if exists "allow all team_notices" on team_notices;
create policy "allow all team_notices" on team_notices for all using (true) with check (true);
grant usage, select, update on sequence team_notices_id_seq to anon, authenticated;

-- ── 팀 앨범 ──
create table if not exists team_photos (
  id bigint primary key generated always as identity,
  team_id bigint not null,
  uploader_id bigint,
  uploader_name text default '',
  image_url text not null,
  caption text default '',
  created_at timestamptz default now()
);
alter table team_photos enable row level security;
grant all on team_photos to anon, authenticated;
drop policy if exists "allow all team_photos" on team_photos;
create policy "allow all team_photos" on team_photos for all using (true) with check (true);
grant usage, select, update on sequence team_photos_id_seq to anon, authenticated;

-- ── 회원 상태 (가입 승인 시스템) ──
alter table users add column if not exists user_status text default 'active';

-- ── 가입 승인 필요 설정 (기본 ON: 관리자 승인 후 가입 활성화) ──
insert into app_config (key, value) values ('reg_approval', 'true') on conflict (key) do nothing;

-- ── 호감(❤️) 하루 1회 제한용 created_at 인덱스 ──
create index if not exists idx_user_likes_liker_day on user_likes(liker_id, created_at desc);

-- ══════════════════════════════════════════════
-- 디벨롭 추가분 (2026-04 업데이트)
-- 채팅 강화 / 매칭 고도화 / 경기 시스템
-- ══════════════════════════════════════════════

-- 채팅 메시지 타입(text/image/system) 및 첨부 URL 컬럼
alter table chats add column if not exists msg_type text default 'text';
alter table chats add column if not exists attach_url text default '';

-- 팀채팅에도 동일 필드 추가
alter table team_chats add column if not exists msg_type text default 'text';
alter table team_chats add column if not exists attach_url text default '';
alter table team_chats add column if not exists read_by jsonb default '[]'::jsonb;

-- 경기 신청(매칭) 양팀 감독 채팅을 위한 captain 캐싱
alter table match_requests add column if not exists home_captain_id bigint;
alter table match_requests add column if not exists away_captain_id bigint;
alter table match_requests add column if not exists chat_thread_id text default '';

-- MOM(Man of the Match) 투표 테이블
create table if not exists mom_votes (
  id bigint primary key generated always as identity,
  match_req_id bigint not null,
  voter_id bigint not null,
  candidate_id bigint not null,
  candidate_name text default '',
  candidate_team_id bigint,
  created_at timestamptz default now(),
  unique(match_req_id, voter_id)
);
alter table mom_votes enable row level security;
drop policy if exists "allow all mom_votes" on mom_votes;
create policy "allow all mom_votes" on mom_votes for all using (true) with check (true);
grant all on mom_votes to anon, authenticated;
grant usage, select, update on sequence mom_votes_id_seq to anon, authenticated;

-- 경기별 선수 출전·득점·도움 기록 (자동 통계 집계용)
create table if not exists match_player_stats (
  id bigint primary key generated always as identity,
  match_req_id bigint not null,
  user_id bigint not null,
  team_id bigint,
  goals int default 0,
  assists int default 0,
  yellow int default 0,
  red int default 0,
  is_mom boolean default false,
  created_at timestamptz default now()
);
alter table match_player_stats enable row level security;
drop policy if exists "allow all match_player_stats" on match_player_stats;
create policy "allow all match_player_stats" on match_player_stats for all using (true) with check (true);
grant all on match_player_stats to anon, authenticated;
grant usage, select, update on sequence match_player_stats_id_seq to anon, authenticated;

-- 용병/선수 매칭 신청 추적 (관심 표시·연락 신청)
create table if not exists merc_interests (
  id bigint primary key generated always as identity,
  post_id bigint not null,
  from_user_id bigint not null,
  from_user_name text default '',
  to_user_id bigint,
  message text default '',
  status text default 'pending',
  created_at timestamptz default now()
);
alter table merc_interests enable row level security;
drop policy if exists "allow all merc_interests" on merc_interests;
create policy "allow all merc_interests" on merc_interests for all using (true) with check (true);
grant all on merc_interests to anon, authenticated;
grant usage, select, update on sequence merc_interests_id_seq to anon, authenticated;

-- 채팅방 별 표시용 인덱스 (빠른 폴링)
create index if not exists idx_chats_to_read on chats(to_id, read);
create index if not exists idx_chats_pair on chats(from_id, to_id, created_at desc);
create index if not exists idx_team_chats_team on team_chats(team_id, created_at desc);
create index if not exists idx_match_reqs_status on match_requests(status, created_at desc);

-- ══════════════════════════════════════════════
-- 🏆 랭킹 시스템 (팀별·선수별)
-- 팀: 매칭 결과 승점 (승=3, 무=2, 패=1)
-- 선수: 스텟 + 호감(❤️) 합산
-- ══════════════════════════════════════════════

-- 선수 호감(❤️) 카운터
alter table users add column if not exists likes_count int default 0;

-- 매치 결과(스코어) 컬럼 — 랭킹 집계 기반
alter table match_requests add column if not exists home_score int;
alter table match_requests add column if not exists away_score int;
alter table match_requests add column if not exists match_result text default '';
alter table match_requests add column if not exists confirmed_at timestamptz;

-- 팀 승점 캐싱 (옵션 - 클라이언트가 실시간 집계하지만 인덱싱용)
alter table teams add column if not exists points int default 0;

-- 선수↔선수 호감(좋아요) 관계 테이블 (중복 방지)
create table if not exists user_likes (
  id bigint primary key generated always as identity,
  liker_id bigint not null,
  liked_id bigint not null,
  created_at timestamptz default now(),
  unique(liker_id, liked_id)
);
alter table user_likes enable row level security;
drop policy if exists "allow all user_likes" on user_likes;
create policy "allow all user_likes" on user_likes for all using (true) with check (true);
grant all on user_likes to anon, authenticated;
grant usage, select, update on sequence user_likes_id_seq to anon, authenticated;

-- 랭킹 폴링용 인덱스
create index if not exists idx_users_likes on users(likes_count desc);
create index if not exists idx_user_likes_liked on user_likes(liked_id);
create index if not exists idx_match_reqs_confirmed on match_requests(status) where status in ('confirmed','completed');

-- ══════════════════════════════════════════════
-- 관리자 계정 자동 생성
-- 이메일: admin@kamfa.co.kr
-- 비밀번호: Kamfa2026!Admin
-- ══════════════════════════════════════════════
insert into users (email, pw_hash, name, phone, region, is_admin, user_status, intro)
values ('admin@kamfa.co.kr', 'Kamfa2026!Admin', '최고관리자', '01000000000', '서울', true, 'active', 'KAMFA 시스템 관리자')
on conflict (email) do update
set pw_hash = excluded.pw_hash,
    is_admin = true,
    user_status = 'active',
    name = excluded.name;

-- ── 한줄평(유저 리뷰) ──
create table if not exists user_reviews (
  id bigint primary key generated always as identity,
  target_id bigint not null,
  author_id bigint not null,
  author_name text default '',
  content text default '',
  created_at timestamptz default now()
);
create index if not exists idx_user_reviews_target on user_reviews(target_id);
create index if not exists idx_user_reviews_author on user_reviews(author_id);
alter table user_reviews enable row level security;
grant all on user_reviews to anon, authenticated;
drop policy if exists "allow all user_reviews" on user_reviews;
create policy "allow all user_reviews" on user_reviews for all using (true) with check (true);
grant usage, select, update on sequence user_reviews_id_seq to anon, authenticated;

-- ── 경기기록 요청/이의제기 (match_requests에 기록 단계 추가) ──
alter table match_requests add column if not exists record_request_at timestamptz;
alter table match_requests add column if not exists record_submitted_by bigint;
alter table match_requests add column if not exists record_submitted_at timestamptz;
alter table match_requests add column if not exists auto_confirm_at timestamptz;
alter table match_requests add column if not exists record_notif_sent boolean default false;
alter table match_requests add column if not exists dispute_status text default ''; -- ''/disputed/resolved
alter table match_requests add column if not exists dispute_reason text default '';
alter table match_requests add column if not exists dispute_by bigint;
alter table match_requests add column if not exists dispute_at timestamptz;
alter table match_requests add column if not exists dispute_resolved_score_h int;
alter table match_requests add column if not exists dispute_resolved_score_a int;

-- ══════════════════════════════════════════════
-- 🛡 최종 RLS/GRANT 일괄 적용 (코드가 참조하는 모든 테이블 보장)
-- ══════════════════════════════════════════════
do $$
declare
  t text;
begin
  foreach t in array array[
    'users','teams','matches','market_players','bids','join_requests',
    'app_config','eval_requests','community_posts','community_comments',
    'team_invites','market_requests','chats','team_chats','market_items',
    'team_schedules','schedule_votes','match_requests','pw_reset_requests',
    'team_notices','team_photos','mom_votes','match_player_stats',
    'merc_interests','user_likes','user_reviews'
  ] loop
    if to_regclass('public.' || t) is not null then
      execute format('alter table public.%I enable row level security', t);
      execute format('drop policy if exists public_all on public.%I', t);
      execute format('create policy public_all on public.%I for all using (true) with check (true)', t);
      execute format('grant all on public.%I to anon, authenticated', t);
    end if;
  end loop;
end $$;

grant usage on schema public to anon, authenticated;
grant usage, select, update on all sequences in schema public to anon, authenticated;

-- 스키마 캐시 강제 새로고침 (PostgREST에 즉시 반영)
notify pgrst, 'reload schema';

select 'KAMFA DB v4 (signup-approval+daily-likes+team-page) ready' as result;
select 'Admin login: admin@kamfa.co.kr / Kamfa2026!Admin' as admin_account;
