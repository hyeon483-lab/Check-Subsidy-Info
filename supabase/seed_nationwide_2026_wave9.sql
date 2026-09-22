-- =============================================================================
-- 전국 확대 9차 배치 (2026년 기준): 영남권 주요 도시 6곳 확장
-- 창원시·김해시·진주시(경남), 포항시·구미시·경주시(경북)
--
-- 김해시/진주시 청년 카테고리는 조사 결과 경상남도 도 전역 사업인
-- "모다드림 청년통장"(이미 8차 배치에서 경남도 단위로 등록됨)과 동일한
-- 제도로 확인되어, 중복 등록을 피하고 각 시의 별도 제도(자격증 응시료
-- 지원 등)로 대체하거나 스킵했습니다.
-- 경주시는 청년(비주거)·결혼 카테고리에서 확인 가능한 시 전역 제도를
-- 찾지 못해 해당 카테고리를 제외했습니다.
-- =============================================================================

insert into regions (slug, name, level, parent_id)
select 'gyeongnam-changwon', '창원시', 'sigungu', id from regions where slug = 'gyeongnam'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'gyeongnam-gimhae', '김해시', 'sigungu', id from regions where slug = 'gyeongnam'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'gyeongnam-jinju', '진주시', 'sigungu', id from regions where slug = 'gyeongnam'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'gyeongbuk-pohang', '포항시', 'sigungu', id from regions where slug = 'gyeongbuk'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'gyeongbuk-gumi', '구미시', 'sigungu', id from regions where slug = 'gyeongbuk'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'gyeongbuk-gyeongju', '경주시', 'sigungu', id from regions where slug = 'gyeongbuk'
on conflict (slug) do nothing;

-- 창원형 청년통장 (youth)
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
  'changwon-youth-savings-account',
  '창원형 청년통장',
  '창원시 청년이 매달 저축하면 창원시가 동일 금액을 매칭 적립해주는 자산형성 지원 제도입니다.',
  r.id, c.id,
  '창원시에 거주하는 청년이 대상입니다. 정확한 연령·소득 기준은 창원시 청년정책 공고에서 확인할 수 있습니다.',
  '매달 15만원을 저축하면 창원시가 동일한 15만원을 매칭 적립합니다. 2년 만기 시 720만원, 3년 만기 시 1,080만원(+이자)을 받을 수 있습니다.',
  '경남 청년정보플랫폼(youth.gyeongnam.go.kr) 공고를 통해 신청합니다.',
  array['소득 증빙서류', '주민등록등본'],
  array['만기까지 꾸준히 저축을 유지해야 매칭 금액을 받을 수 있습니다', '2년형과 3년형 중 선택할 수 있는지 공고에서 확인하세요'],
  '[]'::jsonb,
  '창원시 청년정책과', 'https://www.changwon.go.kr/',
  null, null, null, null,
  null, null, false,
  '언론 보도 및 창원시 청년정책 공고 기준 정리', current_date, true,
  'changwon-youth-savings-account', 2026, true
from regions r, categories c
where r.slug = 'gyeongnam-changwon' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 창원시 신혼부부 전세자금 대출이자 지원 (marriage)
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
  'changwon-newlywed-jeonse-interest-support',
  '창원시 신혼부부 전세자금 대출이자 지원',
  '창원시에 거주하는 무주택 신혼부부의 전세자금 대출이자를 지원하는 제도입니다.',
  r.id, c.id,
  '부부 모두 창원시에 주민등록을 둔 무주택 신혼부부로, 혼인신고일이 2019년 1월 1일~2025년 12월 31일 사이여야 합니다. 기준중위소득 180% 이하(2인 가구 기준 월 707만 9,000원)여야 합니다.',
  '전세자금 대출 잔액의 1.2% 이내에서 최대 100만원을 지원하며, 자녀 1명당 20%씩 가산되어 최대 150만원까지 받을 수 있습니다.',
  '주소지 관할 읍·면·동 행정복지센터를 통해 신청합니다.',
  array['혼인관계증명서', '전세계약서', '대출 관련 서류'],
  array['2019~2025년 사이 혼인신고 건만 대상입니다', '자녀 수에 따라 지원액이 가산됩니다'],
  '[]'::jsonb,
  '창원시청', 'https://www.changwon.go.kr/',
  '기준중위소득 180% 이하 (2인가구 월 707만 9,000원)', null, null, '신혼부부',
  null, null, false,
  '창원시청 공고 및 언론 보도 기준 정리', current_date, true,
  'changwon-newlywed-jeonse-interest-support', 2026, true
from regions r, categories c
where r.slug = 'gyeongnam-changwon' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 창원시 출산축하금 (birth)
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
  'changwon-birth-celebration-grant',
  '창원시 출산축하금',
  '창원시에 거주하며 출산한 가정에 출산축하금을 지급하는 제도로, 둘째아 이상은 1년 후 추가 축하금도 받을 수 있습니다.',
  r.id, c.id,
  '출생신고일 3개월 전부터 신청일까지 창원시에 계속 주민등록을 두고 있는 가정이 대상입니다.',
  '첫째아는 출산 시 50만원을 1회 지급합니다. 둘째아 이상은 출산 시 100만원, 자녀와 1년간 계속 거주한 뒤 시민1주년 축하금 100만원을 추가로 지급해 총 200만원을 받을 수 있습니다.',
  '출생신고 후 1년 이내(시민1주년 축하금은 1년 거주 후 1년 이내)에 읍·면·동 행정복지센터를 방문해 신청합니다.',
  array['출생신고 관련 서류', '주민등록등본'],
  array['둘째아 이상은 1년 후 추가로 시민1주년 축하금을 신청해야 총 200만원을 받을 수 있습니다', '신청 기한을 놓치지 않도록 주의하세요'],
  '[]'::jsonb,
  '창원시청', 'https://www.changwon.go.kr/',
  null, null, null, null,
  null, null, true,
  '창원시청 및 정부24 기준 정리', current_date, true,
  'changwon-birth-celebration-grant', 2026, true
from regions r, categories c
where r.slug = 'gyeongnam-changwon' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 창원시 청년 월세 지원사업 (housing)
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
  'changwon-youth-rent-support',
  '창원시 청년 월세 지원사업',
  '창원시의 청년에게 월세를 지원하는 제도입니다.',
  r.id, c.id,
  '창원시에 거주하는 청년이 대상입니다. 선정 인원 제한이 있어 예산 소진 시 조기 마감될 수 있습니다.',
  '매달 최대 20만원씩 12개월(선정 시 1월분부터 소급 지급)을 지원합니다.',
  '경남바로서비스(baro.gyeongnam.go.kr) 온라인으로 신청합니다.',
  array['임대차계약서', '주민등록등본', '소득 증빙서류'],
  array['선정 인원이 제한되어 있으니 신청 기간을 놓치지 마세요', '선정되면 1월분부터 소급 지급됩니다'],
  '[]'::jsonb,
  '창원시청', 'https://www.changwon.go.kr/',
  null, null, null, null,
  null, null, false,
  '창원시청 및 언론 보도 기준 정리', current_date, true,
  'changwon-youth-rent-support', 2026, true
from regions r, categories c
where r.slug = 'gyeongnam-changwon' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 김해시 신혼부부 전월세자금 대출이자 지원 (marriage)
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
  'gimhae-newlywed-jeonse-interest-support',
  '김해시 신혼부부 전월세자금 대출이자 지원',
  '김해시에 거주하는 무주택 신혼부부의 전월세자금 대출이자를 지원하는 제도입니다.',
  r.id, c.id,
  '공고일 기준 부부가 동일 주소로 김해시에 거주하며, 혼인신고일이 2019년 1월 1일~2025년 12월 31일 사이(7년 이내)인 무주택 신혼부부가 대상입니다.',
  '전월세자금 대출 잔액의 1.5% 범위에서 연 1회 최대 150만원을 지원합니다. 2026년 621가구를 대상으로 운영됩니다.',
  '김해시청 또는 경남바로서비스를 통해 신청합니다.',
  array['혼인관계증명서', '전월세계약서', '대출 관련 서류'],
  array['혼인신고 7년 이내여야 신청할 수 있습니다', '부부가 동일 주소에 거주해야 합니다'],
  '[]'::jsonb,
  '김해시청', 'https://www.gimhae.go.kr/',
  null, null, null, '신혼부부',
  null, null, false,
  '김해시청 공고 및 언론 보도 기준 정리', current_date, true,
  'gimhae-newlywed-jeonse-interest-support', 2026, true
from regions r, categories c
where r.slug = 'gyeongnam-gimhae' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 김해시 출산축하금 (birth)
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
  'gimhae-birth-celebration-grant',
  '김해시 출산축하금',
  '김해시에서 출산한 가정에 자녀 수에 따라 차등 지급하는 출산축하금 제도로, 2026년 전면 개편되어 지급액이 인상됐습니다.',
  r.id, c.id,
  '2026년 1월 1일 이후 김해시에서 출생신고한 가정이 대상입니다.',
  '첫째아 100만원, 둘째아 150만원, 셋째아 200만원, 넷째아 300만원, 다섯째아 이상 400만원을 출생 시와 생후 12개월 시점 2회로 나누어 지급합니다.',
  '출생신고하는 관할 읍·면·동 행정복지센터 또는 정부24를 통해 신청합니다.',
  array['출생신고 관련 서류', '주민등록등본'],
  array['2026년 1월 1일 이후 출생아부터 인상된 금액이 적용됩니다', '출생 시와 생후 12개월, 2회로 나누어 지급되니 두 번째 지급 시기를 놓치지 마세요'],
  '[]'::jsonb,
  '김해시청', 'https://www.gimhae.go.kr/',
  null, null, null, null,
  null, null, true,
  '김해시청 및 언론 보도 기준 정리', current_date, true,
  'gimhae-birth-celebration-grant', 2026, true
from regions r, categories c
where r.slug = 'gyeongnam-gimhae' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 김해시 청년 월세 지원 (housing)
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
  'gimhae-youth-rent-support',
  '김해시 청년 월세 지원',
  '김해시의 무주택 청년에게 월세를 지원하는 제도로, 2025년 하반기부터 지원 연령이 45세까지 확대됐습니다.',
  r.id, c.id,
  '만 19~45세 무주택 청년으로 부모와 별도 거주해야 합니다. 김해시에 주민등록을 두고 있으며, 임차보증금 1억원 이하·월세 60만원 이하 주택에 거주해야 합니다. 가구소득은 기준중위소득 60% 초과~150% 이하여야 합니다.',
  '매달 최대 20만원씩 12개월(연 최대 240만원)을 지원합니다.',
  '경남바로서비스 온라인 또는 김해시청 인구청년정책과를 방문해 신청합니다.',
  array['임대차계약서', '주민등록등본', '소득·재산 증빙서류'],
  array['2025년 하반기부터 지원 연령이 만 45세까지 확대됐습니다', '선발 인원이 제한되어 있으니 신청 기간을 확인하세요'],
  '[]'::jsonb,
  '김해시청 인구청년정책과', 'https://www.gimhae.go.kr/',
  '기준중위소득 60% 초과~150% 이하', 19, 45, '1인가구',
  null, null, false,
  '김해시청 및 언론 보도 기준 정리', current_date, true,
  'gimhae-youth-rent-support', 2026, true
from regions r, categories c
where r.slug = 'gyeongnam-gimhae' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 진주시 청년 자격증 응시료 지원 (youth)
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
  'jinju-youth-certification-fee-support',
  '진주시 청년 자격증 응시료 지원',
  '진주시의 미취업 청년에게 자격증 시험 응시료를 지원하는 제도입니다.',
  r.id, c.id,
  '만 18~39세 미취업 청년이 대상입니다.',
  '1인당 연 최대 10만원까지 자격증 시험 응시료를 지원하며, 연 2회까지 신청할 수 있습니다.',
  '진주시청년온라인플랫폼(young.jinju.go.kr)을 통해 신청하며, 예산 소진 시 조기 마감됩니다.',
  array['자격증 시험 응시 영수증', '소득 증빙서류'],
  array['연 2회까지 신청 가능하니 영수증을 잘 보관하세요', '예산 소진 시 조기 마감될 수 있습니다'],
  '[]'::jsonb,
  '진주시청', 'https://young.jinju.go.kr/',
  null, 18, 39, null,
  null, null, false,
  '진주시청년온라인플랫폼 기준 정리', current_date, true,
  'jinju-youth-certification-fee-support', 2026, true
from regions r, categories c
where r.slug = 'gyeongnam-jinju' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 진주시 신혼부부 주택구입 대출이자 지원 (marriage)
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
  'jinju-newlywed-home-purchase-interest-support',
  '진주시 신혼부부 주택구입 대출이자 지원',
  '진주시에서 주택을 구입한 신혼부부의 대출이자를 지원하는 제도로, 요건을 충족하면 최대 5년까지 매년 재신청할 수 있습니다.',
  r.id, c.id,
  '2018년 1월 1일 이후 혼인신고한 부부로, 진주시 소재 주택을 구입해 주민등록상 거주해야 합니다. 부부합산 연소득 1억원 이하, 전용면적 85㎡ 이하, 구입가 6억원 이하 주택이 대상입니다.',
  '주택구입 대출 잔액(5,000만원 한도)의 3%를 연간 최대 150만원까지 지원하며, 요건을 충족하면 최대 5년간 매년 재신청할 수 있습니다.',
  '진주시청 주택경관과를 방문하거나 경남바로서비스 온라인으로 신청합니다.',
  array['혼인관계증명서', '주택 매매계약서', '대출 관련 서류'],
  array['최대 5년간 매년 재신청해야 계속 지원받을 수 있습니다', '혼인신고일 전후 특정 기간 내 주택을 구입해야 합니다'],
  '[]'::jsonb,
  '진주시청 주택경관과', 'https://www.jinju.go.kr/',
  '부부합산 연소득 1억원 이하', null, null, '신혼부부',
  null, null, false,
  '진주시청 및 언론 보도 기준 정리', current_date, true,
  'jinju-newlywed-home-purchase-interest-support', 2026, true
from regions r, categories c
where r.slug = 'gyeongnam-jinju' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 진주시 출산축하금 (birth)
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
  'jinju-birth-celebration-grant',
  '진주시 출산축하금',
  '진주시에서 출산한 가정에 자녀 수에 따라 차등 지급하는 출산축하금 제도입니다.',
  r.id, c.id,
  '출생신고 90일 전부터 진주시에 주소를 둔 부모가 대상입니다.',
  '첫째아 100만원, 둘째아 200만원, 셋째아 이상 최대 600만원을 지급합니다.',
  '출생일로부터 180일 이내에 방문 또는 온라인으로 신청합니다.',
  array['출생신고 관련 서류', '주민등록등본'],
  array['출생일로부터 180일 이내에 신청해야 합니다', '산모·신생아 건강관리서비스 본인부담금 90% 지원 등 다른 출산 지원도 함께 확인하세요'],
  '[]'::jsonb,
  '진주시청', 'https://www.jinju.go.kr/',
  null, null, null, null,
  null, null, true,
  '진주시청 보도자료 기준 정리', current_date, true,
  'jinju-birth-celebration-grant', 2026, true
from regions r, categories c
where r.slug = 'gyeongnam-jinju' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 진주시 청년월세 지원사업 (housing)
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
  'jinju-youth-rent-support',
  '진주시 청년월세 지원사업',
  '진주시의 무취업 청년에게 월세를 지원하는 제도로, 생애 1회만 받을 수 있습니다.',
  r.id, c.id,
  '만 18~39세 무취업 청년으로 부모와 별도 거주해야 합니다. 진주시에 주민등록을 두고 있으며, 가구소득은 기준중위소득 60~150%, 임차보증금 1억원 이하·월세 60만원 이하 주택에 거주해야 합니다.',
  '매달 최대 20만원씩 최대 12개월을 지원하며, 생애 1회만 받을 수 있습니다.',
  '경남바로서비스 온라인 또는 행정복지센터를 방문해 신청합니다.',
  array['임대차계약서', '주민등록등본', '소득 증빙서류'],
  array['생애 1회만 지원받을 수 있습니다', '부모와 별도로 거주해야 합니다'],
  '[]'::jsonb,
  '진주시청', 'https://www.jinju.go.kr/',
  '기준중위소득 60~150%', 18, 39, '1인가구',
  null, null, false,
  '진주시청년온라인플랫폼 및 언론 보도 기준 정리', current_date, true,
  'jinju-youth-rent-support', 2026, true
from regions r, categories c
where r.slug = 'gyeongnam-jinju' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 포항시 청년도전지원사업 (youth)
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
  'pohang-youth-challenge-support',
  '포항시 청년도전지원사업',
  '포항시의 장기 미취업 청년에게 구직 프로그램 참여 단계별로 활동비를 지원하는 제도입니다.',
  r.id, c.id,
  '최근 6개월 이상 취업·교육·직업훈련 이력이 없는 만 18~34세 포항시 거주 청년이 대상입니다.',
  '프로그램 참여수당, 이수 인센티브, 구직활동 인센티브 등을 단계별로 지급하며, 최대 350만원까지 받을 수 있습니다.',
  '포항시 청년정책 공고를 통해 신청합니다.',
  array['미취업 확인서류', '주민등록등본'],
  array['최근 6개월 이상 취업·교육·훈련 이력이 없어야 신청할 수 있습니다', '프로그램 단계별로 지급액이 달라집니다'],
  '[]'::jsonb,
  '포항시청', 'https://www.pohang.go.kr/',
  null, 18, 34, null,
  null, null, false,
  '언론 보도 기준 정리', current_date, true,
  'pohang-youth-challenge-support', 2026, true
from regions r, categories c
where r.slug = 'gyeongbuk-pohang' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 포항시 청년 신혼부부 월세 지원사업 (marriage)
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
  'pohang-newlywed-rent-support',
  '포항시 청년 신혼부부 월세 지원사업',
  '포항시의 무주택 신혼부부에게 월세를 최대 2년간 지원하는 제도로, 부부합산 소득 구간에 따라 지원액이 달라집니다.',
  r.id, c.id,
  '신청일 기준 부부 모두 만 19~39세, 혼인신고일 5년 이내인 무주택 신혼부부가 대상입니다. 부부합산 연소득 6,000만원 이하, 임차보증금 5,000만원 이하·월세 80만원 이하 주택에 거주하며 포항시에 주민등록을 두어야 합니다.',
  '6개월 단위로 최대 2년간, 부부합산 소득 구간에 따라 차등 지급하며 매달 최대 30만원(연간 최대 360만원)을 지원합니다.',
  '경상북도주거복지시스템(gbhome.kr) 온라인으로만 신청할 수 있습니다.',
  array['혼인관계증명서', '임대차계약서', '소득 증빙서류'],
  array['온라인 신청만 가능하니 gbhome.kr에서 접수하세요', '부부합산 소득 구간에 따라 지원액이 달라집니다'],
  '[]'::jsonb,
  '포항시청', 'https://www.pohang.go.kr/',
  '부부합산 연소득 6,000만원 이하', 19, 39, '신혼부부',
  null, null, false,
  '언론 보도 기준 정리', current_date, true,
  'pohang-newlywed-rent-support', 2026, true
from regions r, categories c
where r.slug = 'gyeongbuk-pohang' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 포항시 출산장려금 (birth)
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
  'pohang-birth-grant',
  '포항시 출산장려금',
  '포항시에서 출산한 가정에 자녀 수에 따라 차등 지급하는 출산장려금 제도로, 2026년 조례 개정으로 지급액이 인상됐습니다.',
  r.id, c.id,
  '포항시에 거주하며 출산한 가정이 대상입니다.',
  '첫째아 100만원, 둘째아 290만원, 셋째아 410만원, 넷째아 1,130만원, 다섯째아 이상 1,130만원을 지급합니다.',
  '출생신고하는 관할 읍·면·동 행정복지센터 또는 정부24를 통해 신청합니다.',
  array['출생신고 관련 서류', '주민등록등본'],
  array['2026년 4월 22일 조례 개정으로 금액이 인상됐습니다', '3자녀 이상 가구는 주택구입 대출이자 지원 등 추가 혜택도 함께 확인하세요'],
  '[]'::jsonb,
  '포항시청', 'https://www.pohang.go.kr/',
  null, null, null, null,
  null, null, true,
  '언론 보도 기준 정리', current_date, true,
  'pohang-birth-grant', 2026, true
from regions r, categories c
where r.slug = 'gyeongbuk-pohang' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 포항시 청년월세 지원사업 (housing)
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
  'pohang-youth-rent-support',
  '포항시 청년월세 지원사업',
  '포항시의 무주택 청년에게 월세를 최대 24개월간 지원하는 제도로, 생애 1회만 받을 수 있습니다.',
  r.id, c.id,
  '만 19~34세 부모와 별도 거주하는 무주택 청년으로, 청년가구 소득이 기준중위소득 60% 이하, 원가구 소득이 기준중위소득 100% 이하여야 합니다. 청년가구 재산 1억 2,200만원 이하, 원가구 재산 4억 7,000만원 이하여야 합니다.',
  '매달 최대 20만원씩 최대 24개월을 지원하며, 생애 1회만 받을 수 있습니다.',
  '복지로(bokjiro.go.kr) 온라인 또는 행정복지센터를 방문해 신청합니다.',
  array['임대차계약서', '가족관계증명서', '소득·재산 증빙서류'],
  array['생애 1회만 지원받을 수 있습니다', '원가구(부모 포함) 소득·재산 기준도 함께 충족해야 합니다'],
  '[]'::jsonb,
  '포항시청', 'https://www.pohang.go.kr/',
  '청년가구 중위소득 60% 이하 & 원가구 중위소득 100% 이하', 19, 34, '1인가구',
  null, null, false,
  '언론 보도 기준 정리', current_date, true,
  'pohang-youth-rent-support', 2026, true
from regions r, categories c
where r.slug = 'gyeongbuk-pohang' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 구미시 청년 취업준비금·월세·학업장려금 패키지 (youth)
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
  'gumi-youth-package-support',
  '구미시 청년 취업준비금·월세·학업장려금 패키지',
  '구미시의 청년에게 취업준비금, 월세, 학업장려금을 묶어서 지원하는 2026년 청년정책 패키지입니다.',
  r.id, c.id,
  '구미시에 거주하는 청년이 대상입니다. 세부 연령·소득 기준은 구미시 청년정책 공고에서 확인할 수 있습니다.',
  '취업준비금 35만원, 월세 240만원, 학업장려금 80만원을 합쳐 최대 355만원을 지원합니다.',
  '구미시청 통합예약시스템 온라인 또는 청년정책 공고를 통해 신청합니다.',
  array['소득 증빙서류', '재학·재직 관련 서류'],
  array['취업준비금·월세·학업장려금 3개 항목을 각각 신청해야 할 수 있으니 공고를 자세히 확인하세요'],
  '[]'::jsonb,
  '구미시청', 'https://www.gumi.go.kr/',
  null, null, null, null,
  null, null, false,
  '언론 보도 기준 정리', current_date, true,
  'gumi-youth-package-support', 2026, true
from regions r, categories c
where r.slug = 'gyeongbuk-gumi' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 구미형 청년근로자 결혼장려금 (marriage)
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
  'gumi-marriage-encouragement-grant',
  '구미형 청년근로자 결혼장려금',
  '구미시에서 근로하는 청년의 결혼을 지원하기 위해 지역화폐로 축하금을 지급하는 제도입니다.',
  r.id, c.id,
  '부부 중 1명이 만 30세 이상, 부부 모두 만 45세 이하이며, 2025년 1월 1일 이후 혼인신고한 부부가 대상입니다. 부부 중 1명이 신청일 기준 최근 6개월간 48일 이상 근로하거나 90일 이상 개인사업을 유지하며 구미시에 거주·근로해야 합니다.',
  '구미사랑상품권 100만원을 최초 신청 시 50만원, 6개월 후 2차 신청 시 50만원으로 나누어 지급합니다. 소규모 예식(하객 100명 이하) 진행 시 부대비용도 최대 300만원까지 별도 지원합니다.',
  '혼인신고일로부터 3~12개월 이내에 주소지 관할 읍·면·동 행정복지센터를 통해 신청합니다.',
  array['혼인관계증명서', '근로 또는 사업 유지 증빙서류'],
  array['혼인신고 후 3~12개월 이내에만 신청할 수 있습니다', '최초 신청과 6개월 후 2차 신청, 2번에 나누어 지급됩니다'],
  '[]'::jsonb,
  '구미시청', 'https://www.gumi.go.kr/',
  null, null, 45, '신혼부부',
  null, null, false,
  '언론 보도 기준 정리', current_date, true,
  'gumi-marriage-encouragement-grant', 2026, true
from regions r, categories c
where r.slug = 'gyeongbuk-gumi' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 구미시 출산축하금 (birth)
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
  'gumi-birth-celebration-grant',
  '구미시 출산축하금',
  '구미시에서 출산한 가정에 자녀 수에 따라 차등 지급하는 출산축하금 제도입니다.',
  r.id, c.id,
  '구미시에 거주하며 출산한 가정이 대상입니다.',
  '첫째아 150만원, 둘째아 200만원, 셋째아 300만원, 넷째아 400만원, 다섯째아 이상 500만원을 지급합니다.',
  '출생신고 후 90일 이내에 온라인 또는 읍·면·동 주민센터를 방문해 신청합니다.',
  array['출생신고 관련 서류', '주민등록등본'],
  array['출생신고 후 90일 이내에 신청해야 합니다', '산후조리비 30만원, 다자녀가정 이사비 등 추가 지원도 함께 확인하세요'],
  '[]'::jsonb,
  '구미시청', 'https://www.gumi.go.kr/',
  null, null, null, null,
  null, null, true,
  '언론 보도 기준 정리', current_date, true,
  'gumi-birth-celebration-grant', 2026, true
from regions r, categories c
where r.slug = 'gyeongbuk-gumi' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 구미형 청년 월세지원 사업 (housing)
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
  'gumi-youth-rent-support',
  '구미형 청년 월세지원 사업',
  '구미시의 무주택 미혼 청년 1인가구에게 월세를 최대 24개월간 지원하는 제도입니다.',
  r.id, c.id,
  '만 19~39세 무주택 미혼 청년 1인가구로, 기준중위소득 120% 이하, 재산 1억 2,200만원 이하여야 합니다.',
  '매달 최대 10만원씩 최대 24개월을 지원합니다.',
  '구미시청 통합예약시스템 온라인 또는 행정복지센터를 방문해 신청합니다.',
  array['임대차계약서', '주민등록등본', '소득·재산 증빙서류'],
  array['미혼 1인가구만 대상입니다', '2025년부터 예산이 확대돼 총 2,500명 규모로 운영됩니다'],
  '[]'::jsonb,
  '구미시청', 'https://www.gumi.go.kr/',
  '기준중위소득 120% 이하', 19, 39, '1인가구',
  null, null, false,
  '언론 보도 기준 정리', current_date, true,
  'gumi-youth-rent-support', 2026, true
from regions r, categories c
where r.slug = 'gyeongbuk-gumi' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 경주시 출산장려금 (birth)
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
  'gyeongju-birth-grant',
  '경주시 출산장려금',
  '경주시에서 출산한 가정에 출산축하금과 자녀 수별 출산장려금을 함께 지급하는 제도입니다.',
  r.id, c.id,
  '경주시로 출생신고하고, 출생일부터 지원일까지 부 또는 모가 경주시에 주민등록을 두고 거주하는 가정이 대상입니다.',
  '출산축하금 20만원에 더해, 자녀 수에 따라 첫째아 300만원, 둘째아 500만원, 셋째아 이상 1,800만원의 출산장려금을 지급합니다.',
  '출생신고일로부터 6개월 이내에 읍·면·동 행정복지센터 또는 정부24(행복출산 원스톱서비스)를 통해 신청합니다.',
  array['출생신고 관련 서류', '주민등록등본'],
  array['출생신고일로부터 6개월 이내에 신청해야 합니다', '출산축하금과 출산장려금을 각각 확인해 빠짐없이 신청하세요'],
  '[]'::jsonb,
  '경주시 보건소', 'https://www.gyeongju.go.kr/',
  null, null, null, null,
  null, null, true,
  '경주시 보건소 기준 정리', current_date, true,
  'gyeongju-birth-grant', 2026, true
from regions r, categories c
where r.slug = 'gyeongbuk-gyeongju' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 경주시 청년 주택구입 대출이자 지원사업 (housing)
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
  'gyeongju-youth-home-purchase-interest-support',
  '경주시 청년 주택구입 대출이자 지원사업',
  '경주시에서 주택을 구입한 청년의 대출이자를 지원하는 제도입니다.',
  r.id, c.id,
  '공고일 기준 경주시에 주소를 두고 실거주하는 만 19~39세 청년으로, 2024년 1월 1일 이후 경주 지역 내 주택을 구입한 경우가 대상입니다.',
  '2025년도에 실제 납부한 주택구입 대출이자 범위 내에서 연 최대 300만원을 지원합니다.',
  '경주시청 공고를 통해 신청합니다.',
  array['주택 매매계약서', '대출 관련 서류', '주민등록등본'],
  array['2024년 1월 1일 이후 구입한 주택만 대상입니다', '실제 납부한 이자 범위 내에서만 지원됩니다'],
  '[]'::jsonb,
  '경주시청', 'https://www.gyeongju.go.kr/',
  null, 19, 39, null,
  null, null, false,
  '언론 보도 기준 정리', current_date, true,
  'gyeongju-youth-home-purchase-interest-support', 2026, true
from regions r, categories c
where r.slug = 'gyeongbuk-gyeongju' and c.slug = 'housing'
on conflict (slug) do nothing;
