-- =============================================================================
-- 전국 확대 2차 배치 (2026년 기준): 부산·대구·광주·대전 남은 카테고리 보완
-- 부산: 출산·주거 추가 (청년·결혼은 1차 배치에서 완료) → 4개 카테고리 완성
-- 대구: 결혼·출산·주거 추가 (청년은 1차 배치에서 완료) → 4개 카테고리 완성
-- 광주: 결혼·주거 추가 (청년은 1차 배치에서 완료) → 3/4 (출산은 시 전체 금액
--        확인 불가로 제외, 구별 정보만 존재)
-- 대전: 결혼·출산 추가 (청년·주거는 1차 배치에서 완료) → 4개 카테고리 완성
-- =============================================================================

-- 부산 산모·신생아 건강관리 지원 (birth)
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
  'busan-maternal-newborn-care',
  '부산 산모·신생아 건강관리 지원',
  '출산 가정에 산후도우미 방문 서비스를 바우처로 지원하는 부산시 제도입니다.',
  r.id, c.id,
  '신청일 기준 산모의 주민등록상 부산광역시 거주가 확인되는 출산 가정이 대상입니다. 기준 중위소득 150% 이하는 기본 지원 대상이며, 부산시는 150%를 초과하더라도 결혼이민 산모, 쌍생아 이상 출산, 둘째아 이상 출산 가정을 예외지원 대상으로 넓게 인정합니다.',
  '산후도우미 방문(단축·표준·연장형) 서비스를 바우처로 지급하며, 총비용에서 정부·시 지원금을 뺀 본인부담금만 실제로 부담합니다.',
  '출산 예정일 40일 전부터 출산일로부터 60일 이내에 거주지 보건소 또는 복지로에서 신청합니다.',
  array['산모수첩 또는 출생신고 서류', '주민등록등본', '소득 증빙서류'],
  array['기준 중위소득 150%를 넘더라도 둘째아 이상·다태아·결혼이민 가정이면 예외지원 대상일 수 있습니다', '출산 예정일 40일 전부터 신청할 수 있으니 미리 준비하세요', '신청 기한(출산 후 60일 이내)을 놓치지 마세요'],
  '[]'::jsonb,
  '부산시 여성가족국 / 관할 보건소', 'https://www.busan.go.kr/',
  '기준 중위소득 150% 이하 (예외지원 대상은 초과 가능)', null, null, null,
  null, null, true,
  '부산시 공고 및 관할 구청 홈페이지 기준 정리', current_date, true,
  'busan-maternal-newborn-care', 2026, true
from regions r, categories c
where r.slug = 'busan' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 부산 청년 월세 지원 (housing)
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
  'busan-youth-rent-support',
  '부산 청년 월세 지원',
  '부산의 무주택 청년에게 월세를 최장 24개월간 지원하는 제도입니다.',
  r.id, c.id,
  '만 19~34세 독립거주 무주택 청년으로, 청년가구 소득이 기준 중위소득 60% 이하이면서 원가구 소득이 중위소득 100% 이하여야 합니다.',
  '실제 낸 월세 범위 내에서 매달 최대 20만원씩 최장 24개월(최대 480만원)을 지원합니다. 임차보증금·관리비는 지원 대상에서 제외되며, 월세가 20만원보다 적으면 실제 월세만큼만 지급됩니다.',
  '복지로 홈페이지 또는 모바일 앱에서 온라인 신청하거나, 주소지 관할 주민센터를 방문해 신청합니다. 2026년 신청 기간은 3월 30일~5월 29일이었습니다.',
  array['임대차계약서', '월세 이체 내역', '가족관계증명서', '소득·재산 증빙서류'],
  array['청년가구뿐 아니라 원가구(부모 포함) 소득·재산 기준도 함께 충족해야 합니다', '임차보증금과 관리비는 지원 대상이 아닙니다', '소득·재산 조사를 거쳐 선정되며, 선정 시 이전 월분까지 소급 지원될 수 있습니다'],
  '[]'::jsonb,
  '부산시 청년정책담당관', 'https://young.busan.go.kr/',
  '청년가구 중위소득 60% 이하 & 원가구 중위소득 100% 이하', 19, 34, '1인가구',
  null, null, false,
  '부산시 공고 및 언론 보도 기준 정리', current_date, true,
  'busan-youth-rent-support', 2026, true
from regions r, categories c
where r.slug = 'busan' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 대구 신혼부부 전세자금 대출이자 지원 (marriage)
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
  'daegu-newlywed-jeonse-loan-interest',
  '대구 신혼부부 전세자금 대출이자 지원',
  '주택도시기금 신혼부부 전용 전세자금 대출을 이용 중인 대구 거주 신혼부부에게 이자를 지원하는 제도입니다.',
  r.id, c.id,
  '대구시에 주소를 둔 혼인 7년 이내 무주택 신혼부부이거나 3개월 이내 결혼 예정인 예비부부로, 주택도시기금 신혼부부 전용 전세자금 대출을 이용 중이어야 합니다.',
  '자녀 수에 따라 무자녀 0.5%, 1자녀 1%, 2자녀 이상 1.6%의 이자를 최장 6년간 지원합니다. 대출한도는 임차보증금의 90% 이내, 최대 1억원입니다.',
  '대구시 추천서를 발급받은 뒤, 협약은행(대구은행 또는 농협은행, 지역농협 제외)에서 전세자금대출 시 대출금리를 할인받습니다. 이후 대구시가 해당 은행에 이차보전합니다.',
  array['혼인관계증명서(또는 예비부부 증빙 서류)', '대구시 추천서', '전세임대차계약서', '대출 관련 서류'],
  array['대구시 추천서를 먼저 발급받아야 합니다', '협약은행(대구은행·농협은행)에서만 이용할 수 있습니다', '자녀 수에 따라 지원 금리가 달라집니다'],
  '[]'::jsonb,
  '대구시 주택정책과', 'https://anbang.daegu.go.kr/supportNewlyweds/businessOverView.do',
  null, null, null, '신혼부부',
  null, null, true,
  '대구안방(대구시 주거포털) 및 언론 보도 기준 정리', current_date, true,
  'daegu-newlywed-jeonse-loan-interest', 2026, true
from regions r, categories c
where r.slug = 'daegu' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 대구시 출생축하금 (birth)
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
  'daegu-birth-celebration-grant',
  '대구시 출생축하금',
  '둘째 이상을 출산한 대구 거주 가정에 현금을 일시금으로 지급하는 시비 지원 제도입니다.',
  r.id, c.id,
  '출생일 기준 대구시에 주민등록을 두고 있는 가정으로, 둘째 이상 자녀를 출산한 경우 대상입니다. 첫째는 국가 지원(첫만남이용권 등)으로 갈음되며, 이 축하금은 둘째부터 지급됩니다.',
  '둘째는 100만원, 셋째 이상은 200만원을 현금 일시금으로 지급합니다.',
  '출생신고하는 관할 구청 또는 정부24를 통해 신청합니다.',
  array['출생신고 관련 서류', '주민등록등본'],
  array['첫째 자녀는 이 제도의 지급 대상이 아닙니다', '구별로 추가 출산장려금이 별도로 있을 수 있으니 관할 구청도 함께 확인하세요'],
  '[]'::jsonb,
  '대구시 여성가족정책관', 'https://www.daegu.go.kr/woman/index.do?menu_id=00934300',
  null, null, null, null,
  null, null, true,
  '대구시 공식 홈페이지 기준 정리', current_date, true,
  'daegu-birth-celebration-grant', 2026, true
from regions r, categories c
where r.slug = 'daegu' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 대구 청년 월세 지원 (housing)
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
  'daegu-youth-rent-support',
  '대구 청년 월세 지원',
  '대구의 무주택 청년에게 월세를 최장 24개월간 지원하는 제도입니다.',
  r.id, c.id,
  '만 19~34세 무주택 청년으로 부모와 별도로 거주해야 합니다. 청년가구 기준 중위소득 60% 이하·재산 1억 2,200만원 이하, 원가구(부모 포함) 기준 중위소득 100% 이하·재산 4억 7,000만원 이하를 모두 충족해야 합니다.',
  '매달 최대 20만원씩 최장 24개월(최대 480만원)을 지원합니다.',
  '주소지 관할 행정복지센터 방문 또는 복지로 누리집·모바일 앱으로 신청합니다. 2026년 신청 기간은 3월 30일~5월 29일이었으며, 소득·재산 조사를 거쳐 9월 최종 대상자를 선정하고 5월분부터 소급 지원합니다.',
  array['임대차계약서', '가족관계증명서', '소득·재산 증빙서류'],
  array['원가구(부모 포함)와 청년 본인 가구 모두 소득·재산 기준을 충족해야 합니다', '선정까지 시간이 걸리지만 선정되면 5월분부터 소급 지급됩니다'],
  '[]'::jsonb,
  '대구시 청년정책과', 'https://www.bokjiro.go.kr/',
  '청년가구 중위소득 60% 이하 & 원가구 중위소득 100% 이하', 19, 34, '1인가구',
  null, null, false,
  '대구시 공고 및 언론 보도 기준 정리', current_date, true,
  'daegu-youth-rent-support', 2026, true
from regions r, categories c
where r.slug = 'daegu' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 광주 신혼부부 전월세자금 대출이자 지원 (marriage)
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
  'gwangju-newlywed-jeonse-loan-interest',
  '광주 신혼부부 전월세자금 대출이자 지원',
  '금융권에서 전월세 자금 대출을 받은 광주 거주 신혼부부에게 이자를 지원하는 제도입니다.',
  r.id, c.id,
  '광주시에 거주하는 신혼부부로, 금융권에서 전월세 자금 용도로 대출을 받은 가구가 대상입니다.',
  '대출잔액의 1~1.5% 이자를 가구당 최대 100만원까지 지원합니다. 연간 예산은 약 6억원 규모로 운영됩니다.',
  '광주 청년정책 검색 플랫폼(youth.gwangju.go.kr) 또는 관할 구청을 통해 신청합니다.',
  array['혼인관계증명서', '전월세 임대차계약서', '대출 관련 서류'],
  array['대출잔액에 비례해 이자를 지원받으므로 대출 금액을 미리 확인하세요', '연간 예산이 한정되어 있어 소진 시 조기 마감될 수 있습니다'],
  '[]'::jsonb,
  '광주시 주택정책과', 'https://youth.gwangju.go.kr/www/50?siteId=www&policyId=415',
  null, null, null, '신혼부부',
  null, null, true,
  '광주시 공고 및 언론 보도 기준 정리', current_date, true,
  'gwangju-newlywed-jeonse-loan-interest', 2026, true
from regions r, categories c
where r.slug = 'gwangju' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 광주 청년 월세 지원 (housing)
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
  'gwangju-youth-rent-support',
  '광주 청년 월세 지원',
  '광주의 무주택 청년에게 월세를 최장 24개월간 지원하는 제도입니다.',
  r.id, c.id,
  '만 19~34세 무주택 청년이 대상입니다. 정확한 소득·재산 기준은 복지로 공고문을 통해 확인해야 합니다.',
  '매달 최대 20만원씩 최장 24개월(최대 480만원)을 지원합니다.',
  '복지로(bokjiro.go.kr) 또는 관할 행정복지센터에서 신청합니다.',
  array['임대차계약서', '가족관계증명서', '소득 증빙서류'],
  array['임대차계약서가 본인 명의인지 확인하세요', '월세가 20만원보다 적으면 실제 월세만큼만 지원됩니다'],
  '[]'::jsonb,
  '광주시 청년정책담당관', 'https://youth.gwangju.go.kr/www/83',
  null, 19, 34, '1인가구',
  null, null, false,
  '광주시 공고 및 언론 보도 기준 정리', current_date, true,
  'gwangju-youth-rent-support', 2026, true
from regions r, categories c
where r.slug = 'gwangju' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 대전 청년·신혼부부 전세대출 이자지원 (marriage)
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
  'daejeon-newlywed-jeonse-loan-interest',
  '대전 청년·신혼부부 전세대출 이자지원',
  '대전시가 IBK기업은행과 협력해 청년·신혼부부의 전세자금 대출이자를 지원하는 제도입니다.',
  r.id, c.id,
  '대전시에 거주하는 만 19~39세 신혼부부로, 혼인신고일 기준 7년 이내이거나 신고 예정일 3개월 이내여야 합니다. 부부합산 연소득 1억원 이하, 전세보증금 4억원 이하 주택이 대상입니다.',
  'IBK기업은행의 주택 전세자금 신규 대출에 대해 이자 2.25%를 지원합니다. 대출은 최대 2억원까지 가능합니다.',
  'IBK기업은행 지점에서 전세자금 대출 신청 시 함께 안내받아 신청합니다.',
  array['혼인관계증명서(또는 예비부부 증빙 서류)', '전세임대차계약서', '부부합산 소득 증빙서류'],
  array['부부합산 연소득이 1억원을 넘지 않는지 확인하세요', '전세보증금이 4억원을 넘지 않는지 확인하세요', 'IBK기업은행을 통한 대출만 해당됩니다'],
  '[]'::jsonb,
  '대전시 주택정책과', 'https://www.daejeon.go.kr/',
  '부부합산 연소득 1억원 이하', 19, 39, '신혼부부',
  null, null, true,
  '대전시 공식 홈페이지 기준 정리', current_date, true,
  'daejeon-newlywed-jeonse-loan-interest', 2026, true
from regions r, categories c
where r.slug = 'daejeon' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 대전형 양육기본수당 (birth)
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
  'daejeon-childcare-basic-allowance',
  '대전형 양육기본수당',
  '대전에 거주하는 영유아 가정에 매달 양육비를 지원하는 시비 제도입니다.',
  r.id, c.id,
  '대전시에 거주하는 만 0~2세 영유아를 양육하는 가정이 대상입니다.',
  '0~2세는 월 15만원, 2세 자녀는 추가로 월 15만원을 지급합니다(국가 부모급여와는 별도로 지급되는 대전시 자체 수당입니다).',
  '읍면동 행정복지센터 방문 또는 정부24·복지로 온라인으로 신청합니다.',
  array['출생신고 관련 서류', '주민등록등본'],
  array['국가 부모급여와 중복해서 받을 수 있는 별도 제도인지 신청 시 확인하세요', '연령 구간(0~2세, 2세 추가분)에 따라 지급액이 다릅니다'],
  '[]'::jsonb,
  '대전시 여성가족국', 'https://daejeon.go.kr/djbaby',
  null, 0, 2, null,
  null, null, true,
  '대전시 공식 홈페이지 및 복지로 기준 정리', current_date, true,
  'daejeon-childcare-basic-allowance', 2026, true
from regions r, categories c
where r.slug = 'daejeon' and c.slug = 'birth'
on conflict (slug) do nothing;
