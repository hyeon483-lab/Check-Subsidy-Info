-- =============================================================================
-- 전국 확대 5차 배치 (2026년 기준): 결혼·출산 카테고리 공백 보완
-- 광주(출산), 세종·강원·제주·전북·경북·경남(결혼), 충북(출산)
--
-- 확인 불가로 이번 배치에서 제외한 항목 (시·도 단위 공식 수치 미확인):
--   - 전남 결혼: 무안군 등 개별 시·군 단위 사업만 확인됨 (도 통합 사업 없음)
--   - 충남 결혼: 서산시·당진시 등 개별 시·군 단위 사업만 확인됨 (도 통합 사업 없음)
--   - 울산 결혼/출산, 충북 결혼, 강원 출산: 구·군 단위 사업만 확인됨 (앞선 조사에서 제외)
-- =============================================================================

-- 광주형 아이키움 출산축하금 (birth)
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
  'gwangju-igiwoom-birth-grant',
  '광주형 아이키움 출산축하금',
  '광주광역시에 거주하며 출산한 가정에 지역화폐인 광주상생카드로 축하금을 지급하는 제도입니다.',
  r.id, c.id,
  '신생아의 출생일 기준으로 광주광역시에 주민등록을 두고 거주하는 가정이 대상입니다.',
  '출생아 1인당 50만원을 광주상생카드(지역화폐)로 일시금 지급합니다.',
  '출생신고하는 관할 자치구 행정복지센터 또는 정부24를 통해 신청합니다.',
  array['출생신고 관련 서류', '주민등록등본'],
  array['광주상생카드로 지급되므로 사용 가능한 가맹점을 미리 확인하세요', '국가 지원 첫만남이용권과는 별도로 받을 수 있는 광주시 자체 지원금입니다'],
  '[]'::jsonb,
  '광주광역시 여성가족국', 'https://www.gwangju.go.kr/',
  null, null, null, null,
  null, null, true,
  '광주광역시 공식 홈페이지 및 언론 보도 기준 정리', current_date, true,
  'gwangju-igiwoom-birth-grant', 2026, true
from regions r, categories c
where r.slug = 'gwangju' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 세종 청년·신혼부부 주택임차보증금 이자지원 (marriage)
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
  'sejong-newlywed-jeonse-interest-support',
  '세종 청년·신혼부부 주택임차보증금 이자지원',
  '세종시에 거주하는 청년·신혼부부가 주택 임차보증금 대출을 받을 때 이자를 지원하는 제도입니다.',
  r.id, c.id,
  '세종시에 거주하거나 거주 예정인 청년 또는 신혼부부로, 주택 임차보증금 대출을 받은 가구가 대상입니다.',
  '대출한도 최대 1억원까지, 최대 연 4.1%의 이자를 지원합니다. 실제 지원율은 협약은행 대출금리와 소득 구간에 따라 달라집니다.',
  '세종시 또는 협약은행(세종시 공고 확인)을 통해 신청합니다.',
  array['임대차계약서', '가족관계증명서(신혼부부의 경우)', '대출 관련 서류'],
  array['대출한도(1억원)와 최대 지원 이자율(연 4.1%)은 협약은행별로 다를 수 있으니 미리 확인하세요', '청년과 신혼부부의 세부 자격 요건이 다를 수 있습니다'],
  '[]'::jsonb,
  '세종시 청년정책과', 'https://www.sejong.go.kr/',
  null, null, null, '신혼부부',
  null, null, true,
  '세종시 공고 및 언론 보도 기준 정리', current_date, true,
  'sejong-newlywed-jeonse-interest-support', 2026, true
from regions r, categories c
where r.slug = 'sejong' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 강원 신혼부부 전월세 대출이자 지원 (marriage)
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
  'gangwon-newlywed-jeonse-interest-support',
  '강원 신혼부부 전월세 대출이자 지원',
  '강원특별자치도에 거주하는 신혼부부가 전월세 보증금 대출을 받을 때 이자를 지원하는 제도입니다.',
  r.id, c.id,
  '강원특별자치도에 거주하거나 거주 예정인 신혼부부로, 전월세 임차보증금 대출을 받은 가구가 대상입니다.',
  '대출잔액 1억원 한도 내에서 연 3.0%의 이자를 최대 2년간 지원합니다.',
  '강원특별자치도 또는 협약은행을 통해 신청합니다.',
  array['혼인관계증명서', '임대차계약서', '대출 관련 서류'],
  array['대출잔액 1억원 한도를 넘지 않는지 확인하세요', '지원 기간이 최대 2년으로 한정되어 있습니다'],
  '[]'::jsonb,
  '강원특별자치도 청년정책과', 'https://www.provin.gangwon.kr/',
  null, null, null, '신혼부부',
  null, null, true,
  '강원특별자치도 공고 및 언론 보도 기준 정리', current_date, true,
  'gangwon-newlywed-jeonse-interest-support', 2026, true
from regions r, categories c
where r.slug = 'gangwon' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 제주 신혼·출산가구 주택전세대출 이자지원 (marriage)
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
  'jeju-newlywed-birth-jeonse-interest-support',
  '제주 신혼·출산가구 주택전세대출 이자지원',
  '제주에 거주하는 신혼부부 및 출산가구가 주택전세자금 대출을 받을 때 이자를 지원하는 제도입니다.',
  r.id, c.id,
  '제주특별자치도에 거주하거나 거주 예정인 신혼부부 또는 출산가구로, 주택전세자금 대출을 받은 가구가 대상입니다.',
  '일반 가구는 연 1.5%(최대 150만원), 다자녀 등 우대 가구는 연 2%(최대 190만원)까지 이자를 지원합니다.',
  '제주특별자치도 또는 협약은행을 통해 신청합니다.',
  array['혼인관계증명서 또는 출생신고 관련 서류', '전세계약서', '대출 관련 서류'],
  array['다자녀 등 우대 요건에 해당하는지 미리 확인하면 더 높은 지원율을 받을 수 있습니다', '일반 가구와 우대 가구의 지원 한도가 다릅니다'],
  '[]'::jsonb,
  '제주특별자치도 여성가족청소년과', 'https://www.jeju.go.kr/',
  null, null, null, '신혼부부',
  null, null, true,
  '제주특별자치도 공식 홈페이지 및 언론 보도 기준 정리', current_date, true,
  'jeju-newlywed-birth-jeonse-interest-support', 2026, true
from regions r, categories c
where r.slug = 'jeju' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 충북 출산육아수당 지원 (birth)
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
  'chungbuk-childcare-birthday-allowance',
  '충북 출산육아수당',
  '충청북도에 거주하는 자녀가 만 1세부터 6세가 될 때까지 생일마다 육아수당을 지급하는 제도입니다.',
  r.id, c.id,
  '충청북도에 거주하며 만 1~6세 자녀를 양육하는 가정이 대상입니다.',
  '자녀가 1세부터 6세가 되는 생일마다 100~200만원씩 지급하며, 6년간 총 1,000만원을 지원합니다.',
  '관할 읍면동 행정복지센터 또는 정부24를 통해 신청합니다.',
  array['가족관계증명서', '주민등록등본'],
  array['생일마다 지급되므로 매해 별도로 신청 시기를 챙겨야 합니다', '충청북도 내 거주를 계속 유지해야 지급이 이어집니다'],
  '[]'::jsonb,
  '충청북도 저출생정책과', 'https://www.chungbuk.go.kr/',
  null, 1, 6, null,
  null, null, true,
  '충청북도 공고 및 언론 보도 기준 정리', current_date, true,
  'chungbuk-childcare-birthday-allowance', 2026, true
from regions r, categories c
where r.slug = 'chungbuk' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 전북 신혼부부 전세자금 대출이자지원 (marriage)
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
  'jeonbuk-newlywed-jeonse-interest-support',
  '전북 신혼부부 전세자금 대출이자지원',
  '전북특별자치도에 거주하는 신혼부부가 전세자금 대출을 받을 때 이자를 지원하는 제도입니다.',
  r.id, c.id,
  '전북특별자치도에 거주하거나 거주 예정인 신혼부부로, 전세자금 대출을 받은 가구가 대상입니다.',
  '최대 150만원까지 대출이자를 지원합니다.',
  '전북특별자치도 또는 협약은행을 통해 신청합니다.',
  array['혼인관계증명서', '전세계약서', '대출 관련 서류'],
  array['지원 한도(최대 150만원)를 초과하는 이자는 지원되지 않습니다', '협약은행을 통한 대출인지 미리 확인하세요'],
  '[]'::jsonb,
  '전북특별자치도 청년정책과', 'https://www.jeonbuk.go.kr/',
  null, null, null, '신혼부부',
  null, null, true,
  '전북특별자치도 공고 및 언론 보도 기준 정리', current_date, true,
  'jeonbuk-newlywed-jeonse-interest-support', 2026, true
from regions r, categories c
where r.slug = 'jeonbuk' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 경북 신혼부부 임차보증금 이자지원사업 (marriage)
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
  'gyeongbuk-newlywed-deposit-interest-support',
  '경북 신혼부부 임차보증금 이자지원사업',
  '경상북도에 거주하는 신혼부부가 임차보증금 대출을 받을 때 이자를 지원하는 제도로, 자녀 수에 따라 지원율이 늘어납니다.',
  r.id, c.id,
  '경상북도에 거주하거나 거주 예정인 신혼부부로, 임차보증금 대출을 받은 가구가 대상입니다.',
  '대출한도 2억원 이내에서 최대 연 1.5%의 이자를 지원하며, 자녀 수에 따라 지원율이 가산됩니다.',
  '경상북도 또는 협약은행을 통해 신청합니다.',
  array['혼인관계증명서', '임대차계약서', '대출 관련 서류'],
  array['대출한도 2억원을 넘지 않는지 확인하세요', '자녀가 많을수록 지원율이 가산되니 가족관계증명서를 함께 준비하세요'],
  '[]'::jsonb,
  '경상북도 청년정책과', 'https://www.gb.go.kr/',
  null, null, null, '신혼부부',
  null, null, true,
  '경상북도 공고 및 언론 보도 기준 정리', current_date, true,
  'gyeongbuk-newlywed-deposit-interest-support', 2026, true
from regions r, categories c
where r.slug = 'gyeongbuk' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 경남 신혼부부 및 출산가구 주택구입 대출이자 지원 (marriage)
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
  'gyeongnam-newlywed-birth-home-purchase-interest-support',
  '경남 신혼부부 및 출산가구 주택구입 대출이자 지원',
  '경상남도에 거주하는 신혼부부 및 출산가구가 주택구입 대출을 받을 때 이자를 지원하는 제도입니다.',
  r.id, c.id,
  '경상남도에 거주하거나 거주 예정인 신혼부부 또는 출산가구로, 주택구입 대출을 받은 가구가 대상입니다.',
  '신혼부부는 연 최대 150만원을 지원하며, 출산가구는 자녀 1인당 30만원이 추가로 가산됩니다.',
  '경상남도 또는 협약은행을 통해 신청합니다.',
  array['혼인관계증명서 또는 출생신고 관련 서류', '주택 매매계약서', '대출 관련 서류'],
  array['출산가구는 자녀 수에 따라 지원액이 가산되니 가족관계증명서를 함께 준비하세요', '전세가 아닌 주택 구입 대출에 한정된 지원입니다'],
  '[]'::jsonb,
  '경상남도 청년정책과', 'https://www.gyeongnam.go.kr/',
  null, null, null, '신혼부부',
  null, null, true,
  '경상남도 공고 및 언론 보도 기준 정리', current_date, true,
  'gyeongnam-newlywed-birth-home-purchase-interest-support', 2026, true
from regions r, categories c
where r.slug = 'gyeongnam' and c.slug = 'marriage'
on conflict (slug) do nothing;
