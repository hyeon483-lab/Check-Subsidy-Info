-- Check Subsidy Info: initial schema
-- regions: 시/도, 시/군/구 2-level hierarchy
create table if not exists regions (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  name text not null,
  level text not null check (level in ('sido', 'sigungu')),
  parent_id uuid references regions(id) on delete cascade,
  created_at timestamptz not null default now()
);

create index if not exists regions_parent_id_idx on regions(parent_id);

-- categories: 생애 이벤트 기준 (결혼, 출산, 청년, 주거 ...)
create table if not exists categories (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  name text not null,
  description text,
  sort_order int not null default 0,
  created_at timestamptz not null default now()
);

-- benefits: 지원금/혜택 상세
create table if not exists benefits (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  title text not null,
  summary text not null,
  region_id uuid not null references regions(id) on delete restrict,
  category_id uuid not null references categories(id) on delete restrict,

  -- 원문을 그대로 옮기지 않고 자체 가공한 필드들
  eligibility text not null,          -- 자격 조건 (쉬운 말 요약)
  support_content text not null,      -- 지원 내용
  application_method text not null,   -- 신청 방법
  required_documents text[] not null default '{}',
  checklist text[] not null default '{}',   -- 신청 전 체크리스트
  faq jsonb not null default '[]',          -- [{question, answer}]

  agency_name text not null,          -- 담당 기관
  agency_url text,                    -- 공식 신청/안내 페이지 (외부 링크)

  income_condition text,              -- 소득 조건 요약 (구간 텍스트, 숫자 개인정보 저장 안 함)
  age_min int,
  age_max int,
  household_type text,                -- 예: '신혼부부', '1인가구', '무관'

  application_start_date date,
  application_end_date date,
  is_ongoing boolean not null default false, -- 상시 접수 여부

  source_name text not null default '지자체 복지서비스 공공데이터',
  source_updated_at date,

  is_published boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists benefits_region_id_idx on benefits(region_id);
create index if not exists benefits_category_id_idx on benefits(category_id);
create index if not exists benefits_is_published_idx on benefits(is_published);
create index if not exists benefits_application_end_date_idx on benefits(application_end_date);

-- updated_at 자동 갱신
create or replace function set_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

drop trigger if exists benefits_set_updated_at on benefits;
create trigger benefits_set_updated_at
  before update on benefits
  for each row execute function set_updated_at();

-- RLS: 공개 데이터이므로 익명 사용자에게 published 항목만 읽기 허용
alter table regions enable row level security;
alter table categories enable row level security;
alter table benefits enable row level security;

create policy "regions are publicly readable"
  on regions for select
  using (true);

create policy "categories are publicly readable"
  on categories for select
  using (true);

create policy "published benefits are publicly readable"
  on benefits for select
  using (is_published = true);
