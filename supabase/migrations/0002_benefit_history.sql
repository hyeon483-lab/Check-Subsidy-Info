-- 연도별 히스토리 지원: 같은 제도의 여러 연도 버전을 program_slug로 묶고,
-- 화면에는 기본적으로 is_current = true인 최신 연도만 노출합니다.
alter table benefits
  add column if not exists fiscal_year int,
  add column if not exists program_slug text,
  add column if not exists is_current boolean not null default true;

-- 기존 행(현재 연도 데이터) 백필: program_slug = slug, fiscal_year = 2026
update benefits
set program_slug = slug,
    fiscal_year = 2026,
    is_current = true
where program_slug is null;

alter table benefits
  alter column fiscal_year set not null,
  alter column program_slug set not null;

create index if not exists benefits_program_slug_idx on benefits(program_slug);
create index if not exists benefits_fiscal_year_idx on benefits(fiscal_year);

-- 같은 제도의 같은 연도 데이터가 중복 등록되지 않도록 제약
alter table benefits
  drop constraint if exists benefits_program_slug_fiscal_year_key;
alter table benefits
  add constraint benefits_program_slug_fiscal_year_key unique (program_slug, fiscal_year);

-- 프로그램당 is_current = true는 하나만 존재해야 함 (부분 유니크 인덱스)
drop index if exists benefits_one_current_per_program_idx;
create unique index benefits_one_current_per_program_idx
  on benefits(program_slug)
  where is_current;
