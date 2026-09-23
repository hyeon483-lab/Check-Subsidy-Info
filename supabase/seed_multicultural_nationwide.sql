-- =============================================================================
-- "다문화" 카테고리 콘텐츠 1차 배치: 국가 단위(전국 공통) 지원제도 8건
--
-- 이 파일을 실행하려면 먼저 seed_multicultural_category.sql(카테고리 신설)을
-- 실행해야 합니다. 전국 공통 제도라 기존에 만들어둔 가상 지역
-- "전국"(slug: nationwide)을 그대로 사용합니다.
--
-- 조사 결과 다음 항목은 이번 배치에서 제외했습니다.
--  - 다문화가족 자녀 입학금 지원(초10만/중20만/고30만/대100만원): 보조금24에
--    등록돼 전국사업처럼 보이지만 실제로는 예산군(충남) 단독 사업으로
--    확인되어 제외했습니다(지역 웨이브에서 다룰 항목).
--  - "다문화가족 매달 30만원 현금지원" 등 온라인에 도는 정보: 법무부·
--    여성가족부·복지로·국가법령정보센터 등 공식 출처에서 확인되지 않아
--    근거 없는 정보로 판단해 제외했습니다.
--  - 구 "외국인노동자지원센터"(전국 44개 거점, 민간위탁 대면상담): 2023년
--    예산이 전액 삭감되어 2024년부터 사업이 폐지된 것으로 다수 언론에서
--    교차 확인되어, 현재 운영 중인 고용노동부·산업인력공단의 전화상담
--    체계(8번 항목)로 대체했습니다.
--  - 이중언어 환경조성사업: 여성가족부 자료 확인 결과 "다문화가족 자녀
--    언어발달지원사업"(5번 항목)의 하위 구성요소로 이미 포함되어 있어
--    별도 항목으로 중복 등재하지 않았습니다.
--  - 아동수당: 기존 "아동·청소년" 카테고리에서 이미 연령대 불일치로 제외한
--    항목이라 정책 일관성을 위해 여기서도 별도 등재하지 않았습니다.
--
-- ※ 여성가족부는 2026년 10월 1일부로 "성평등가족부"로 명칭이 변경될
--   예정입니다(정부조직법 개정). 담당 기관명은 "여성가족부(→성평등가족부)"로
--   병기했습니다.
-- =============================================================================

-- 사회통합프로그램(KIIP)
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
  'kiip-social-integration-program',
  '사회통합프로그램(KIIP)',
  '국내 체류 이민자에게 한국어와 한국사회 이해 교육을 무료로 제공하고, 이수하면 귀화·체류 심사에서 다양한 혜택을 주는 법무부 제도입니다.',
  r.id, c.id,
  '결혼이민자, 외국인근로자, 유학생 등 국내 체류자격을 가진 이민자 누구나 신청할 수 있습니다. 사전평가를 통해 배정된 단계부터 교육을 이수합니다.',
  '한국어와 한국문화(1~4단계), 한국사회이해(5단계) 교육을 무료로 제공합니다(사전평가 응시료 3만 8,000원은 본인 부담). 전 과정을 이수하면 귀화 면접심사 면제, 귀화 필기시험 면제, 영주자격(F-5) 실태조사 면제, 체류자격 변경·연장 시 가점 부여 등의 혜택을 받을 수 있습니다.',
  '사회통합정보망(socinet.go.kr)에서 온라인 회원가입 후 사전평가를 신청합니다. 분기별로 개강하며 상시 접수합니다.',
  array['외국인등록증', '사전평가 신청서'],
  array['사전평가 응시료(3만 8,000원)는 본인이 부담합니다', '이수 여부에 따라 귀화·체류 심사에서 받는 혜택이 달라지니 최종 이수까지 마치는 것이 중요합니다'],
  '[]'::jsonb,
  '법무부', 'https://www.socinet.go.kr/',
  null, null, null, null,
  null, null, true,
  '법무부 및 사회통합정보망 기준 정리', current_date, true,
  'kiip-social-integration-program', 2026, true
from regions r, categories c
where r.slug = 'nationwide' and c.slug = 'multicultural'
on conflict (slug) do nothing;

-- 이민자 조기적응프로그램
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
  'early-adaptation-program-immigrants',
  '이민자 조기적응프로그램',
  '국내에 장기체류할 예정인 외국인이 입국 초기에 한국 생활에 필요한 기초 정보를 배우는 법무부 교육과정입니다.',
  r.id, c.id,
  '장기체류 예정 외국인(결혼이민자 포함)으로, 입국 초기 단계에 있는 사람이 대상입니다.',
  '기초법질서, 사회적응정보, 범죄예방, 산업안전 등을 사용 언어별로 4시간 교육합니다. 결혼이민자는 가족 상호이해 과정 1시간이 추가되며, 결혼이민자가 이 과정을 이수하고 외국인등록을 하면 체류기간 2년을 부여받습니다.',
  '사회통합정보망(socinet.go.kr)에서 온라인으로 신청합니다.',
  array['외국인등록증(또는 여권)', '프로그램 신청서'],
  array['결혼이민자는 가족 상호이해 과정이 추가로 포함됩니다', '이수 시 체류기간 2년 부여 등 혜택이 있으니 입국 초기에 신청하는 것이 유리합니다'],
  '[]'::jsonb,
  '법무부', 'https://www.socinet.go.kr/',
  null, null, null, null,
  null, null, true,
  '법무부 및 정부24 기준 정리', current_date, true,
  'early-adaptation-program-immigrants', 2026, true
from regions r, categories c
where r.slug = 'nationwide' and c.slug = 'multicultural'
on conflict (slug) do nothing;

-- 다누리콜센터(결혼이민자 통번역서비스)
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
  'danuri-call-center',
  '다누리콜센터 통번역서비스',
  '결혼이민자와 다문화가족에게 13개 언어로 365일 24시간 통역·생활상담·긴급지원을 제공하는 전국 단일 콜센터입니다.',
  r.id, c.id,
  '결혼이민자, 다문화가족, 이주여성 등이 대상이며 별도의 체류자격 제한 없이 누구나 이용할 수 있습니다.',
  '한국어를 포함해 13개 언어로 365일 24시간 3자 통화 통역을 지원하며, 생활정보 상담과 가정폭력 긴급지원도 함께 제공합니다. 전국 가족센터(다문화가족지원센터)에서도 1~4개 언어 통번역서비스를 별도로 운영합니다.',
  '전화 1577-1366으로 24시간 상담을 받거나, 다누리포털(liveinkorea.kr)에서 온라인 1:1 상담·방문상담을 신청합니다.',
  array['별도 서류 없이 전화 또는 온라인으로 바로 이용 가능'],
  array['전화 상담은 365일 24시간 이용할 수 있습니다', '가족센터별 통번역 지원 언어 수는 1~4개로 센터마다 다를 수 있습니다'],
  '[]'::jsonb,
  '여성가족부(→성평등가족부)·한국건강가정진흥원', 'https://www.liveinkorea.kr/',
  null, null, null, null,
  null, null, true,
  '여성가족부 및 한국건강가정진흥원 기준 정리', current_date, true,
  'danuri-call-center', 2026, true
from regions r, categories c
where r.slug = 'nationwide' and c.slug = 'multicultural'
on conflict (slug) do nothing;

-- 다문화가족 방문교육서비스
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
  'multicultural-family-home-visit-education',
  '다문화가족 방문교육서비스',
  '지도사가 가정을 직접 방문해 한국어교육, 부모교육, 자녀생활서비스를 제공하는 여성가족부 방문형 지원 제도입니다.',
  r.id, c.id,
  '방문 한국어교육은 입국 5년 이하 결혼이민자·중도입국자녀가, 방문 자녀생활서비스는 만 3~12세 다문화가족 자녀·중도입국자녀가 대상입니다. 기준 중위소득 150% 이하 가구는 무상이며, 초과하는 가구는 본인부담금이 발생합니다.',
  '지도사가 가정을 방문해 한국어교육, 부모교육, 자녀생활서비스를 맞춤형으로 제공합니다. 정해진 현금 지급액은 없으며 교육·서비스 내용은 가정 상황에 따라 달라집니다.',
  '거주지 읍·면·동 주민센터를 방문하거나 복지로(bokjiro.go.kr)에서 온라인으로 신청합니다.',
  array['외국인등록증 또는 신분증', '가족관계증명서', '소득 증빙서류(본인부담금 산정용)'],
  array['기준 중위소득 150% 이하는 무상, 초과 시 본인부담금이 발생합니다', '입국 5년을 초과한 결혼이민자는 방문 한국어교육 대상이 아닙니다'],
  '[]'::jsonb,
  '여성가족부(→성평등가족부)', 'https://www.mogef.go.kr/',
  '기준 중위소득 150% 이하 무상(초과 시 본인부담금 발생)', null, 12, null,
  null, null, true,
  '여성가족부 및 복지로 기준 정리', current_date, true,
  'multicultural-family-home-visit-education', 2026, true
from regions r, categories c
where r.slug = 'nationwide' and c.slug = 'multicultural'
on conflict (slug) do nothing;

-- 다문화가족 자녀 언어발달지원사업
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
  'multicultural-child-language-development-support',
  '다문화가족 자녀 언어발달지원사업',
  '언어발달이 늦은 다문화가족 자녀에게 언어평가와 1:1 언어촉진교육을 제공하는 여성가족부 지원 사업입니다.',
  r.id, c.id,
  '만 12세 이하 다문화가족 자녀 중 언어발달 지연이 우려되거나 언어평가·교육이 필요한 아동이 대상입니다(초등학교 재학 중이면 만 12세를 초과해도 가능). 기초생활수급자와 기준 중위소득 52% 이하 가구가 우선 선정됩니다.',
  '언어평가 후 1:1 언어촉진교육을 1회 6개월씩 최대 3회 연장해 총 최대 24개월까지 지원합니다. 이중언어 부모코칭, 부모-자녀 상호작용프로그램도 함께 제공합니다.',
  '관할 가족센터(다문화가족지원센터)를 방문하거나 전화로 신청합니다.',
  array['가족관계증명서', '아동 언어발달 관련 소견서(있는 경우)'],
  array['기초생활수급자·기준 중위소득 52% 이하 가구가 우선 선정됩니다', '초등학교 재학 중이면 만 12세를 초과해도 신청할 수 있습니다'],
  '[]'::jsonb,
  '여성가족부(→성평등가족부)', 'https://www.mogef.go.kr/',
  '기초생활수급자·기준 중위소득 52% 이하 우선 선정', null, 12, null,
  null, null, true,
  '여성가족부 기준 정리', current_date, true,
  'multicultural-child-language-development-support', 2026, true
from regions r, categories c
where r.slug = 'nationwide' and c.slug = 'multicultural'
on conflict (slug) do nothing;

-- 다문화가족 자녀 교육활동비 지원
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
  'multicultural-child-education-activity-cost-support',
  '다문화가족 자녀 교육활동비 지원',
  '교육급여를 받지 못하는 다문화가족의 초·중·고 자녀에게 교재비·학원비 등에 쓸 수 있는 카드 포인트를 지급하는 여성가족부 제도입니다.',
  r.id, c.id,
  '교육급여(기준 중위소득 50% 이하)를 받지 못하면서 기준 중위소득 100% 이하인 다문화가족의 만 7~18세(초1~고3) 자녀가 대상입니다.',
  '초등학생 연 40만원, 중학생 연 50만원, 고등학생 연 60만원을 신청자 명의 NH농협카드(채움) 포인트로 지급합니다. 교재비, 독서실 이용료, 예체능 학원비, 자격증 응시료 등에 사용할 수 있습니다.',
  '자녀 주소지의 가족센터(다문화가족지원센터)에서 신청합니다. 통상 매년 6월(2026년 기준 6월 1일~6월 30일)에 연 1회 모집하며, 정확한 공고 시점은 지자체별로 다를 수 있습니다.',
  array['가족관계증명서', '소득 증빙서류', 'NH농협카드(채움) 신청 서류'],
  array['교육급여를 받는 가구는 중복 신청할 수 없습니다', '연 1회 모집이므로 매년 6월 공고를 놓치지 않도록 확인하세요'],
  '[]'::jsonb,
  '여성가족부(→성평등가족부)', 'https://www.mogef.go.kr/',
  '기준 중위소득 100% 이하(교육급여 미수급 가구)', 7, 18, null,
  null, null, false,
  '여성가족부 및 복지로 기준 정리', current_date, true,
  'multicultural-child-education-activity-cost-support', 2026, true
from regions r, categories c
where r.slug = 'nationwide' and c.slug = 'multicultural'
on conflict (slug) do nothing;

-- 다문화가족 주택 특별공급
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
  'multicultural-family-housing-special-supply',
  '다문화가족 주택 특별공급',
  '다문화가족에게 국민주택 등을 청약 경쟁 없이 특별공급받을 수 있도록 하는 국토교통부의 법정 우선공급 제도입니다.',
  r.id, c.id,
  '결혼이민자 또는 귀화·인지로 한국국적을 취득한 사람과 한국국적자로 구성된 다문화가족 구성원으로서, 배우자와 3년 이상 같은 주소지에 거주하고 입주자모집공고일 현재 무주택세대구성원이어야 합니다.',
  '청약 경쟁 없이 국민주택 등을 특별공급받을 수 있습니다(1세대 1주택 한정). 배점기준표에 따른 종합점수 순으로 우선순위가 정해지며, 실제 공급 물량은 개별 공공주택 단지 공고에 따라 다릅니다.',
  '관할 지자체 또는 LH 청약시스템을 통해 특별공급 대상자로 추천·신청합니다. 개별 공공주택 공급 공고가 날 때마다 신청 기간이 정해집니다.',
  array['혼인관계증명서 또는 가족관계증명서(다문화가족 증빙)', '주민등록등본', '무주택 확인서류'],
  array['제도 자체는 전국 공통이지만 실제 공급 물량은 단지별 공고에 따라 지역마다 차이가 큽니다', '배우자와 3년 이상 동일 주소지 거주 요건을 반드시 확인하세요'],
  '[]'::jsonb,
  '국토교통부·한국토지주택공사(LH)', 'https://www.molit.go.kr/',
  null, null, null, '다문화가족',
  null, null, true,
  '국토교통부(주택공급에 관한 규칙) 및 LH 기준 정리', current_date, true,
  'multicultural-family-housing-special-supply', 2026, true
from regions r, categories c
where r.slug = 'nationwide' and c.slug = 'multicultural'
on conflict (slug) do nothing;

-- 외국인력상담센터 무료 다국어 상담(EPS)
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
  'eps-foreign-worker-counseling-center',
  '외국인력상담센터 무료 다국어 상담(EPS)',
  '고용허가제로 국내에서 일하는 외국인근로자에게 18개 언어로 무료 전화상담을 제공하는 고용노동부·산업인력공단 서비스입니다.',
  r.id, c.id,
  '고용허가제(E-9, H-2 등)로 체류하는 외국인근로자와 사업주가 대상입니다.',
  '1577-0071로 전화한 뒤 언어별 국가번호를 선택하면 18개 언어로 고충 상담, 근로조건 안내, 사업장변경 절차 등 행정·생활상담과 통역을 받을 수 있습니다.',
  '전화 1577-0071로 상담을 신청합니다. 별도 방문접수는 운영하지 않습니다.',
  array['별도 서류 없이 전화로 바로 이용 가능'],
  array['과거 운영되던 전국 44개 거점 대면상담형 "외국인노동자지원센터"는 2023년 예산 삭감으로 2024년 폐지되었으며, 현재는 이 전화상담 체계로 운영됩니다', '상담원 연결이 지연될 수 있으니 업무시간 내 여유 있게 전화하는 것이 좋습니다'],
  '[]'::jsonb,
  '고용노동부·한국산업인력공단(HRD Korea)', 'https://www.eps.go.kr/',
  null, null, null, null,
  null, null, true,
  '고용노동부 및 한국산업인력공단 기준 정리', current_date, true,
  'eps-foreign-worker-counseling-center', 2026, true
from regions r, categories c
where r.slug = 'nationwide' and c.slug = 'multicultural'
on conflict (slug) do nothing;
