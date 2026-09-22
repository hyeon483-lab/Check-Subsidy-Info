-- =============================================================================
-- 전국 확대 7차 배치 (2026년 기준): 울산·충남 결혼·출산 시군구 단위 보완
--
-- 울산광역시와 충청남도는 시·도 전역을 아우르는 통합 결혼/출산 지원 사업이
-- 없는 것으로 재확인되었습니다 (울산은 시 자체 출산지원금이 폐지됨, 충남은
-- 도비 출산장려금 자체가 없음). 대신 기존 강남구·수원시 사례와 동일한 방식으로
-- 실제로 운영 중인 시·군·구 단위 사업을 sigungu 리전으로 추가하고, 해당 사업이
-- 그 시·군에만 적용된다는 점을 제목과 안내문에 명시했습니다.
-- =============================================================================

insert into regions (slug, name, level, parent_id)
select 'ulsan-junggu', '중구', 'sigungu', id from regions where slug = 'ulsan'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'ulsan-ulju', '울주군', 'sigungu', id from regions where slug = 'ulsan'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'chungnam-boryeong', '보령시', 'sigungu', id from regions where slug = 'chungnam'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'chungnam-cheonan', '천안시', 'sigungu', id from regions where slug = 'chungnam'
on conflict (slug) do nothing;

-- 울산 중구 신혼부부 주택 전세자금 대출이자 지원 (marriage, sigungu)
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
  'ulsan-junggu-newlywed-jeonse-interest-support',
  '울산 중구 신혼부부 주택 전세자금 대출이자 지원',
  '울산광역시 중구에 거주하는 신혼부부의 전세자금 대출이자를 지원하는 제도입니다. 울산광역시 전역이 아닌 중구 자체 사업입니다.',
  r.id, c.id,
  '중구 내 동일 주소지에 주민등록을 두고 실거주하는 신혼부부로, 혼인신고 5년 이내이며 부부 모두 무주택자여야 합니다. 가구 소득이 기준중위소득 180% 이하여야 합니다.',
  '전세자금 대출 잔액의 1.5%에 해당하는 이자를 가구당 연 100만원 한도로, 연 1회씩 최대 2년간 지원합니다.',
  '주소지 관할 동 행정복지센터를 통해 신청합니다.',
  array['혼인관계증명서', '전세계약서', '대출 관련 서류', '주민등록등본'],
  array['이 제도는 울산광역시 전역이 아닌 중구 거주자만 신청할 수 있습니다', '혼인신고 후 5년이 지나면 신청할 수 없습니다', '부부 모두 무주택자여야 합니다'],
  '[]'::jsonb,
  '울산광역시 중구청', 'https://www.junggu.ulsan.kr/',
  '기준중위소득 180% 이하', null, null, '신혼부부',
  null, null, true,
  '언론 보도 및 중구청 공고 기준 정리', current_date, true,
  'ulsan-junggu-newlywed-jeonse-interest-support', 2026, true
from regions r, categories c
where r.slug = 'ulsan-junggu' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 울산 울주군 출산장려금 (birth, sigungu)
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
  'ulsan-ulju-birth-grant',
  '울산 울주군 출산장려금',
  '울산광역시 울주군에 거주하며 출산한 가정에 출산장려금을 지급하는 제도입니다. 울산광역시 전역이 아닌 울주군 자체 사업입니다.',
  r.id, c.id,
  '울주군에 주민등록을 두고 거주하며 자녀를 출산한 가정이 대상입니다.',
  '첫째아 70만원, 둘째아 250만원(5개월 분할), 셋째아 이상 500만원(10개월 분할)을 지급합니다.',
  '출생신고하는 관할 읍·면 행정복지센터를 통해 신청합니다.',
  array['출생신고 관련 서류', '주민등록등본'],
  array['이 제도는 울산광역시 전역이 아닌 울주군 거주자만 신청할 수 있습니다', '둘째아 이상은 여러 달에 걸쳐 분할 지급되니 지급 일정을 확인하세요'],
  '[]'::jsonb,
  '울산광역시 울주군청', 'https://www.ulju.ulsan.kr/',
  null, null, null, null,
  null, null, true,
  '언론 보도 및 울주군청 공고 기준 정리', current_date, true,
  'ulsan-ulju-birth-grant', 2026, true
from regions r, categories c
where r.slug = 'ulsan-ulju' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 충남 보령시 결혼장려금 (marriage, sigungu)
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
  'chungnam-boryeong-marriage-grant',
  '충남 보령시 결혼장려금',
  '충청남도 보령시에서 혼인신고한 부부에게 결혼장려금을 지급하는 제도입니다. 충청남도 전역이 아닌 보령시 자체 사업입니다.',
  r.id, c.id,
  '2025년 9월 10일 이후 혼인신고를 하고 보령시에 1년 이상 주민등록을 유지하는 부부로, 두 사람 모두 만 18~45세여야 합니다. 부부 중 한쪽만 초혼인 경우 지급액의 50%만 받을 수 있습니다.',
  '최대 300만원을 연 100만원씩 3년에 걸쳐 나누어 지급합니다.',
  '보령시청 또는 관할 읍·면·동 행정복지센터를 통해 신청합니다.',
  array['혼인관계증명서', '주민등록등본'],
  array['이 제도는 충청남도 전역이 아닌 보령시 거주자만 신청할 수 있습니다', '2025년 9월 10일 이후 혼인신고 건만 대상입니다', '한쪽만 초혼이면 지급액이 절반으로 줄어듭니다'],
  '[]'::jsonb,
  '충청남도 보령시청', 'https://www.brcn.go.kr/',
  null, 18, 45, '신혼부부',
  null, null, true,
  '언론 보도 및 보령시청 공고 기준 정리', current_date, true,
  'chungnam-boryeong-marriage-grant', 2026, true
from regions r, categories c
where r.slug = 'chungnam-boryeong' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 충남 천안시 출생축하금 (birth, sigungu)
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
  'chungnam-cheonan-birth-celebration-grant',
  '충남 천안시 출생축하금',
  '충청남도 천안시에서 출산한 가정에 출생축하금을 지급하는 제도입니다. 충청남도 전역이 아닌 천안시 자체 사업입니다.',
  r.id, c.id,
  '천안시에 주민등록을 두고 있으며, 부 또는 모가 출생일 이전 6개월 이상 계속 거주했거나 출생신고 후 6개월 이상 거주하는 가정이 대상입니다. 신청 기한은 아동의 첫 번째 생일 전날까지입니다.',
  '첫째 100만원, 둘째 100만원, 셋째아 이상 총 1,000만원을 지급합니다. 셋째아 이상은 천안시 계속 거주를 조건으로 5년에 걸쳐 분할 지급됩니다.',
  '출생신고하는 관할 읍·면·동 행정복지센터 또는 정부24를 통해 신청합니다.',
  array['출생신고 관련 서류', '주민등록등본'],
  array['이 제도는 충청남도 전역이 아닌 천안시 거주자만 신청할 수 있습니다', '신청 기한은 아동의 첫 돌 전날까지이니 놓치지 마세요', '셋째아 이상은 천안시에 계속 거주해야 5년 분할 지급이 이어집니다'],
  '[]'::jsonb,
  '충청남도 천안시청', 'https://www.cheonan.go.kr/',
  null, null, null, null,
  null, null, true,
  '경향신문 등 언론 보도 및 천안시 조례 기준 정리', current_date, true,
  'chungnam-cheonan-birth-celebration-grant', 2026, true
from regions r, categories c
where r.slug = 'chungnam-cheonan' and c.slug = 'birth'
on conflict (slug) do nothing;
