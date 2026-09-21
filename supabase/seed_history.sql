-- =============================================================================
-- 연도별 히스토리 데이터 (0002_benefit_history.sql 마이그레이션 이후 실행)
-- 각 제도의 과거 연도 기록입니다. is_current = false로 저장되어 목록에는
-- 노출되지 않고, 상세 페이지의 "연도별 변경 이력"에서만 연결됩니다.
--
-- 조사 범위 밖이라 확인하지 못한 내용은 추정해서 채우지 않고 그대로 비워두거나
-- "확인되지 않음"으로 표기했습니다. 실제 서비스에서는 각 기관에 재확인하세요.
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 서울시 청년 월세 지원 (program_slug: seoul-youth-rent-support)
-- -----------------------------------------------------------------------------
insert into benefits (
  slug, title, summary, region_id, category_id,
  eligibility, support_content, application_method, required_documents,
  checklist, faq, agency_name, agency_url,
  income_condition, age_min, age_max, household_type,
  application_start_date, application_end_date, is_ongoing,
  source_name, source_updated_at, is_published,
  program_slug, fiscal_year, is_current
)
select
  'seoul-youth-rent-support-2025',
  '서울시 청년 월세 지원 (2025년)',
  '2025년에 시행된 서울시 청년 월세 지원 제도입니다. 약 1만 5천명 규모로 8월부터 지원이 시작되었습니다.',
  r.id, c.id,
  '신청일 기준 서울시 주민등록을 둔 만 19~39세 무주택 1인가구 청년으로, 부모와 따로 거주 중이며 가구 기준 중위소득 48% 초과 150% 이하여야 했습니다. 임차보증금 8천만원 이하·월세 60만원 이하 주택(또는 보증금 환산액과 월세 합계 93만원 이하) 거주자만 해당했으며, 국토부 청년월세 한시특별지원 수령자·공공임대주택 거주자·부모 소유 주택 임차인은 제외됐습니다.',
  '월 최대 20만원씩 최장 12개월(최대 240만원)을 지원했습니다.',
  '서울주거포털에서 자가진단 후 온라인으로 접수했습니다. 2025년 모집은 이미 종료되었습니다.',
  array['임대차계약서', '월세 이체 내역', '가족관계증명서', '소득 증빙서류'],
  array['이 페이지는 2025년도 종료된 모집 정보입니다', '최신 연도 신청 조건은 현재 페이지를 확인하세요'],
  '[]'::jsonb,
  '서울시 청년정책담당관', 'https://housing.seoul.go.kr/',
  '기준 중위소득 48% 초과 150% 이하', 19, 39, '1인가구',
  null, null, false,
  '서울주거포털 공고 및 언론 보도 기준 정리 (과거 연도 기록)', current_date, true,
  'seoul-youth-rent-support', 2025, false
from regions r, categories c
where r.slug = 'seoul' and c.slug = 'housing'
on conflict (slug) do nothing;

insert into benefits (
  slug, title, summary, region_id, category_id,
  eligibility, support_content, application_method, required_documents,
  checklist, faq, agency_name, agency_url,
  income_condition, age_min, age_max, household_type,
  application_start_date, application_end_date, is_ongoing,
  source_name, source_updated_at, is_published,
  program_slug, fiscal_year, is_current
)
select
  'seoul-youth-rent-support-2024',
  '서울시 청년 월세 지원 (2024년)',
  '2024년에 시행된 서울시 청년 월세 지원 제도입니다.',
  r.id, c.id,
  '신청일 기준 서울시 주민등록을 둔 만 19~39세 무주택 1인가구 청년으로, 부모와 따로 거주 중이며 가구 기준 중위소득 48% 초과 150% 이하여야 했습니다. 임차보증금 8천만원 이하·월세 60만원 이하 주택(또는 보증금 환산액과 월세 합계 93만원 이하) 거주자만 해당했으며, 국토부 청년월세 한시특별지원 수령자·공공임대주택 거주자·부모 소유 주택 임차인은 제외됐습니다.',
  '월 최대 20만원씩 최장 12개월(최대 240만원)을 지원했습니다.',
  '서울주거포털에서 자가진단 후 온라인으로 접수했습니다. 2024년 모집은 이미 종료되었습니다.',
  array['임대차계약서', '월세 이체 내역', '가족관계증명서', '소득 증빙서류'],
  array['이 페이지는 2024년도 종료된 모집 정보입니다', '최신 연도 신청 조건은 현재 페이지를 확인하세요'],
  '[]'::jsonb,
  '서울시 청년정책담당관', 'https://housing.seoul.go.kr/',
  '기준 중위소득 48% 초과 150% 이하', 19, 39, '1인가구',
  null, null, false,
  '서울주거포털 공고 및 언론 보도 기준 정리 (과거 연도 기록)', current_date, true,
  'seoul-youth-rent-support', 2024, false
from regions r, categories c
where r.slug = 'seoul' and c.slug = 'housing'
on conflict (slug) do nothing;

insert into benefits (
  slug, title, summary, region_id, category_id,
  eligibility, support_content, application_method, required_documents,
  checklist, faq, agency_name, agency_url,
  income_condition, age_min, age_max, household_type,
  application_start_date, application_end_date, is_ongoing,
  source_name, source_updated_at, is_published,
  program_slug, fiscal_year, is_current
)
select
  'seoul-youth-rent-support-2023',
  '서울시 청년 월세 지원 (2023년)',
  '2023년에 시행된 서울시 청년 월세 지원 제도입니다.',
  r.id, c.id,
  '신청일 기준 서울시 주민등록을 둔 만 19~39세 무주택 1인가구 청년으로, 부모와 따로 거주 중이며 가구 기준 중위소득 48% 초과 150% 이하여야 했습니다. 임차보증금 8천만원 이하·월세 60만원 이하 주택(또는 보증금 환산액과 월세 합계 93만원 이하) 거주자만 해당했으며, 국토부 청년월세 한시특별지원 수령자·공공임대주택 거주자·부모 소유 주택 임차인은 제외됐습니다.',
  '월 최대 20만원씩 최장 12개월(최대 240만원)을 지원했습니다.',
  '서울주거포털에서 자가진단 후 온라인으로 접수했습니다. 2023년 모집은 이미 종료되었습니다.',
  array['임대차계약서', '월세 이체 내역', '가족관계증명서', '소득 증빙서류'],
  array['이 페이지는 2023년도 종료된 모집 정보입니다', '최신 연도 신청 조건은 현재 페이지를 확인하세요'],
  '[]'::jsonb,
  '서울시 청년정책담당관', 'https://housing.seoul.go.kr/',
  '기준 중위소득 48% 초과 150% 이하', 19, 39, '1인가구',
  null, null, false,
  '서울주거포털 공고 및 언론 보도 기준 정리 (과거 연도 기록)', current_date, true,
  'seoul-youth-rent-support', 2023, false
from regions r, categories c
where r.slug = 'seoul' and c.slug = 'housing'
on conflict (slug) do nothing;

insert into benefits (
  slug, title, summary, region_id, category_id,
  eligibility, support_content, application_method, required_documents,
  checklist, faq, agency_name, agency_url,
  income_condition, age_min, age_max, household_type,
  application_start_date, application_end_date, is_ongoing,
  source_name, source_updated_at, is_published,
  program_slug, fiscal_year, is_current
)
select
  'seoul-youth-rent-support-2022',
  '서울시 청년 월세 지원 (2022년)',
  '서울시 청년 월세 지원 사업이 본격적으로 시행된 첫 해입니다. 2022년 11월부터 월세 지원이 시작되었습니다.',
  r.id, c.id,
  '신청일 기준 서울시 주민등록을 둔 만 19~39세 무주택 1인가구 청년으로, 부모와 따로 거주 중이며 가구 기준 중위소득 48% 초과 150% 이하여야 했습니다. 임차보증금 8천만원 이하·월세 60만원 이하 주택 거주자만 해당했습니다.',
  '2022년 11월부터 월 최대 20만원씩 12개월분(최대 240만원)을 지원했습니다.',
  '서울주거포털에서 자가진단 후 온라인으로 접수했습니다. 2022년 모집은 이미 종료되었습니다.',
  array['임대차계약서', '월세 이체 내역', '가족관계증명서', '소득 증빙서류'],
  array['이 페이지는 2022년도 종료된 모집 정보입니다', '최신 연도 신청 조건은 현재 페이지를 확인하세요'],
  '[]'::jsonb,
  '서울시 청년정책담당관', 'https://housing.seoul.go.kr/',
  '기준 중위소득 48% 초과 150% 이하', 19, 39, '1인가구',
  null, null, false,
  '서울주거포털 공고 및 언론 보도 기준 정리 (과거 연도 기록)', current_date, true,
  'seoul-youth-rent-support', 2022, false
from regions r, categories c
where r.slug = 'seoul' and c.slug = 'housing'
on conflict (slug) do nothing;

-- -----------------------------------------------------------------------------
-- 서울시 신혼부부 임차보증금 이자지원 (program_slug: seoul-newlywed-loan-interest)
-- -----------------------------------------------------------------------------
insert into benefits (
  slug, title, summary, region_id, category_id,
  eligibility, support_content, application_method, required_documents,
  checklist, faq, agency_name, agency_url,
  income_condition, age_min, age_max, household_type,
  application_start_date, application_end_date, is_ongoing,
  source_name, source_updated_at, is_published,
  program_slug, fiscal_year, is_current
)
select
  'seoul-newlywed-loan-interest-2025',
  '서울시 신혼부부 임차보증금 이자지원 (2025년)',
  '2025년 기준 서울시 신혼부부 임차보증금 이자지원 제도입니다.',
  r.id, c.id,
  '대출신청일 기준 혼인신고 7년 이내이거나 6개월 이내 결혼 예정인 신혼(예비)부부로, 부부합산 연소득 1억 3천만원 이하이며 본인과 배우자 모두 무주택자여야 했습니다.',
  '임차보증금 7억원 이하 주택에 대해 보증금의 90% 이내, 최대 3억원까지 대출 이자를 지원했습니다.',
  '서울주거포털에서 대상자 여부를 확인한 뒤 협약은행에서 대출을 신청했습니다.',
  array['혼인관계증명서(또는 예비부부 증빙 서류)', '임대차계약서', '부부합산 소득 증빙서류', '무주택 확인서류'],
  array['이 페이지는 2025년도 기록입니다', '최신 연도 조건은 현재 페이지를 확인하세요'],
  '[]'::jsonb,
  '서울시 주택정책과', 'https://housing.seoul.go.kr/site/main/content/sh01_0400800',
  '부부합산 연소득 1억 3천만원 이하', null, null, '신혼부부',
  null, null, true,
  '서울주거포털 공고 및 언론 보도 기준 정리 (과거 연도 기록)', current_date, true,
  'seoul-newlywed-loan-interest', 2025, false
from regions r, categories c
where r.slug = 'seoul' and c.slug = 'marriage'
on conflict (slug) do nothing;

insert into benefits (
  slug, title, summary, region_id, category_id,
  eligibility, support_content, application_method, required_documents,
  checklist, faq, agency_name, agency_url,
  income_condition, age_min, age_max, household_type,
  application_start_date, application_end_date, is_ongoing,
  source_name, source_updated_at, is_published,
  program_slug, fiscal_year, is_current
)
select
  'seoul-newlywed-loan-interest-2024',
  '서울시 신혼부부 임차보증금 이자지원 (2024년)',
  '2024년 기준 서울시 신혼부부 임차보증금 이자지원 제도입니다. 전년도 5월 확대된 3억원 한도가 그대로 유지되었습니다.',
  r.id, c.id,
  '대출신청일 기준 혼인신고 7년 이내이거나 6개월 이내 결혼 예정인 신혼(예비)부부로, 부부합산 연소득 1억 3천만원 이하이며 본인과 배우자 모두 무주택자여야 했습니다.',
  '임차보증금 7억원 이하 주택에 대해 보증금의 90% 이내, 최대 3억원까지 대출 이자를 지원했습니다.',
  '서울주거포털에서 대상자 여부를 확인한 뒤 협약은행에서 대출을 신청했습니다.',
  array['혼인관계증명서(또는 예비부부 증빙 서류)', '임대차계약서', '부부합산 소득 증빙서류', '무주택 확인서류'],
  array['이 페이지는 2024년도 기록입니다', '최신 연도 조건은 현재 페이지를 확인하세요'],
  '[]'::jsonb,
  '서울시 주택정책과', 'https://housing.seoul.go.kr/site/main/content/sh01_0400800',
  '부부합산 연소득 1억 3천만원 이하', null, null, '신혼부부',
  null, null, true,
  '서울주거포털 공고 및 언론 보도 기준 정리 (과거 연도 기록, 소득기준 정확한 변경일은 미확인)', current_date, true,
  'seoul-newlywed-loan-interest', 2024, false
from regions r, categories c
where r.slug = 'seoul' and c.slug = 'marriage'
on conflict (slug) do nothing;

insert into benefits (
  slug, title, summary, region_id, category_id,
  eligibility, support_content, application_method, required_documents,
  checklist, faq, agency_name, agency_url,
  income_condition, age_min, age_max, household_type,
  application_start_date, application_end_date, is_ongoing,
  source_name, source_updated_at, is_published,
  program_slug, fiscal_year, is_current
)
select
  'seoul-newlywed-loan-interest-2023',
  '서울시 신혼부부 임차보증금 이자지원 (2023년)',
  '2023년 5월 2일 대출한도가 2억원에서 3억원으로 상향된 해입니다.',
  r.id, c.id,
  '대출신청일 기준 혼인신고 7년 이내이거나 6개월 이내 결혼 예정인 신혼(예비)부부가 대상이었습니다.',
  '2023년 5월 1일까지는 대출한도가 최대 2억원이었으나, 5월 2일 신청 건부터 임차보증금의 90% 이내, 최대 3억원으로 상향되었습니다.',
  '서울주거포털에서 대상자 여부를 확인한 뒤 협약은행에서 대출을 신청했습니다.',
  array['혼인관계증명서(또는 예비부부 증빙 서류)', '임대차계약서', '부부합산 소득 증빙서류', '무주택 확인서류'],
  array['이 페이지는 2023년도 기록입니다', '5월 2일 전후로 대출한도가 달랐던 해입니다', '최신 연도 조건은 현재 페이지를 확인하세요'],
  '[]'::jsonb,
  '서울시 주택정책과', 'https://housing.seoul.go.kr/site/main/content/sh01_0400800',
  '2023년 5월 이전 부부합산 연소득 9,700만원 이하 → 이후 완화', null, null, '신혼부부',
  null, null, true,
  '서울주거포털 공고 및 언론 보도 기준 정리 (과거 연도 기록)', current_date, true,
  'seoul-newlywed-loan-interest', 2023, false
from regions r, categories c
where r.slug = 'seoul' and c.slug = 'marriage'
on conflict (slug) do nothing;

insert into benefits (
  slug, title, summary, region_id, category_id,
  eligibility, support_content, application_method, required_documents,
  checklist, faq, agency_name, agency_url,
  income_condition, age_min, age_max, household_type,
  application_start_date, application_end_date, is_ongoing,
  source_name, source_updated_at, is_published,
  program_slug, fiscal_year, is_current
)
select
  'seoul-newlywed-loan-interest-2022',
  '서울시 신혼부부 임차보증금 이자지원 (2022년)',
  '2022년 기준 서울시 신혼부부 임차보증금 이자지원 제도입니다. 이 시기 대출한도는 최대 2억원이었습니다.',
  r.id, c.id,
  '대출신청일 기준 혼인신고 7년 이내이거나 6개월 이내 결혼 예정인 신혼(예비)부부로, 부부합산 연소득 9,700만원 이하이며 본인과 배우자 모두 무주택자여야 했습니다.',
  '임차보증금 7억원 이하 주택에 대해 보증금의 90% 이내, 최대 2억원까지 대출 이자를 지원했습니다.',
  '서울주거포털에서 대상자 여부를 확인한 뒤 협약은행에서 대출을 신청했습니다.',
  array['혼인관계증명서(또는 예비부부 증빙 서류)', '임대차계약서', '부부합산 소득 증빙서류', '무주택 확인서류'],
  array['이 페이지는 2022년도 기록입니다', '대출한도가 현재보다 낮았던 해입니다', '최신 연도 조건은 현재 페이지를 확인하세요'],
  '[]'::jsonb,
  '서울시 주택정책과', 'https://housing.seoul.go.kr/site/main/content/sh01_0400800',
  '부부합산 연소득 9,700만원 이하', null, null, '신혼부부',
  null, null, true,
  '서울주거포털 공고 및 언론 보도 기준 정리 (과거 연도 기록)', current_date, true,
  'seoul-newlywed-loan-interest', 2022, false
from regions r, categories c
where r.slug = 'seoul' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- -----------------------------------------------------------------------------
-- 경기도 청년기본소득 (program_slug: gyeonggi-basic-income-youth)
-- -----------------------------------------------------------------------------
insert into benefits (
  slug, title, summary, region_id, category_id,
  eligibility, support_content, application_method, required_documents,
  checklist, faq, agency_name, agency_url,
  income_condition, age_min, age_max, household_type,
  application_start_date, application_end_date, is_ongoing,
  source_name, source_updated_at, is_published,
  program_slug, fiscal_year, is_current
)
select
  'gyeonggi-basic-income-youth-2025',
  '경기도 청년기본소득 (2025년)',
  '2025년 기준 경기도 청년기본소득 제도입니다. 이 해부터 성남시와 고양시가 지급 대상에서 제외되었습니다.',
  r.id, c.id,
  '신청일 기준 경기도에 주민등록을 둔 만 24세 청년 중 최근 3년 이상 계속 거주했거나 합산 10년 이상 거주한 경우 신청할 수 있었습니다. 2025년에는 성남시와 고양시가 신청 대상에서 제외되었습니다.',
  '분기별 25만원씩 연 최대 100만원을 지역화폐로 지급했습니다.',
  '경기청년포털과 연계된 "잡아바 어플라이"에서 온라인으로 신청했습니다.',
  array['신분증(본인 확인용)', '주민등록초본(마이데이터 미동의 시)'],
  array['이 페이지는 2025년도 기록입니다', '최신 연도 제외 지역은 현재 페이지를 확인하세요'],
  '[]'::jsonb,
  '경기도 청년복지정책과', 'https://youth.gg.go.kr/',
  null, 24, 24, '무관',
  null, null, true,
  '경기청년포털 공고 및 언론 보도 기준 정리 (과거 연도 기록)', current_date, true,
  'gyeonggi-basic-income-youth', 2025, false
from regions r, categories c
where r.slug = 'gyeonggi' and c.slug = 'youth'
on conflict (slug) do nothing;

insert into benefits (
  slug, title, summary, region_id, category_id,
  eligibility, support_content, application_method, required_documents,
  checklist, faq, agency_name, agency_url,
  income_condition, age_min, age_max, household_type,
  application_start_date, application_end_date, is_ongoing,
  source_name, source_updated_at, is_published,
  program_slug, fiscal_year, is_current
)
select
  'gyeonggi-basic-income-youth-2024',
  '경기도 청년기본소득 (2024년)',
  '2024년 기준 경기도 청년기본소득 제도입니다. 성남시(조례 폐지)와 의정부시(예산 미편성)가 지급 대상에서 제외되었습니다.',
  r.id, c.id,
  '신청일 기준 경기도에 주민등록을 둔 만 24세 청년 중 최근 3년 이상 계속 거주했거나 합산 10년 이상 거주한 경우 신청할 수 있었습니다. 2024년에는 성남시(조례 폐지)와 의정부시(예산 미편성)가 신청 대상에서 제외되었습니다.',
  '분기별 25만원씩 연 최대 100만원을 지역화폐로 지급했습니다.',
  '경기청년포털과 연계된 "잡아바 어플라이"에서 온라인으로 신청했습니다.',
  array['신분증(본인 확인용)', '주민등록초본(마이데이터 미동의 시)'],
  array['이 페이지는 2024년도 기록입니다', '최신 연도 제외 지역은 현재 페이지를 확인하세요'],
  '[]'::jsonb,
  '경기도 청년복지정책과', 'https://youth.gg.go.kr/',
  null, 24, 24, '무관',
  null, null, true,
  '경기청년포털 공고 및 언론 보도 기준 정리 (과거 연도 기록)', current_date, true,
  'gyeonggi-basic-income-youth', 2024, false
from regions r, categories c
where r.slug = 'gyeonggi' and c.slug = 'youth'
on conflict (slug) do nothing;

insert into benefits (
  slug, title, summary, region_id, category_id,
  eligibility, support_content, application_method, required_documents,
  checklist, faq, agency_name, agency_url,
  income_condition, age_min, age_max, household_type,
  application_start_date, application_end_date, is_ongoing,
  source_name, source_updated_at, is_published,
  program_slug, fiscal_year, is_current
)
select
  'gyeonggi-basic-income-youth-2023',
  '경기도 청년기본소득 (2023년)',
  '2023년 기준 경기도 청년기본소득 제도입니다.',
  r.id, c.id,
  '신청일 기준 경기도에 주민등록을 둔 만 24세 청년 중 최근 3년 이상 계속 거주했거나 합산 10년 이상 거주한 경우 신청할 수 있었습니다. 이번 조사에서는 이 해의 별도 제외 지자체 정보를 확인하지 못했습니다. 정확한 내용은 경기도청에 문의하세요.',
  '분기별 25만원씩 연 최대 100만원을 지역화폐로 지급했습니다.',
  '경기청년포털과 연계된 신청 채널에서 온라인으로 신청했습니다.',
  array['신분증(본인 확인용)', '주민등록초본(마이데이터 미동의 시)'],
  array['이 페이지는 2023년도 기록입니다', '제외 지역 정보는 이번 조사에서 확인되지 않았습니다'],
  '[]'::jsonb,
  '경기도 청년복지정책과', 'https://youth.gg.go.kr/',
  null, 24, 24, '무관',
  null, null, true,
  '경기청년포털 공고 및 언론 보도 기준 정리 (과거 연도 기록, 제외지역 정보 미확인)', current_date, true,
  'gyeonggi-basic-income-youth', 2023, false
from regions r, categories c
where r.slug = 'gyeonggi' and c.slug = 'youth'
on conflict (slug) do nothing;

insert into benefits (
  slug, title, summary, region_id, category_id,
  eligibility, support_content, application_method, required_documents,
  checklist, faq, agency_name, agency_url,
  income_condition, age_min, age_max, household_type,
  application_start_date, application_end_date, is_ongoing,
  source_name, source_updated_at, is_published,
  program_slug, fiscal_year, is_current
)
select
  'gyeonggi-basic-income-youth-2022',
  '경기도 청년기본소득 (2022년)',
  '2022년 기준 경기도 청년기본소득 제도입니다.',
  r.id, c.id,
  '신청일 기준 경기도에 주민등록을 둔 만 24세 청년 중 최근 3년 이상 계속 거주했거나 합산 10년 이상 거주한 경우 신청할 수 있었습니다. 이번 조사에서는 이 해의 별도 제외 지자체 정보를 확인하지 못했습니다. 정확한 내용은 경기도청에 문의하세요.',
  '분기별 25만원씩 연 최대 100만원을 지역화폐로 지급했습니다.',
  '경기청년포털과 연계된 신청 채널에서 온라인으로 신청했습니다.',
  array['신분증(본인 확인용)', '주민등록초본(마이데이터 미동의 시)'],
  array['이 페이지는 2022년도 기록입니다', '제외 지역 정보는 이번 조사에서 확인되지 않았습니다'],
  '[]'::jsonb,
  '경기도 청년복지정책과', 'https://youth.gg.go.kr/',
  null, 24, 24, '무관',
  null, null, true,
  '경기청년포털 공고 및 언론 보도 기준 정리 (과거 연도 기록, 제외지역 정보 미확인)', current_date, true,
  'gyeonggi-basic-income-youth', 2022, false
from regions r, categories c
where r.slug = 'gyeonggi' and c.slug = 'youth'
on conflict (slug) do nothing;

-- -----------------------------------------------------------------------------
-- 인천시 맘편한 산후조리비 지원 (program_slug: incheon-postpartum-care-support)
-- 2025년 1월 1일 출산자부터 신규 시행된 사업이라 2025년 기록만 존재합니다.
-- -----------------------------------------------------------------------------
insert into benefits (
  slug, title, summary, region_id, category_id,
  eligibility, support_content, application_method, required_documents,
  checklist, faq, agency_name, agency_url,
  income_condition, age_min, age_max, household_type,
  application_start_date, application_end_date, is_ongoing,
  source_name, source_updated_at, is_published,
  program_slug, fiscal_year, is_current
)
select
  'incheon-postpartum-care-support-2025',
  '인천시 맘편한 산후조리비 지원 (2025년)',
  '2025년 1월 1일 출산자부터 처음 시행된 인천시 맘편한 산후조리비 지원 제도입니다.',
  r.id, c.id,
  '신청일 기준 인천시에 1년 이상 계속 주민등록을 두고 거주 중인 취약계층 산모(기초생활수급자, 차상위계층, 한부모가족, 장애인 등)가 대상이었습니다. 중앙육아종합지원센터의 부모교육(e-러닝) 이수가 필수 조건이었습니다.',
  '산모 1인당 150만원을 인천e음 지역화폐 포인트로 지급했습니다. 2025년 1월 1일 출산자부터 적용된 신규 사업입니다.',
  '임신 32주부터 출산 후 90일 이내에 거주지 관할 보건소를 통해 신청했습니다.',
  array['산모수첩 또는 임신확인서(임신 중 신청 시)', '출생신고 관련 서류(출산 후 신청 시)', '취약계층 증빙서류', '부모교육 이수 확인서'],
  array['이 제도는 2025년에 처음 시행되어 그 이전 연도 기록은 없습니다', '최신 연도 조건은 현재 페이지를 확인하세요'],
  '[]'::jsonb,
  '인천시 여성가족과 / 관할 보건소', 'https://www.incheon.go.kr/welfare/WE020355',
  '기초생활수급자·차상위계층 등 취약계층 기준', null, null, null,
  null, null, true,
  '인천광역시청 공식 홈페이지 기준 정리 (과거 연도 기록)', current_date, true,
  'incheon-postpartum-care-support', 2025, false
from regions r, categories c
where r.slug = 'incheon' and c.slug = 'birth'
on conflict (slug) do nothing;
