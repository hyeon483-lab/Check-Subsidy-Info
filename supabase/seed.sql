-- =============================================================================
-- 실제 지원금 데이터 (2026년 9월 기준, 공식 홈페이지/공고문 기준 정리)
-- 제도는 예산 소진, 조례 개정 등으로 수시로 바뀔 수 있습니다.
-- 반드시 agency_url의 공식 페이지에서 최신 기준을 다시 확인한 뒤 안내하세요.
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

-- benefits (실제 데이터) ---------------------------------------------------
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
  'seoul-youth-rent-support',
  '서울시 청년 월세 지원',
  '서울에 거주하는 무주택 청년의 월세 부담을 줄여주는 서울시 지원 제도입니다.',
  r.id, c.id,
  '신청일 기준 서울시 주민등록을 둔 만 19~39세 무주택 청년으로, 부모와 따로 거주 중이며 가구 기준 중위소득 48% 초과 150% 이하여야 합니다. 임차보증금 8천만원 이하·월세 60만원 이하 주택(또는 보증금 환산액과 월세 합계 93만원 이하) 거주자만 해당하며, 국토부 청년월세 한시특별지원 수령자·공공임대주택 거주자·부모 소유 주택 임차인은 제외됩니다. 2026년부터는 1인가구 청년뿐 아니라 무자녀 신혼부부, 청년 한부모가족, 전세사기피해 청년까지 지원 대상이 확대되었습니다.',
  '월 최대 20만원씩 최장 12개월(생애 1회, 최대 240만원)을 지원합니다. 월세가 20만원보다 적으면 실제 월세만큼만 지급됩니다.',
  '서울주거포털(housing.seoul.go.kr) "청년월세지원" 메뉴에서 자가진단 후 온라인으로 접수합니다. 연중 상시가 아니라 별도 모집 공고 기간에만 신청할 수 있으니 공지사항을 미리 확인해야 합니다.',
  array['임대차계약서', '월세 이체 내역', '가족관계증명서', '소득 증빙서류'],
  array['임대차계약서가 본인 명의인지 확인하세요', '부모 소유 주택에 거주 중이라면 대상이 아닙니다', '국토부 청년월세 한시특별지원을 이미 받았다면 중복 신청이 불가능합니다', '공공임대주택 거주자는 제외 대상입니다'],
  '[{"question": "월세가 20만원보다 적으면 어떻게 되나요?", "answer": "실제 월세 금액만큼만 지원됩니다."}, {"question": "신청 기간이 정해져 있나요?", "answer": "네, 상시 신청이 아니라 서울시가 공고하는 모집 기간에만 신청할 수 있습니다. 서울주거포털 공지사항을 확인하세요."}]'::jsonb,
  '서울시 청년정책담당관',
  'https://housing.seoul.go.kr/',
  '기준 중위소득 48% 초과 150% 이하',
  19, 39, '1인가구',
  null, null, false,
  '서울주거포털 공고 및 언론 보도 기준 정리', current_date, true,
  'seoul-youth-rent-support', 2026, true
from regions r, categories c
where r.slug = 'seoul' and c.slug = 'housing'
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary,
  eligibility = excluded.eligibility, support_content = excluded.support_content,
  application_method = excluded.application_method, required_documents = excluded.required_documents,
  checklist = excluded.checklist, faq = excluded.faq,
  agency_name = excluded.agency_name, agency_url = excluded.agency_url,
  income_condition = excluded.income_condition, age_min = excluded.age_min, age_max = excluded.age_max,
  household_type = excluded.household_type, is_ongoing = excluded.is_ongoing,
  source_name = excluded.source_name, source_updated_at = excluded.source_updated_at,
  is_published = excluded.is_published,
  program_slug = excluded.program_slug, fiscal_year = excluded.fiscal_year, is_current = excluded.is_current;

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
  'seoul-newlywed-loan-interest',
  '서울시 신혼부부 임차보증금 이자지원',
  '전세자금 대출을 받은 서울 거주 신혼(예비)부부에게 이자를 지원하는 제도입니다.',
  r.id, c.id,
  '대출신청일 기준 혼인신고 7년 이내이거나 6개월 이내 결혼 예정인 신혼(예비)부부로, 부부합산 연소득 1억 3천만원 이하이며 본인과 배우자 모두 무주택자여야 합니다. 서울시민이거나 대출 후 1개월 이내 서울로 전입할 예정이어야 합니다.',
  '임차보증금 7억원 이하 주택(주거용 오피스텔·노인복지주택 포함)에 대해 보증금의 90% 이내, 최대 3억원까지 대출 이자를 지원합니다. 부부 1쌍당 생애 최초 1회 지원되며, 조건 충족 시 연장을 통해 최장 10년까지 이용할 수 있습니다.',
  '서울주거포털에서 대상자 여부를 먼저 확인한 뒤, 협약은행을 방문해 대출을 신청합니다.',
  array['혼인관계증명서(또는 예비부부 증빙 서류)', '임대차계약서', '부부합산 소득 증빙서류', '무주택 확인서류'],
  array['부부합산 연소득이 1억 3천만원을 넘지 않는지 확인하세요', '본인과 배우자 모두 무주택자여야 합니다', '임차보증금이 7억원을 넘지 않는 주택인지 확인하세요', '생애 1회만 지원되니 이전에 받은 적이 있는지 확인하세요'],
  '[{"question": "결혼 준비 중인데도 신청할 수 있나요?", "answer": "대출신청일로부터 6개월 이내 결혼식 예정인 예비부부도 신청할 수 있습니다."}]'::jsonb,
  '서울시 주택정책과',
  'https://housing.seoul.go.kr/site/main/content/sh01_0400800',
  '부부합산 연소득 1억 3천만원 이하',
  null, null, '신혼부부',
  null, null, true,
  '서울주거포털 공고 및 언론 보도 기준 정리', current_date, true,
  'seoul-newlywed-loan-interest', 2026, true
from regions r, categories c
where r.slug = 'seoul' and c.slug = 'marriage'
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary,
  eligibility = excluded.eligibility, support_content = excluded.support_content,
  application_method = excluded.application_method, required_documents = excluded.required_documents,
  checklist = excluded.checklist, faq = excluded.faq,
  agency_name = excluded.agency_name, agency_url = excluded.agency_url,
  income_condition = excluded.income_condition, household_type = excluded.household_type,
  is_ongoing = excluded.is_ongoing, source_name = excluded.source_name,
  source_updated_at = excluded.source_updated_at, is_published = excluded.is_published,
  program_slug = excluded.program_slug, fiscal_year = excluded.fiscal_year, is_current = excluded.is_current;

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
  'gyeonggi-basic-income-youth',
  '경기도 청년기본소득',
  '경기도에 일정 기간 거주한 만 24세 청년에게 분기별로 지역화폐를 지급하는 제도입니다.',
  r.id, c.id,
  '신청일 기준 경기도에 주민등록을 둔 만 24세 청년 중 최근 3년 이상 계속 거주했거나 합산 10년 이상 거주한 경우 신청할 수 있습니다. 다만 성남시는 관련 조례가 폐지되었고 고양시는 예산이 편성되지 않아 두 지역은 신청 대상에서 제외됩니다.',
  '분기별 25만원씩 연 최대 100만원을 지역화폐로 지급합니다.',
  '경기청년포털과 연계된 "잡아바 어플라이"에서 온라인으로 신청합니다. 로그인 후 "청년기본소득" 메뉴에서 신청서를 작성하며, 마이데이터 서비스에 동의하면 주민등록초본이 별도 발급 없이 자동 제출됩니다. 신청 기간은 분기마다 다르게 공지됩니다.',
  array['신분증(본인 확인용)', '주민등록초본(마이데이터 미동의 시)'],
  array['거주 중인 시군이 성남시·고양시 등 제외 지역이 아닌지 확인하세요', '해당 분기에 만 24세인지 확인하세요', '최근 3년 계속 거주 또는 합산 10년 거주 요건 중 하나를 충족해야 합니다', '분기별로 각각 신청해야 하며 놓친 분기는 지급되지 않습니다'],
  '[{"question": "한 번 신청하면 4번 다 받을 수 있나요?", "answer": "아니요, 분기마다 별도로 신청해야 하며 신청하지 않은 분기는 지급되지 않습니다."}]'::jsonb,
  '경기도 청년복지정책과',
  'https://youth.gg.go.kr/',
  null,
  24, 24, '무관',
  null, null, true,
  '경기청년포털 공고 기준 정리', current_date, true,
  'gyeonggi-basic-income-youth', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi' and c.slug = 'youth'
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary,
  eligibility = excluded.eligibility, support_content = excluded.support_content,
  application_method = excluded.application_method, required_documents = excluded.required_documents,
  checklist = excluded.checklist, faq = excluded.faq,
  agency_name = excluded.agency_name, agency_url = excluded.agency_url,
  age_min = excluded.age_min, age_max = excluded.age_max, household_type = excluded.household_type,
  is_ongoing = excluded.is_ongoing, source_name = excluded.source_name,
  source_updated_at = excluded.source_updated_at, is_published = excluded.is_published,
  program_slug = excluded.program_slug, fiscal_year = excluded.fiscal_year, is_current = excluded.is_current;

-- 기존 예시 데이터였던 incheon-birth-grant는 아래 실제 제도로 대체합니다.
delete from benefits where slug = 'incheon-birth-grant';

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
  'incheon-postpartum-care-support',
  '인천시 맘편한 산후조리비 지원',
  '인천에 거주하는 취약계층 산모에게 산후조리비를 지역화폐로 지원하는 제도입니다.',
  r.id, c.id,
  '신청일 기준 인천시에 1년 이상 계속 주민등록을 두고 거주 중인 취약계층 산모(기초생활수급자, 차상위계층, 한부모가족, 장애인 등)가 대상입니다. 중앙육아종합지원센터의 부모교육(e-러닝) 이수가 필수 조건입니다.',
  '산모 1인당 150만원을 인천e음 지역화폐 포인트로 지급합니다. 이는 인천시 통합 지원이며, 거주 중인 자치구에 따라 별도의 추가 산후조리비 지원사업이 있을 수 있습니다.',
  '임신 32주부터 출산 후 90일 이내에 거주지 관할 보건소를 통해 신청합니다.',
  array['산모수첩 또는 임신확인서(임신 중 신청 시)', '출생신고 관련 서류(출산 후 신청 시)', '취약계층 증빙서류', '부모교육 이수 확인서'],
  array['신청일 기준 인천시에 1년 이상 계속 거주했는지 확인하세요', '중앙육아종합지원센터 부모교육을 미리 이수해두세요', '임신 32주~출산 후 90일 이내 신청 기간을 놓치지 마세요', '거주 중인 구청 보건소의 추가 자체 지원사업도 함께 확인하세요'],
  '[{"question": "취약계층이 아니어도 받을 수 있나요?", "answer": "이 통합 지원은 기초생활수급자, 차상위계층, 한부모가족, 장애인 등 취약계층 산모를 대상으로 합니다. 해당하지 않는다면 거주 중인 자치구의 별도 산후조리비 지원사업을 확인해보세요."}]'::jsonb,
  '인천시 여성가족과 / 관할 보건소',
  'https://www.incheon.go.kr/welfare/WE020355',
  '기초생활수급자·차상위계층 등 취약계층 기준',
  null, null, null,
  null, null, true,
  '인천광역시청 공식 홈페이지 기준 정리', current_date, true,
  'incheon-postpartum-care-support', 2026, true
from regions r, categories c
where r.slug = 'incheon' and c.slug = 'birth'
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary,
  eligibility = excluded.eligibility, support_content = excluded.support_content,
  application_method = excluded.application_method, required_documents = excluded.required_documents,
  checklist = excluded.checklist, faq = excluded.faq,
  agency_name = excluded.agency_name, agency_url = excluded.agency_url,
  income_condition = excluded.income_condition, is_ongoing = excluded.is_ongoing,
  source_name = excluded.source_name, source_updated_at = excluded.source_updated_at,
  is_published = excluded.is_published,
  program_slug = excluded.program_slug, fiscal_year = excluded.fiscal_year, is_current = excluded.is_current;
