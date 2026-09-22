-- =============================================================================
-- 전국 확대 4차 배치 (2026년 기준): 충북·충남·전북·전남·경북·경남 신규 지역 추가
-- 이 배치로 전국 17개 시·도가 최소 1건 이상 커버됩니다.
-- =============================================================================

insert into regions (slug, name, level, parent_id) values
  ('chungbuk', '충청북도', 'sido', null),
  ('chungnam', '충청남도', 'sido', null),
  ('jeonbuk', '전북특별자치도', 'sido', null),
  ('jeonnam', '전라남도', 'sido', null),
  ('gyeongbuk', '경상북도', 'sido', null),
  ('gyeongnam', '경상남도', 'sido', null)
on conflict (slug) do nothing;

-- 충북 청년월세지원 (housing)
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
  'chungbuk-youth-rent-support',
  '충북 청년월세지원',
  '충청북도의 무주택 청년에게 월세를 최장 24개월간 지원하는 제도입니다.',
  r.id, c.id,
  '부모와 별도로 거주하는 만 19~34세 무주택 청년으로, 청년 독립가구 소득이 기준 중위소득 60% 이하, 원가구 소득이 중위소득 100% 이하여야 합니다.',
  '매달 최대 20만원씩 최장 24개월(최대 480만원)을 지원합니다.',
  '충청북도 청년정책 플랫폼 "가치자람"(gachi.chungbuk.go.kr) 또는 복지로에서 신청합니다.',
  array['임대차계약서', '가족관계증명서', '소득·재산 증빙서류'],
  array['원가구(부모 포함) 소득 기준도 함께 충족해야 합니다', '시군별로 별도 자체 사업(예: 옥천군 정액 지원)이 있을 수 있으니 거주 시군도 확인하세요'],
  '[]'::jsonb,
  '충청북도 청년정책과', 'https://gachi.chungbuk.go.kr/',
  '청년가구 중위소득 60% 이하 & 원가구 중위소득 100% 이하', 19, 34, '1인가구',
  null, null, false,
  '충청북도 공고 및 언론 보도 기준 정리', current_date, true,
  'chungbuk-youth-rent-support', 2026, true
from regions r, categories c
where r.slug = 'chungbuk' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 충남 청년 월세 지원 (housing)
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
  'chungnam-youth-rent-support',
  '충남 청년 월세 지원',
  '충청남도의 무주택 청년에게 월세를 최장 24개월간 지원하는 제도로, 2026년부터 상시 신청 체계로 운영됩니다.',
  r.id, c.id,
  '만 19~34세 무주택 청년으로 부모와 별도로 거주해야 합니다. 청년 본인 가구는 기준 중위소득 60% 이하·재산 1억 2,200만원 이하, 원가구(부모 포함)는 중위소득 100% 이하·재산 4억 7,000만원 이하여야 합니다.',
  '매달 최대 20만원씩 최장 24개월(최대 480만원)을 지원합니다.',
  '충남청년포털(youth.chungnam.go.kr) 또는 복지로에서 상시 신청할 수 있습니다.',
  array['임대차계약서', '가족관계증명서', '소득·재산 증빙서류'],
  array['2026년부터 상시 신청이 가능해졌으니 시기를 놓칠까 걱정하지 않아도 됩니다', '원가구와 청년 본인 가구 재산 기준을 모두 확인하세요'],
  '[]'::jsonb,
  '충청남도 청년정책과', 'https://youth.chungnam.go.kr/',
  '청년가구 중위소득 60% 이하 & 원가구 중위소득 100% 이하', 19, 34, '1인가구',
  null, null, true,
  '충남청년포털 및 언론 보도 기준 정리', current_date, true,
  'chungnam-youth-rent-support', 2026, true
from regions r, categories c
where r.slug = 'chungnam' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 전북 청년월세지원 (housing)
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
  'jeonbuk-youth-rent-support',
  '전북 청년월세지원',
  '전북특별자치도의 무주택 청년에게 월세를 최장 24개월간 지원하는 제도로, 2026년부터 연중 상시 신청할 수 있습니다.',
  r.id, c.id,
  '만 19~34세 무주택 청년으로, 소득·재산 기준을 충족하면 누구나 신청할 수 있습니다.',
  '실제 월세 범위 내에서 매달 최대 20만원씩 최장 24개월(최대 480만원)을 지원합니다. 임차보증금·관리비는 제외되며, 월세가 20만원보다 적으면 실제 월세만큼만 지급됩니다.',
  '복지로(bokjiro.go.kr)에서 연중 상시 접수합니다. 전북청년허브센터(jb2030.or.kr)에서도 안내받을 수 있습니다.',
  array['임대차계약서', '가족관계증명서', '소득·재산 증빙서류'],
  array['2026년부터 상시 접수로 바뀌어 특정 기간을 놓쳐도 신청할 수 있습니다', '임차보증금과 관리비는 지원 대상이 아닙니다'],
  '[]'::jsonb,
  '전북특별자치도 청년정책과', 'https://www.jb2030.or.kr/',
  null, 19, 34, '1인가구',
  null, null, true,
  '전북특별자치도 공고 및 언론 보도 기준 정리', current_date, true,
  'jeonbuk-youth-rent-support', 2026, true
from regions r, categories c
where r.slug = 'jeonbuk' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 전남 청년복지로 (housing)
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
  'jeonnam-youth-welfare-rent-support',
  '전남 청년복지로 (청년 월세 지원)',
  '전라남도의 무주택 청년에게 월세를 지원하는 제도로, 다른 시·도의 유사 사업보다 지원 기간이 12개월로 짧습니다.',
  r.id, c.id,
  '만 19~34세 무주택 청년으로 부모와 별도로 거주해야 합니다.',
  '매달 최대 20만원씩 12개월간(최대 240만원) 지원합니다. 다른 시·도의 24개월형 지원과 달리 지원 기간이 12개월인 점에 유의해야 합니다.',
  '전라남도 청년정책 플랫폼 또는 복지로에서 신청합니다.',
  array['임대차계약서', '가족관계증명서', '소득 증빙서류'],
  array['지원 기간이 12개월로, 다른 시도의 24개월형과 다릅니다', '부모와 별도 거주 여부를 증빙할 서류를 준비하세요'],
  '[]'::jsonb,
  '전라남도 청년정책과', 'https://www.jeonnam.go.kr/',
  null, 19, 34, '1인가구',
  null, null, true,
  '전라남도 공고 기준 정리', current_date, true,
  'jeonnam-youth-welfare-rent-support', 2026, true
from regions r, categories c
where r.slug = 'jeonnam' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 전남 출산·육아복지로 (birth)
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
  'jeonnam-childcare-welfare-allowance',
  '전남 출산·육아복지로',
  '전라남도에 거주하는 0~23개월 영아의 보호자에게 매달 양육비를 지원하는 제도입니다.',
  r.id, c.id,
  '전라남도에 거주하며 생후 0~23개월 영아를 양육하는 보호자가 대상입니다.',
  '0~11개월 구간은 매달 100만원, 12~23개월 구간은 매달 50만원을 지급합니다.',
  '전라남도 출산·육아 지원 플랫폼 또는 관할 읍면동 행정복지센터를 통해 신청합니다.',
  array['출생신고 관련 서류', '주민등록등본'],
  array['생후 11개월을 기준으로 지급액이 절반으로 줄어드니 시기를 확인하세요', '만 24개월 이후에는 이 제도의 지급 대상이 아닙니다'],
  '[]'::jsonb,
  '전라남도 인구청년정책관', 'https://www.jeonnam.go.kr/',
  null, 0, 1, null,
  null, null, true,
  '전라남도 공고 기준 정리', current_date, true,
  'jeonnam-childcare-welfare-allowance', 2026, true
from regions r, categories c
where r.slug = 'jeonnam' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 경북 청년월세 지원사업 (housing)
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
  'gyeongbuk-youth-rent-support',
  '경북 청년월세 지원사업',
  '경상북도의 무주택 청년에게 월세를 최장 24개월간 지원하는 제도입니다.',
  r.id, c.id,
  '부모와 별도로 거주하는 만 19~34세 무주택 청년으로, 임차보증금 3억원 이하 주택에 거주해야 합니다. 연소득 기준은 청년 5천만원 이하, 청년 외 6천만원 이하, 신혼부부 7천 500만원 이하입니다.',
  '매달 최대 20만원씩 최장 24개월(최대 480만원)을 지원합니다.',
  '복지로 홈페이지·앱, 주소지 관할 주민센터 또는 시·군청에서 신청합니다.',
  array['임대차계약서', '가족관계증명서', '소득 증빙서류'],
  array['임차보증금이 3억원을 넘지 않는지 확인하세요', '함께 운영되는 전세보증금반환보증 보증료 지원(최대 40만원)도 확인해보세요'],
  '[]'::jsonb,
  '경상북도 청년정책과', 'https://www.gbhome.kr/',
  '청년 5천만원 이하 / 청년 외 6천만원 이하 / 신혼부부 7천500만원 이하', 19, 34, '1인가구',
  null, null, false,
  '경상북도 공고 및 언론 보도 기준 정리', current_date, true,
  'gyeongbuk-youth-rent-support', 2026, true
from regions r, categories c
where r.slug = 'gyeongbuk' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 경남 청년 월세 지원사업 (housing)
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
  'gyeongnam-youth-rent-support',
  '경남 청년 월세 지원사업',
  '경상남도에 거주하는 청년 세대주에게 월세를 12개월간 지원하는 제도입니다.',
  r.id, c.id,
  '경남에 거주하는 만 19~39세 청년으로 세대주여야 합니다. 소득은 건강보험료 본인부담금 기준 중위소득 60% 초과 150% 이하이며, 임차보증금 1억원 이하·월 임차료 60만원 이하 주택이 대상입니다.',
  '매달 최대 20만원씩 12개월간(최대 240만원) 지원합니다.',
  '경남바로서비스 또는 거주지 읍면동을 통해 신청·접수한 뒤, 시군 자격심사를 거쳐 매월 25일경 지급됩니다.',
  array['임대차계약서', '세대주 확인서류(주민등록등본)', '건강보험료 납부확인서'],
  array['본인이 세대주인지 먼저 확인하세요', '중위소득 60% 이하는 대상이 아니며 60% 초과 150% 이하 구간만 해당합니다', '지급까지 신청→심사→지급 절차가 있어 시간이 걸립니다'],
  '[]'::jsonb,
  '경상남도 청년정책과', 'https://youth.gyeongnam.go.kr/',
  '중위소득 60% 초과 150% 이하 (건강보험료 기준)', 19, 39, null,
  null, null, false,
  '경상남도 공고 및 복지로 기준 정리', current_date, true,
  'gyeongnam-youth-rent-support', 2026, true
from regions r, categories c
where r.slug = 'gyeongnam' and c.slug = 'housing'
on conflict (slug) do nothing;
