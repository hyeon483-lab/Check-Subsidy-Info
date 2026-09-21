-- =============================================================================
-- 샘플/예시 시드 데이터입니다.
-- 실제 서비스 오픈 전 공공데이터포털 "지자체복지서비스" API 등에서 받은
-- 검증된 데이터로 반드시 교체하세요. (source_name = '예시 데이터'로 표시된 항목)
-- 개발 중 UI/쿼리 구조를 확인하기 위한 용도입니다.
-- =============================================================================

-- regions --------------------------------------------------------------------
insert into regions (slug, name, level, parent_id) values
  ('seoul', '서울특별시', 'sido', null),
  ('gyeonggi', '경기도', 'sido', null),
  ('incheon', '인천광역시', 'sido', null)
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'seoul-gangnam', '강남구', 'sigungu', id from regions where slug = 'seoul'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'seoul-mapo', '마포구', 'sigungu', id from regions where slug = 'seoul'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'gyeonggi-suwon', '수원시', 'sigungu', id from regions where slug = 'gyeonggi'
on conflict (slug) do nothing;

-- categories -------------------------------------------------------------
insert into categories (slug, name, description, sort_order) values
  ('marriage', '결혼', '결혼 준비·신혼부부를 위한 지원 제도', 1),
  ('birth', '출산·육아', '임신, 출산, 양육과 관련된 지원 제도', 2),
  ('youth', '청년', '청년(만 19~39세 내외) 대상 지원 제도', 3),
  ('housing', '주거', '전월세, 주택 구입 관련 지원 제도', 4)
on conflict (slug) do nothing;

-- benefits (예시 데이터) ---------------------------------------------------
insert into benefits (
  slug, title, summary, region_id, category_id,
  eligibility, support_content, application_method, required_documents,
  checklist, faq, agency_name, agency_url,
  income_condition, age_min, age_max, household_type,
  application_start_date, application_end_date, is_ongoing,
  source_name, source_updated_at, is_published
)
select
  'seoul-youth-rent-support',
  '서울시 청년 월세 지원 (예시)',
  '서울에 거주하는 무주택 청년의 월세 부담을 줄여주기 위한 지원 제도입니다.',
  r.id, c.id,
  '서울시에 주민등록이 되어 있고, 부모와 별도로 거주하는 만 19~39세 무주택 청년이면 신청할 수 있습니다.',
  '월 최대 20만원, 최장 12개월까지 월세를 지원합니다. (예시 금액이며 실제 공고 기준 확인 필요)',
  '서울주거포털 또는 정부24에서 온라인으로 신청합니다. 접수 기간 중에만 신청이 가능합니다.',
  array['임대차계약서', '주민등록등본', '통장 사본', '소득 증빙 서류'],
  array['본인 명의 임대차계약서인지 확인하세요', '부모와 세대가 분리되어 있는지 확인하세요', '기존에 다른 주거 지원을 받고 있지 않은지 확인하세요'],
  '[{"question": "재학생도 신청할 수 있나요?", "answer": "재학 여부와 관계없이 연령·거주 요건을 충족하면 신청할 수 있는 경우가 많습니다. 공고문에서 정확한 기준을 확인하세요."}]'::jsonb,
  '서울시 청년정책담당관',
  null,
  '기준 중위소득 150% 이하 (예시)',
  19, 39, '1인가구',
  null, null, true,
  '예시 데이터', null, true
from regions r, categories c
where r.slug = 'seoul' and c.slug = 'housing'
on conflict (slug) do nothing;

insert into benefits (
  slug, title, summary, region_id, category_id,
  eligibility, support_content, application_method, required_documents,
  checklist, faq, agency_name, agency_url,
  income_condition, age_min, age_max, household_type,
  application_start_date, application_end_date, is_ongoing,
  source_name, source_updated_at, is_published
)
select
  'seoul-newlywed-loan-interest',
  '서울시 신혼부부 전세자금 대출이자 지원 (예시)',
  '전세자금 대출을 받은 서울 거주 신혼부부에게 이자의 일부를 지원합니다.',
  r.id, c.id,
  '혼인신고 후 7년 이내이거나 3개월 내 결혼 예정인 부부로, 서울시에 거주(예정)해야 합니다.',
  '대출금 최대 2억원에 대해 연 최대 3.0%p 이내로 이자를 지원합니다. (예시 수치)',
  '서울주거포털에서 온라인 신청 후 서류 심사를 거칩니다.',
  array['혼인관계증명서', '전세임대차계약서', '대출 관련 서류', '소득 증빙 서류'],
  array['부부합산 소득 기준을 충족하는지 확인하세요', '보증금 및 대출한도 기준을 확인하세요'],
  '[]'::jsonb,
  '서울시 주택정책과',
  null,
  '부부합산 연소득 1억 3천만원 이하 (예시)',
  null, null, '신혼부부',
  null, null, true,
  '예시 데이터', null, true
from regions r, categories c
where r.slug = 'seoul' and c.slug = 'marriage'
on conflict (slug) do nothing;

insert into benefits (
  slug, title, summary, region_id, category_id,
  eligibility, support_content, application_method, required_documents,
  checklist, faq, agency_name, agency_url,
  income_condition, age_min, age_max, household_type,
  application_start_date, application_end_date, is_ongoing,
  source_name, source_updated_at, is_published
)
select
  'gyeonggi-basic-income-youth',
  '경기도 청년 기본소득 (예시)',
  '경기도에 일정 기간 거주한 청년에게 분기별 지역화폐를 지급합니다.',
  r.id, c.id,
  '신청일 기준 경기도에 3년 이상 계속 거주했거나 합산 10년 이상 거주한 만 24세 청년입니다.',
  '분기별 25만원(연 최대 100만원)을 해당 시군 지역화폐로 지급합니다. (예시 수치)',
  '경기민원24 홈페이지에서 온라인으로 신청합니다.',
  array['주민등록초본(주소이력 포함)'],
  array['거주 이력이 요건을 충족하는지 초본으로 미리 확인하세요', '분기별 신청 기간을 놓치지 않도록 알림을 설정하세요'],
  '[]'::jsonb,
  '경기도 청년복지정책과',
  null,
  null,
  24, 24, '무관',
  null, null, true,
  '예시 데이터', null, true
from regions r, categories c
where r.slug = 'gyeonggi' and c.slug = 'youth'
on conflict (slug) do nothing;

insert into benefits (
  slug, title, summary, region_id, category_id,
  eligibility, support_content, application_method, required_documents,
  checklist, faq, agency_name, agency_url,
  income_condition, age_min, age_max, household_type,
  application_start_date, application_end_date, is_ongoing,
  source_name, source_updated_at, is_published
)
select
  'incheon-birth-grant',
  '인천시 출산장려금 (예시)',
  '인천에 거주하며 출산한 가정에 첫째부터 장려금을 지급합니다.',
  r.id, c.id,
  '출생일 기준 인천시에 주민등록을 두고 있는 가정이면 신청할 수 있습니다.',
  '첫째 100만원, 둘째 이상은 금액이 상향됩니다. (예시 수치이며 자치구별로 다를 수 있음)',
  '거주지 주민센터 방문 또는 정부24 온라인 신청이 가능합니다.',
  array['출생신고 관련 서류', '주민등록등본', '통장 사본'],
  array['출생신고를 먼저 완료했는지 확인하세요', '거주 중인 구청/군청의 별도 조례 지원금도 함께 확인하세요'],
  '[]'::jsonb,
  '인천시 아동보육과',
  null,
  null,
  null, null, '무관',
  null, null, true,
  '예시 데이터', null, true
from regions r, categories c
where r.slug = 'incheon' and c.slug = 'birth'
on conflict (slug) do nothing;
