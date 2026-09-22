-- =============================================================================
-- 전국 확대 1차 배치 (2026년 기준): 부산·대구·광주·대전 신규 지역 추가
-- 각 광역시별 확인 가능한 실제 제도부터 넣었습니다. 카테고리를 전부 채우지
-- 못한 지역은 다음 배치에서 이어서 조사합니다.
-- =============================================================================

-- regions ----------------------------------------------------------------
insert into regions (slug, name, level, parent_id) values
  ('busan', '부산광역시', 'sido', null),
  ('daegu', '대구광역시', 'sido', null),
  ('gwangju', '광주광역시', 'sido', null),
  ('daejeon', '대전광역시', 'sido', null)
on conflict (slug) do nothing;

-- 부산 청년 디딤돌카드+ (youth)
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
  'busan-youth-didimdol-card',
  '부산 청년 디딤돌카드+',
  '부산의 미취업 청년에게 사회진입 활동비를 지원하는 제도입니다.',
  r.id, c.id,
  '공고일 기준 부산에 주민등록을 둔 만 18~39세 청년으로, 최종학력 졸업(중퇴·제적 포함, 재학생 제외)자여야 합니다. 고용보험(상용) 미가입·사업자등록이 없거나, 고용보험 가입자라도 주 근로시간 30시간 미만이면서 사업자등록이 없어야 하며, 건강보험료 기준 소득 요건도 충족해야 합니다.',
  '월 30만원씩 최대 6개월(총 180만원)을 지원합니다. 학원비, 인터넷 강의, 교재비, 면접정장 구입 등 구직 관련 비용에 사용할 수 있으며, 조건 충족 시 참여 성공 수당 30만원이 추가로 지급됩니다.',
  '부산청년플랫폼 또는 청년디딤돌카드+ 전용 홈페이지에서 온라인으로 신청합니다.',
  array['최종학력 졸업증명서', '건강보험료 납부확인서', '고용보험 미가입 확인서류'],
  array['재학생·휴학생은 신청할 수 없습니다', '고용보험(상용) 가입자이거나 사업자등록이 있다면 대상이 아닙니다', '참여 성공 수당은 조건을 충족해야 추가로 지급됩니다'],
  '[]'::jsonb,
  '부산시 청년정책담당관', 'https://young.busan.go.kr/',
  '건강보험료 납부액 기준 소득 요건', 18, 39, null,
  null, null, false,
  '부산시 공고 및 공식 홈페이지 기준 정리', current_date, true,
  'busan-youth-didimdol-card', 2026, true
from regions r, categories c
where r.slug = 'busan' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 부산 신혼부부 주택융자 및 대출이자 지원 (marriage)
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
  'busan-newlywed-housing-loan-interest',
  '부산 신혼부부 주택융자 및 대출이자 지원',
  '부산 거주 신혼부부의 전세자금 대출이자를 지원하는 제도로, 연간 1,500세대 규모로 운영됩니다.',
  r.id, c.id,
  '부부합산 연소득 1억 3천만원 이하이며, 임차보증금 4억원 이하 주택(아파트·주거용 오피스텔 포함)에 확정일자부 임대차계약을 체결해야 합니다.',
  '부산은행이 임차보증금의 90% 이내, 최대 2억원까지 대출을 취급하며(한국주택금융공사가 대출금 100% 보증), 최대 연 2.0% 이자를 지원합니다. 연간 최대 400만원까지 이자 부담을 줄일 수 있으며, 지원 기간은 2년이나 임신·출산·난임치료 등 요건 충족 시 최장 10년까지 연장됩니다.',
  '부산은행 모바일 뱅킹 앱에서 신청 기간 내 수시 접수합니다(별도 선정 절차 없음). 당해 연도 예산 소진 시 신청 기간 중이라도 마감될 수 있습니다.',
  array['혼인관계증명서', '확정일자부 임대차계약서', '부부합산 소득 증빙서류'],
  array['부부합산 연소득이 1억 3천만원을 넘지 않는지 확인하세요', '임차보증금이 4억원을 넘지 않는지 확인하세요', '예산 소진으로 조기 마감될 수 있으니 서둘러 신청하세요'],
  '[]'::jsonb,
  '부산시 주택정책과', 'https://www.busan.go.kr/childcare/childcare010105',
  '부부합산 연소득 1억 3천만원 이하', null, null, '신혼부부',
  null, null, false,
  '부산시 공고 및 언론 보도 기준 정리', current_date, true,
  'busan-newlywed-housing-loan-interest', 2026, true
from regions r, categories c
where r.slug = 'busan' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 대구 청년희망적금 (youth)
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
  'daegu-youth-hope-savings',
  '대구 청년희망적금',
  '대구·경북에서 근로 중인 청년의 저축을 돕기 위해 대구시가 매칭 지원금을 얹어주는 제도입니다.',
  r.id, c.id,
  '신청일 기준 주민등록 주소가 대구시인 만 19~39세 청년으로, 신청일 현재 대구·경북 소재 사업장에서 고용보험에 가입해 근로 중이어야 합니다. 1인 기준 중위소득 120% 이하이며, 지정 기간 중 8개월 이상 근로를 유지해야 합니다.',
  '청년희망적금 전용계좌에 월 10만원씩 12개월 저축하면, 12개월 후 대구시가 120만원을 추가로 지원합니다(본인 납입 120만원 + 지원금 120만원 = 총 240만원).',
  '청년사회진입활동지원시스템(youthdream.daegu.go.kr)에서 온라인으로 신청합니다.',
  array['재직증명서', '고용보험 가입 확인서', '소득 증빙서류'],
  array['근로를 8개월 이상 유지하지 못하면 지원금을 받지 못할 수 있습니다', '대구·경북 소재 사업장 근로자만 대상입니다', '월 10만원 저축을 12개월 동안 유지해야 합니다'],
  '[]'::jsonb,
  '대구시 청년정책과', 'https://youthdream.daegu.go.kr/',
  '1인 기준 중위소득 120% 이하', 19, 39, null,
  null, null, false,
  '대구시 공고 및 공식 홈페이지 기준 정리', current_date, true,
  'daegu-youth-hope-savings', 2026, true
from regions r, categories c
where r.slug = 'daegu' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 대전 청년 월세 지원사업 (housing)
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
  'daejeon-youth-rent-support',
  '대전 청년 월세 지원사업',
  '대전시가 전액 시비로 운영하는 청년 월세 지원 제도로, 1,000명 규모로 선정합니다.',
  r.id, c.id,
  '신청일 기준 대전에 주민등록을 두고 거주하는 만 19~39세 무주택 청년이 대상입니다.',
  '실제 납부한 월세 범위에서 매달 최대 20만원씩 12개월간 최대 240만원을 지급합니다.',
  '대전청년포털(daejeonyouthportal.kr)에서 온라인으로 신청합니다.',
  array['임대차계약서', '월세 이체 내역', '주민등록등본'],
  array['선정 인원이 1,000명으로 한정되어 있어 조기 마감될 수 있습니다', '무주택 여부를 미리 확인하세요'],
  '[]'::jsonb,
  '대전시 청년정책과', 'https://www.daejeonyouthportal.kr/',
  null, 19, 39, null,
  null, null, false,
  '대전시 공고 및 언론 보도 기준 정리', current_date, true,
  'daejeon-youth-rent-support', 2026, true
from regions r, categories c
where r.slug = 'daejeon' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 대전 청년도전지원사업 (youth)
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
  'daejeon-youth-challenge-support',
  '대전 청년도전지원사업',
  '구직을 오래 쉬었던 대전 청년의 사회 복귀를 돕기 위해 맞춤형 프로그램과 참여수당을 지원하는 제도입니다.',
  r.id, c.id,
  '대전에 거주하는 구직단념청년 등이 대상이며, 정확한 연령·소득 기준은 대전청년포털 공고문에서 확인해야 합니다.',
  '참여 프로그램 기간에 따라 단기 50만원, 중기 최대 150만원, 장기 최대 250만원의 참여수당을 지급합니다. 일상 회복과 노동시장 참여를 돕는 맞춤형 프로그램이 함께 제공됩니다.',
  '대전청년포털(daejeonyouthportal.kr) 또는 대전일자리경제진흥원을 통해 신청합니다.',
  array['신분증', '구직단념 관련 증빙서류(해당 시)'],
  array['프로그램 유형(단기·중기·장기)에 따라 참여수당이 다릅니다', '정확한 신청 자격은 공고문을 확인하세요'],
  '[]'::jsonb,
  '대전일자리경제진흥원', 'https://www.daejeonyouthportal.kr/',
  null, null, null, null,
  null, null, false,
  '대전시 공고 및 공식 홈페이지 기준 정리', current_date, true,
  'daejeon-youth-challenge-support', 2026, true
from regions r, categories c
where r.slug = 'daejeon' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 광주 청년구직활동수당 (youth)
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
  'gwangju-youth-job-seeking-allowance',
  '광주 청년구직활동수당',
  '광주의 미취업 청년에게 구직활동수당을 지원하는 제도입니다.',
  r.id, c.id,
  '광주시에 주민등록을 두고 있는 만 19~39세 미취업 청년으로, 소득이 기준 중위소득 150% 이하여야 합니다. 재학생·휴학생·졸업예정자는 제외되며, 최종 학력 졸업·중퇴·제적·수료자만 참여할 수 있습니다.',
  '월 50만원씩 최대 6개월(총 300만원)을 지원합니다.',
  '전남광주청년통합플랫폼(youth.gwangju.go.kr)에서 온라인으로 신청합니다. 연중 여러 차수로 나누어 모집합니다.',
  array['최종학력 졸업증명서', '소득 증빙서류'],
  array['재학생·휴학생·졸업예정자는 신청할 수 없습니다', '모집 차수별 신청 기간을 놓치지 않도록 공고문을 확인하세요'],
  '[]'::jsonb,
  '광주시 청년정책담당관', 'https://youth.gwangju.go.kr/',
  '기준 중위소득 150% 이하', 19, 39, null,
  null, null, false,
  '광주시 공고 및 공식 홈페이지 기준 정리', current_date, true,
  'gwangju-youth-job-seeking-allowance', 2026, true
from regions r, categories c
where r.slug = 'gwangju' and c.slug = 'youth'
on conflict (slug) do nothing;
