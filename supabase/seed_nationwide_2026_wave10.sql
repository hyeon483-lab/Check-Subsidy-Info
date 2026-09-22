-- =============================================================================
-- 전국 확대 10차 배치 (2026년 기준): 경기도 주요 도시 6곳 확장
-- 성남시·용인시·고양시·화성시·부천시·안양시
--
-- 다음 항목은 검증 기준 미달 또는 근거 불충분으로 이번 배치에서 제외했습니다.
--  - 성남시 결혼: 시 자체 결혼 지원 제도를 확인하지 못해 제외.
--  - 고양시 결혼: "최대 200만원" 언급이 있으나 보건복지부 협의 중인 미확정
--    사업이라 확정 제도로 볼 수 없어 제외. 확정되면 추후 추가.
--  - 안양시 결혼(신혼부부 주택 매입·전세자금 대출이자 지원): 자격 요건은
--    확인되나 구체적 지원 금액(이자율/한도)을 확인하지 못해 제외.
--  - 부천시 출산지원금 확대안: 2025년 12월 보도 시점 "2026년 시행 예정"
--    표현이라 실제 조례 개정·시행 완료 여부가 불확실해 제외.
--  - 부천 청년드림주택: 2026년 신규 시행 예정 사업으로 보도 시점 기준
--    준비 단계라 시행 여부가 불확실해 제외.
-- 대신 부천시는 조례상 신혼부부/청년으로 나뉘는 "전·월세 대출이자 지원"을
-- 결혼·주거 두 카테고리로 나누어 반영했습니다.
-- =============================================================================

insert into regions (slug, name, level, parent_id)
select 'gyeonggi-seongnam', '성남시', 'sigungu', id from regions where slug = 'gyeonggi'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'gyeonggi-yongin', '용인시', 'sigungu', id from regions where slug = 'gyeonggi'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'gyeonggi-goyang', '고양시', 'sigungu', id from regions where slug = 'gyeonggi'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'gyeonggi-hwaseong', '화성시', 'sigungu', id from regions where slug = 'gyeonggi'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'gyeonggi-bucheon', '부천시', 'sigungu', id from regions where slug = 'gyeonggi'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'gyeonggi-anyang', '안양시', 'sigungu', id from regions where slug = 'gyeonggi'
on conflict (slug) do nothing;

-- 성남시 출산장려금 (birth)
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
  'seongnam-birth-celebration-grant',
  '성남시 출산장려금',
  '성남시에서 출산한 가정에 자녀 수에 따라 차등 지급하는 출산장려금 제도입니다.',
  r.id, c.id,
  '출생아와 함께 성남시에 주민등록을 두고 180일 이상 계속 거주할 예정인 가정이 대상입니다(출생 후 거주 요건 완화 적용).',
  '첫째아 30만원, 둘째아 50만원, 셋째아 100만원, 넷째아 200만원, 다섯째아 이상 300만원을 지급합니다. 셋째아 이상 가정에는 7세 이하 아동에게 월 10만원의 다자녀아동양육수당을 별도로 지급하며, 12개월 미만 셋째아 이상 출생·입양아에게는 단체보험도 제공합니다.',
  '출생신고 후 주민등록지 관할 동 행정복지센터를 방문해 신청합니다.',
  array['신분증', '가족관계증명서', '통장사본'],
  array['거주 요건 충족 여부를 사전에 확인하세요', '셋째아 이상은 다자녀아동양육수당과 단체보험도 함께 챙기세요'],
  '[]'::jsonb,
  '성남시청', 'https://www.seongnam.go.kr/',
  null, null, null, null,
  null, null, true,
  '성남시청 및 보조금24 기준 정리', current_date, true,
  'seongnam-birth-celebration-grant', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-seongnam' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 성남시 미취업 청년 지원사업(ALL-Pass) (youth)
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
  'seongnam-unemployed-youth-support',
  '성남시 미취업 청년 지원사업(ALL-Pass)',
  '성남시의 미취업 청년에게 어학·자격증 등 취업 준비 비용을 지원하는 제도입니다.',
  r.id, c.id,
  '만 19~39세로 신청일 기준 1년 이상 성남시에 주민등록을 두고 있는 미취업 청년이 대상입니다.',
  '어학·한국사·국가공인자격증 수강료 등 취업 준비 비용을 1인당 최대 100만원(저소득 청년은 최대 200만원)까지 실비로 지원합니다.',
  '잡아바어플라이(job.gg.go.kr) 온라인으로 신청하며, 연중 여러 차례(3월·9월·10월·11월 등) 회차별로 모집합니다.',
  array['미취업 확인서류', '소득 증빙서류'],
  array['회차별 모집이므로 공고 일정을 꼭 확인하세요', '저소득 청년은 지원 한도가 200만원으로 더 높습니다'],
  '[]'::jsonb,
  '성남시청 일자리경제과', 'https://www.seongnam.go.kr/',
  null, 19, 39, null,
  null, null, false,
  '잡아바어플라이 공고 및 웰로 기준 정리', current_date, true,
  'seongnam-unemployed-youth-support', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-seongnam' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 성남시 취업청년 전월세·이사비 지원사업 (housing)
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
  'seongnam-youth-rent-moving-support',
  '성남시 취업청년 전월세·이사비 지원사업',
  '성남시의 사회초년생에게 이사비와 전월세 대출이자·월세를 지원하는 제도입니다.',
  r.id, c.id,
  '1986년 1월 1일~2007년 12월 31일 출생한 사회초년생으로, 1인 가구 연소득 4,000만원 이하(부부 합산 7,000만원 이하)여야 합니다.',
  '부동산 중개비와 이사비로 40만원을 지원하고, 전세대출이자 또는 월세를 최장 10개월간 매달 최대 20만원까지 지원합니다. 생애 1회만 받을 수 있으며, 분야별 250명씩 총 750명을 선발합니다.',
  '성남시 온라인 신청 시스템을 통해 신청합니다.',
  array['소득 증빙서류', '임대차계약서 또는 이사 관련 서류'],
  array['생애 1회만 지원받을 수 있습니다', '분야별 250명, 총 750명 한정이니 선발 일정을 확인하세요'],
  '[]'::jsonb,
  '성남시청', 'https://www.seongnam.go.kr/',
  '1인가구 연소득 4,000만원 이하 (부부 합산 7,000만원 이하)', null, null, null,
  null, null, false,
  '성남복지이음 및 경기복지신문 기준 정리', current_date, true,
  'seongnam-youth-rent-moving-support', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-seongnam' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 용인특례시 신혼부부 전세자금 대출이자 지원 (marriage)
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
  'yongin-newlywed-jeonse-interest-support',
  '용인특례시 신혼부부 전세자금 대출이자 지원',
  '용인시에 거주하는 신혼부부의 전세자금 대출이자를 지원하는 제도입니다.',
  r.id, c.id,
  '혼인신고일 기준 7년 이내인 신혼부부가 대상입니다.',
  '전세자금 대출 잔액의 1% 범위에서 생애 1회 최대 100만원을 지원합니다.',
  '용인시청 공고에 따라 연 2회 정도 회차별로 신청합니다.',
  array['혼인관계증명서', '전세계약서', '대출 관련 서류'],
  array['생애 1회만 지원받을 수 있습니다', '회차별 모집이니 공고 일정을 확인하세요'],
  '[]'::jsonb,
  '용인특례시청', 'https://www.yongin.go.kr/',
  null, null, null, '신혼부부',
  null, null, false,
  '용인시청 공고 및 경기청년포털 기준 정리', current_date, true,
  'yongin-newlywed-jeonse-interest-support', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-yongin' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 용인시 출산장려금 및 임신지원금 (birth)
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
  'yongin-birth-pregnancy-support-grant',
  '용인시 출산장려금 및 임신지원금',
  '용인시에서 출산한 가정에 출산장려금을, 임신부에게 임신지원금을 지급하는 제도입니다.',
  r.id, c.id,
  '출생일 또는 신청일 기준 180일 이상 용인시에 주민등록을 두고 있는 가정이 대상입니다. 임신지원금은 임신 20주 이상인 임신부가 대상입니다.',
  '출산장려금은 첫째아 30만원, 둘째아 50만원, 셋째아 100만원 등 자녀 수에 따라 최대 300만원까지 차등 지급하며, 임신지원금은 지역화폐로 30만원을 지급합니다.',
  '임신지원금은 임신 20주 이후부터 출산 전까지 신청합니다.',
  array['임신확인서 또는 출생신고 관련 서류', '주민등록등본'],
  array['출산장려금과 임신지원금은 각각 신청해야 합니다', '2025년 1~3월 출산자는 소급 신청 기한을 놓치지 마세요'],
  '[]'::jsonb,
  '용인특례시청', 'https://www.yongin.go.kr/',
  null, null, null, null,
  null, null, true,
  '용인신문 및 웰로 기준 정리', current_date, true,
  'yongin-birth-pregnancy-support-grant', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-yongin' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 용인시 미취업청년 자격(어학)시험 응시료 지원사업 (youth)
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
  'yongin-youth-certification-fee-support',
  '용인시 미취업청년 자격(어학)시험 응시료 지원사업',
  '용인시의 미취업 청년에게 어학·자격시험 응시료를 지원하는 제도입니다.',
  r.id, c.id,
  '용인시에 거주하는 미취업 청년이 대상입니다.',
  '1인당 연간 최대 30만원까지 어학·자격시험 응시료를 지원합니다.',
  '용인시청 청년정책 공고를 통해 신청합니다.',
  array['시험 응시 영수증', '소득 증빙서류'],
  array['연간 한도 30만원 내에서 여러 차례 신청할 수 있는지 공고에서 확인하세요'],
  '[]'::jsonb,
  '용인특례시청', 'https://www.yongin.go.kr/',
  null, null, null, null,
  null, null, false,
  '용인시청 기준 정리', current_date, true,
  'yongin-youth-certification-fee-support', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-yongin' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 용인시 청년 전·월세보증금 대출이자 지원사업 (housing)
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
  'yongin-youth-rent-deposit-interest-support',
  '용인시 청년 전·월세보증금 대출이자 지원사업',
  '용인시의 무주택 청년에게 전월세보증금 대출이자를 지원하는 제도입니다.',
  r.id, c.id,
  '만 18~39세 무주택 청년으로, 전월세 보증금 3억원 이하·전용면적 85㎡ 이하 주택에 거주해야 합니다. 기준중위소득 180% 이하여야 합니다.',
  '전월세보증금 대출 잔액의 1% 이내에서 최대 100만원을 지원합니다.',
  '용인시청 청년정책과 청년주거팀(031-6193-2762)으로 문의 후 신청합니다.',
  array['임대차계약서', '대출 관련 서류', '소득 증빙서류'],
  array['전용면적과 보증금 기준을 초과하지 않는지 확인하세요'],
  '[]'::jsonb,
  '용인특례시청 청년정책과', 'https://www.yongin.go.kr/',
  '기준중위소득 180% 이하', 18, 39, null,
  null, null, false,
  '문화일보 및 용인대학신문 기준 정리', current_date, true,
  'yongin-youth-rent-deposit-interest-support', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-yongin' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 고양시 출산지원금 (birth)
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
  'goyang-birth-grant',
  '고양시 출산지원금',
  '고양시에서 출산한 가정에 자녀 수에 따라 차등 지급하는 출산지원금으로, 경기도 내에서도 높은 수준의 금액입니다.',
  r.id, c.id,
  '출생신고일 기준 1년 전부터 계속 고양시에 거주하며, 출생아와 주민등록상 세대를 같이 하는 가정이 대상입니다.',
  '첫째아 100만원, 둘째아 200만원, 셋째아 300만원, 넷째아 500만원, 다섯째아 이상 1,000만원을 지급합니다. 모든 출산가정에 탄생축하 쌀케이크(고양 가와지쌀)를 지원하며, 셋째아 이상은 다복꾸러미도 추가로 받을 수 있습니다.',
  '출생신고일로부터 1년 이내에 신청합니다.',
  array['출생신고 관련 서류', '주민등록등본'],
  array['2025년부터 거주 요건을 충족하지 못해도 재신청할 수 있도록 조례가 완화됐습니다', '다섯째아 이상은 최대 1,000만원까지 받을 수 있습니다'],
  '[]'::jsonb,
  '고양특례시청', 'https://www.goyang.go.kr/',
  null, null, null, null,
  null, null, true,
  '고양시청 기준 정리', current_date, true,
  'goyang-birth-grant', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-goyang' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 고양시 출산가구 전월세자금 대출이자 지원사업 (birth)
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
  'goyang-birth-household-rent-interest-support',
  '고양시 출산가구 전월세자금 대출이자 지원사업',
  '전국 최초로 제정된 조례에 따라 고양시가 무주택 출산가구의 전월세 대출이자를 지원하는 제도입니다.',
  r.id, c.id,
  '기준중위소득 150% 이하인 무주택 출산가구로, 전월세자금 대출을 이용 중이어야 합니다.',
  '대출 잔액의 1.8% 이내에서 연 최대 100만원을 지원하며, 연 1회씩 최대 4년간 받을 수 있습니다.',
  '고양시청 공고를 통해 연 1회 신청합니다.',
  array['임대차계약서', '대출 관련 서류', '출생신고 관련 서류'],
  array['전국 최초로 제정된 출산가구 대상 조례에 근거한 제도입니다', '연 1회씩 최대 4년간 신청해야 계속 지원받을 수 있습니다'],
  '[]'::jsonb,
  '고양특례시청', 'https://www.goyang.go.kr/',
  '기준중위소득 150% 이하', null, null, null,
  null, null, false,
  '프레시안 및 고양시청 기준 정리', current_date, true,
  'goyang-birth-household-rent-interest-support', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-goyang' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 고양시 청년일자리 미래패키지 - 미래드림 창업청년 지원사업 (youth)
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
  'goyang-youth-startup-support',
  '고양시 청년일자리 미래패키지 - 미래드림 창업청년 지원사업',
  '고양시의 초기창업 청년에게 2년간 창업비용과 고용 인건비를 지원하는 제도입니다.',
  r.id, c.id,
  '창업 7년 이내의 초기창업 청년 10명을 선발합니다.',
  '1년차에는 임차료·시제품 제작비·홍보비 등 창업간접비로 1,500만원을 지원하고, 2년차에 청년을 신규 고용하면 인건비의 80%를 1년간 지원합니다.',
  '고양시 청년정책 공고를 통해 신청합니다.',
  array['사업자등록증', '창업 관련 증빙서류'],
  array['선발 인원이 10명으로 제한되어 있습니다', '2년차 인건비 지원을 받으려면 청년을 신규 고용해야 합니다'],
  '[]'::jsonb,
  '고양특례시청', 'https://www.goyang.go.kr/',
  null, null, null, null,
  null, null, false,
  '아주경제 등 언론 보도 기준 정리', current_date, true,
  'goyang-youth-startup-support', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-goyang' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 고양 청년둥지론 (housing)
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
  'goyang-youth-nest-loan',
  '고양 청년둥지론',
  '고양시의 무주택 청년에게 임차보증금 대출을 추천하고 이자를 지원하는 제도입니다.',
  r.id, c.id,
  '만 19~39세 무주택 청년 세대주로, 미혼은 연소득 5,000만원 이하(기혼은 부부합산 7,000만원 이하)여야 합니다. 임차보증금 3억원 이하·전용면적 85㎡ 이하 고양시 소재 주택이 대상입니다.',
  '최대 1억원까지 임차보증금 대출을 추천받고, 연 3%의 이자를 지원받을 수 있습니다.',
  '복지로 또는 고양시청을 통해 신청합니다.',
  array['임대차계약서', '소득 증빙서류', '주민등록등본'],
  array['미혼·기혼에 따라 소득 기준이 다릅니다', '전용면적과 보증금 기준을 초과하지 않는지 확인하세요'],
  '[]'::jsonb,
  '고양특례시청', 'https://www.goyang.go.kr/',
  null, 19, 39, null,
  null, null, true,
  '복지로 및 아주경제 기준 정리', current_date, true,
  'goyang-youth-nest-loan', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-goyang' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 화성시 연지곤지 통장 (marriage)
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
  'hwaseong-marriage-savings-match',
  '화성시 연지곤지 통장',
  '결혼을 앞둔 화성시 청년의 저축액에 화성시가 30%를 매칭 적립해주는 전국 최초의 결혼장려 매칭통장입니다.',
  r.id, c.id,
  '공고일 기준 화성특례시에 거주하는 만 19~39세 근로 중인 결혼 예정자 700명을 모집합니다.',
  '매달 최대 30만원을 저축하면 화성시가 30%인 최대 9만원을 매칭 적립합니다. 예비부부 교육을 이수하고 2년 이내에 결혼하면 본인 저축액과 매칭금을 합쳐 최대 936만원을 받을 수 있습니다.',
  '화성시 통합예약시스템 또는 홍보 QR코드를 통해 온라인으로 신청합니다.',
  array['소득 증빙서류', '예비부부 교육 이수 확인서류'],
  array['2년 이내에 결혼해야 매칭금을 받을 수 있습니다', '700명 한정 모집이니 신청 시기를 놓치지 마세요'],
  '[]'::jsonb,
  '화성특례시청', 'https://www.hscity.go.kr/',
  null, 19, 39, null,
  null, null, false,
  '이데일리 및 서울신문 기준 정리', current_date, true,
  'hwaseong-marriage-savings-match', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-hwaseong' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 화성시 출산지원금 (birth)
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
  'hwaseong-birth-grant',
  '화성시 출산지원금',
  '화성시에서 출산한 가정에 자녀 수에 따라 차등 지급하는 출산지원금 제도입니다.',
  r.id, c.id,
  '출생아 기준 부 또는 모가 출생일 180일 전부터 화성시에 거주해야 합니다(미충족 시 출생일부터 180일 경과 후 지원 대상으로 전환됩니다).',
  '2024년 1월 1일 이후 출생아부터 첫째아 100만원, 둘째·셋째아 200만원, 넷째아 이상 300만원을 나누어 지급합니다.',
  '출생(입양)일로부터 1년 이내에 행복출산원스톱서비스를 통해 행정복지센터에 신청합니다.',
  array['출생신고 관련 서류', '주민등록등본'],
  array['거주 요건을 충족하지 못해도 180일 경과 후 지원 대상으로 전환됩니다', '지급액은 분할 지급되니 지급 일정을 확인하세요'],
  '[]'::jsonb,
  '화성특례시청', 'https://www.hscity.go.kr/',
  null, null, null, null,
  null, null, true,
  '화성특례시청 및 웰로 기준 정리', current_date, true,
  'hwaseong-birth-grant', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-hwaseong' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 화성시 청년 구직자 지원(어학·자격시험 응시료) (youth)
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
  'hwaseong-youth-certification-fee-support',
  '화성시 청년 구직자 지원(어학·자격시험 응시료)',
  '화성시의 미취업 청년에게 어학·자격시험 응시료를 지원하는 제도입니다.',
  r.id, c.id,
  '만 19~39세로 화성시에 주민등록을 두고 있는 미취업 청년이 대상입니다.',
  '어학·자격시험 응시료를 최대 30만원까지 지원하며, 횟수 제한 없이 신청할 수 있습니다.',
  '화성시청년지원센터(HEY)를 통해 신청합니다.',
  array['시험 응시 영수증', '미취업 확인서류'],
  array['횟수 제한이 없으니 응시할 때마다 영수증을 잘 보관하세요'],
  '[]'::jsonb,
  '화성시청년지원센터', 'https://hey.hscity.go.kr/',
  null, 19, 39, null,
  null, null, true,
  '화성시청년지원센터 기준 정리', current_date, true,
  'hwaseong-youth-certification-fee-support', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-hwaseong' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 화성시 청년 월세 지원사업 (housing)
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
  'hwaseong-youth-rent-support',
  '화성시 청년 월세 지원사업',
  '화성시의 무주택 청년에게 월세를 지원하는 제도입니다.',
  r.id, c.id,
  '1986년 1월 1일~2007년 12월 31일 출생한 무주택 청년으로, 화성시에 주민등록을 두고 임차보증금 1억원 이하·월세 50만원 이하 주택에 거주해야 합니다. 세대원 전원 무주택이며 기준중위소득 120% 이하, 6개월 이상 월세 납부 이력이 있어야 합니다.',
  '매달 최대 15만원씩 최대 6개월(최대 90만원)을 지원합니다. 상반기 66명을 선정합니다(2025년 기준).',
  '상반기(2~2월)와 하반기(8~9월) 연 2회 공모를 통해 신청합니다.',
  array['임대차계약서', '월세 납부 증빙서류', '소득 증빙서류'],
  array['생애 1회만 지원받을 수 있습니다', '기초생활수급자, 공공임대·전세 거주자는 제외될 수 있습니다'],
  '[]'::jsonb,
  '화성특례시청', 'https://www.hscity.go.kr/',
  '기준중위소득 120% 이하', null, null, '1인가구',
  null, null, false,
  '뉴스핌 및 웰로 기준 정리', current_date, true,
  'hwaseong-youth-rent-support', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-hwaseong' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 부천시 신혼부부 전·월세 대출이자 지원 (marriage)
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
  'bucheon-newlywed-rent-interest-support',
  '부천시 신혼부부 전·월세 대출이자 지원',
  '부천시 조례에 따라 신혼부부의 전·월세 대출이자를 지원하는 제도입니다.',
  r.id, c.id,
  '부천시 조례에 따라 임차보증금 1억 5,000만원 이내 주택에 거주하는 신혼부부가 대상입니다.',
  '전세는 대출 잔액의 1.3%, 월세는 1.5% 이내에서 매년 1회씩 3년간 지원하며, 가구당 총 195만~225만원(연 최대 65만~75만원)을 받을 수 있습니다.',
  '부천시청 신청서식을 통해 매년 1회 신청합니다.',
  array['혼인관계증명서', '임대차계약서', '대출 관련 서류'],
  array['매년 1회씩 3년간 신청해야 계속 지원받을 수 있습니다', '전세와 월세의 지원 비율이 다릅니다'],
  '[]'::jsonb,
  '부천시청', 'https://www.bucheon.go.kr/',
  null, null, null, '신혼부부',
  null, null, false,
  '부천시 조례 및 U-LEX 기준 정리', current_date, true,
  'bucheon-newlywed-rent-interest-support', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-bucheon' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 부천시 청년 전·월세 대출이자 지원 (housing)
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
  'bucheon-youth-rent-interest-support',
  '부천시 청년 전·월세 대출이자 지원',
  '부천시 조례에 따라 청년의 전·월세 대출이자를 지원하는 제도입니다.',
  r.id, c.id,
  '부천시 조례에 따라 임차보증금 1억 5,000만원 이내 주택에 거주하는 청년이 대상입니다.',
  '전세는 대출 잔액의 0.6%, 월세는 0.8% 이내에서 매년 1회씩 3년간 지원하며, 가구당 총 90만~120만원(연 최대 30만~40만원)을 받을 수 있습니다.',
  '부천시청 신청서식을 통해 매년 1회 신청합니다.',
  array['임대차계약서', '대출 관련 서류', '주민등록등본'],
  array['신혼부부보다 지원 비율이 낮게 책정되어 있습니다', '매년 1회씩 3년간 신청해야 합니다'],
  '[]'::jsonb,
  '부천시청', 'https://www.bucheon.go.kr/',
  null, null, null, null,
  null, null, false,
  '부천시 조례 및 U-LEX 기준 정리', current_date, true,
  'bucheon-youth-rent-interest-support', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-bucheon' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 부천 청년 사진 드림(Dream) 사업 (youth)
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
  'bucheon-youth-photo-support',
  '부천 청년 사진 드림(Dream) 사업',
  '부천시가 취업·자격증을 준비하는 청년에게 증명사진 촬영비를 지원하는 제도입니다.',
  r.id, c.id,
  '신청일 기준 부천시에 거주하는 만 18~39세 취업·자격증 준비 청년이 대상입니다.',
  '증명사진 촬영비를 지원하며, 상반기와 하반기 각 60명씩 총 120명을 선발합니다.',
  '경기도일자리재단 잡아바어플라이를 통해 온라인으로 신청합니다.',
  array['취업 준비 확인서류'],
  array['상·하반기 각 60명 한정이니 신청 시기를 확인하세요'],
  '[]'::jsonb,
  '부천시청', 'https://www.bucheon.go.kr/',
  null, 18, 39, null,
  null, null, false,
  '경기신문 및 경기일보 기준 정리', current_date, true,
  'bucheon-youth-photo-support', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-bucheon' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 안양시 출산지원금 (birth)
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
  'anyang-birth-grant',
  '안양시 출산지원금',
  '안양시에서 출산한 가정에 자녀 수에 따라 차등 지급하는 출산지원금으로, 경기도 내 시 단위 지자체 중 높은 수준입니다.',
  r.id, c.id,
  '2023년 1월 1일 이후 출생아로, 출산일 기준 12개월 전부터 신청일까지 안양시에 계속 거주한 가정이 대상입니다.',
  '첫째아 200만원, 둘째아 400만원, 셋째아 이상 1,000만원을 지급합니다. 산후조리비 50만원, 육아용품 20만~40만원 상당, 임신축하금 10만원도 함께 지원합니다.',
  '출생신고일로부터 12개월 이내에 신청합니다.',
  array['출생신고 관련 서류', '주민등록등본'],
  array['경기도 내 시 단위 지자체 중 가장 높은 수준의 출산지원금입니다', '산후조리비·육아용품·임신축하금도 함께 챙기세요'],
  '[]'::jsonb,
  '안양시청', 'https://www.anyang.go.kr/',
  null, null, null, null,
  null, null, true,
  '경기일보 및 서울경제 기준 정리', current_date, true,
  'anyang-birth-grant', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-anyang' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 안양시 청년 어학·자격시험 응시료 지원 (youth)
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
  'anyang-youth-certification-fee-support',
  '안양시 청년 어학·자격시험 응시료 지원',
  '안양시의 미취업 청년에게 어학·자격시험 응시료를 지원하는 제도입니다.',
  r.id, c.id,
  '관내에 거주하는 만 19~39세 미취업 청년이 대상입니다.',
  '어학시험, 한국사, 국가기술·전문·공인민간자격시험 등 응시료를 최대 30만원까지 지원합니다.',
  '안양청년광장 홈페이지를 통해 신청합니다.',
  array['시험 응시 영수증', '미취업 확인서류'],
  array['대상 자격증·시험 종류가 다양하니 공고에서 미리 확인하세요'],
  '[]'::jsonb,
  '안양시청', 'https://www.anyang.go.kr/',
  null, 19, 39, null,
  null, null, true,
  '안양청년광장 기준 정리', current_date, true,
  'anyang-youth-certification-fee-support', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-anyang' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 안양시 청년 월세 지원 (housing)
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
  'anyang-youth-rent-support',
  '안양시 청년 월세 지원',
  '안양시의 무주택 청년에게 월세를 지원하는 제도로, 2025년부터 소득·재산 기준이 완화됐습니다.',
  r.id, c.id,
  '부모와 별도로 거주하는 만 19~39세 무주택 청년으로, 기준중위소득 120% 이하·재산가액 1억 3,000만원 이하여야 합니다(2025년 기준 완화).',
  '매달 최대 10만원씩 최장 10개월(최대 100만원)을 지원합니다.',
  '안양청년광장 홈페이지를 통해 연도별 공고에 따라 신청합니다.',
  array['임대차계약서', '가족관계증명서', '소득·재산 증빙서류'],
  array['2025년부터 소득·재산 기준이 완화됐습니다', '부모와 별도로 거주해야 신청할 수 있습니다'],
  '[]'::jsonb,
  '안양시청', 'https://www.anyang.go.kr/',
  '기준중위소득 120% 이하', 19, 39, '1인가구',
  null, null, false,
  '안양청년광장 및 네이트뉴스 기준 정리', current_date, true,
  'anyang-youth-rent-support', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-anyang' and c.slug = 'housing'
on conflict (slug) do nothing;
