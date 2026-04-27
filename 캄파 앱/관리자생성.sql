-- ════════════════════════════════════
-- KAMFA 관리자 계정 강제 생성/리셋
-- Supabase SQL Editor에서 그대로 실행하세요
-- ════════════════════════════════════

-- 1) 필요한 컬럼이 모두 있는지 보장
alter table users add column if not exists is_admin boolean default false;
alter table users add column if not exists user_status text default 'active';
alter table users add column if not exists pw_hash text default '';
alter table users add column if not exists name text default '';

-- 2) 기존 admin 계정이 있다면 모두 삭제 (깨끗하게 다시 만들기 위해)
delete from users where email = 'admin@kamfa.co.kr';

-- 3) 관리자 계정 새로 INSERT
insert into users (email, pw_hash, name, phone, region, is_admin, user_status, intro)
values (
  'admin@kamfa.co.kr',
  'Kamfa2026!Admin',
  '최고관리자',
  '01000000000',
  '서울',
  true,
  'active',
  'KAMFA 시스템 관리자'
);

-- 4) 정상 생성 확인
select id, email, pw_hash, name, is_admin, user_status
from users
where email = 'admin@kamfa.co.kr';
