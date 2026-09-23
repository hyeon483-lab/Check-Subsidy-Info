-- =============================================================================
-- 연도별 히스토리 2차 배치: 간판급 청년 지원제도 4종
-- 서울시 청년수당, 대구 청년희망적금, 부산 청년 디딤돌카드+, 울산 청년수당
--
-- is_current = false로 저장되어 목록에는 노출되지 않고, 각 제도 현재
-- 페이지의 "연도별 보기" 탭에서만 연결됩니다.
--
-- 울산은 현재(2026년, program_slug: ulsan-youth-allowance) "울산 청년수당"
-- 이라는 이름이지만, 2025년까지는 "울산청년 구직지원금"이라는 다른 이름으로
-- 운영되었고 금액도 절반(월 30만원) 수준이었던 것으로 확인되어, 과거 연도
-- 기록은 당시 실제 명칭으로 제목을 표기했습니다.
--
-- 조사 범위 밖이라 확인하지 못한 연도는 채우지 않았습니다(예: 서울 청년수당
-- 2020·2021년, 대구 청년희망적금 2023년, 부산 디딤돌카드+ 2025년).
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 서울시 청년수당 (program_slug: seoul-youth-allowance)
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
  'seoul-youth-allowance-2022',
  '서울시 청년수당 (2022년)',
  '2022년에 시행된 서울시 청년수당으로, 약 2만명 규모로 모집되었습니다.',
  r.id, c.id,
  '서울시에 거주하는 만 19~34세 미취업 청년(최종학력 졸업자)으로, 가구 중위소득 150% 이하였습니다. 재학생과 유사·중복 사업 참여자는 제외됐으나, 주 26시간 이하 또는 3개월 이하 단기근로자는 지원 대상에 포함됐습니다.',
  '매월 50만원씩 최장 6개월(최대 300만원)을 지원했습니다.',
  '청년몽땅정보통에서 온라인으로 접수했습니다. 2022년 신청 기간은 3월 14일~3월 23일이었고, 약 2만명을 선발했습니다.',
  array['최종학력 졸업증명서', '가족관계증명서', '소득 증빙서류'],
  array['이 페이지는 2022년도 종료된 모집 정보입니다', '최신 연도 신청 조건은 현재 페이지를 확인하세요'],
  '[]'::jsonb,
  '서울시 청년정책담당관', 'https://youth.seoul.go.kr/',
  '기준 중위소득 150% 이하', 19, 34, null,
  null, null, false,
  '서울시 미디어허브 보도자료 기준 정리 (과거 연도 기록)', current_date, true,
  'seoul-youth-allowance', 2022, false
from regions r, categories c
where r.slug = 'seoul' and c.slug = 'youth'
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
  'seoul-youth-allowance-2019',
  '서울시 청년수당 (2019년)',
  '2019년에 시행된 서울시 청년수당으로, 평생 1회만 받을 수 있는 제한이 있었습니다.',
  r.id, c.id,
  '서울시에 거주하는 만 19~34세 미취업 청년으로, 소득 기준은 건강보험료 부과액으로 구체적으로 명시되어 2019년 7월 기준 지역가입자 24만 5,305원·직장가입자 22만 6,441원 미만이어야 했습니다. 2017~2018년에 이미 청년수당을 받은 적이 있으면 신청할 수 없었습니다(평생 1회 제한, 이후 정책에서 완화됨).',
  '매월 50만원씩 최장 6개월(최대 300만원)을 지원했습니다.',
  '청년몽땅정보통에서 온라인으로 접수했습니다. 2019년에는 13,945명이 신청해 5,205명이 최종 선정됐습니다(경쟁률 2.7대 1).',
  array['최종학력 졸업증명서', '가족관계증명서', '건강보험료 납부확인서'],
  array['이 페이지는 2019년도 종료된 모집 정보입니다', '당시에는 평생 1회만 받을 수 있는 제한이 있었으나 현재는 재참여 조건이 달라졌으니 최신 페이지를 확인하세요'],
  '[]'::jsonb,
  '서울시 청년정책담당관', 'https://youth.seoul.go.kr/',
  '건강보험료 부과액 기준 (지역가입자 24만 5,305원·직장가입자 22만 6,441원 미만, 2019년 7월 기준)', 19, 34, null,
  null, null, false,
  '서울시 정보소통광장 공고 및 언론 보도 기준 정리 (과거 연도 기록)', current_date, true,
  'seoul-youth-allowance', 2019, false
from regions r, categories c
where r.slug = 'seoul' and c.slug = 'youth'
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
  'seoul-youth-allowance-2016',
  '서울시 청년수당 (2016년)',
  '2016년 제도 도입 첫 해의 서울시 청년수당으로, 만 29세 이하·저소득층 우선으로 3,000명만 선발했습니다.',
  r.id, c.id,
  '서울시에 거주하는 만 19~29세 미취업 청년(현행 만 19~34세보다 좁은 연령대)으로, 저소득층이 우선 선발됐습니다.',
  '매월 50만원씩 최장 6개월(최대 300만원)을 지원했습니다.',
  '서울시 공고를 통해 신청했으며, 도입 첫 해라 3,000명만 우선 선발하는 소규모로 시작했습니다.',
  array['최종학력 졸업증명서', '가족관계증명서', '소득 증빙서류'],
  array['이 페이지는 2016년도 종료된 모집 정보입니다(제도 도입 첫 해)', '최신 연도 신청 조건은 현재 페이지를 확인하세요'],
  '[]'::jsonb,
  '서울시 청년정책담당관', 'https://youth.seoul.go.kr/',
  null, 19, 29, null,
  null, null, false,
  '서울신문 및 한국일보 보도 기준 정리 (과거 연도 기록)', current_date, true,
  'seoul-youth-allowance', 2016, false
from regions r, categories c
where r.slug = 'seoul' and c.slug = 'youth'
on conflict (slug) do nothing;

-- -----------------------------------------------------------------------------
-- 대구 청년희망적금 (program_slug: daegu-youth-hope-savings)
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
  'daegu-youth-hope-savings-2024',
  '대구 청년희망적금 (2024년)',
  '2024년에 시행된 대구 청년희망적금으로, 본예산 전액 삭감 후 추경예산으로 복구되어 예정대로 모집됐습니다.',
  r.id, c.id,
  '대구시에 주민등록을 둔 만 19~39세 청년으로, 대구·경북 소재 사업장에서 고용보험에 가입해 근로 중이어야 했습니다. 본인 근로소득 세전 71만원~268만원, 가구 기준중위소득 140% 이하(현행 120% 이하보다 완화된 기준)여야 했습니다.',
  '청년희망적금 전용계좌에 월 10만원씩 12개월 저축하면 대구시가 120만원을 추가로 지원했습니다(본인 납입 120만원 + 지원금 120만원 = 총 240만원).',
  '청년사회진입활동지원시스템에서 온라인으로 신청했습니다. 2024년에는 840명을 선정했고, 접수 기간은 6월 17일~7월 5일이었습니다.',
  array['재직증명서', '고용보험 가입 확인서', '소득 증빙서류'],
  array['이 페이지는 2024년도 종료된 모집 정보입니다', '이 해에는 사업 예산이 본예산에서 전액 삭감됐다가 추경예산으로 복구되는 우여곡절이 있었습니다', '최신 연도 신청 조건은 현재 페이지를 확인하세요'],
  '[]'::jsonb,
  '대구시 청년정책과', 'https://youthdream.daegu.go.kr/',
  '가구 기준중위소득 140% 이하 (본인 근로소득 세전 71만원~268만원)', 19, 39, null,
  null, null, false,
  '영남일보 및 뉴스민 보도 기준 정리 (과거 연도 기록)', current_date, true,
  'daegu-youth-hope-savings', 2024, false
from regions r, categories c
where r.slug = 'daegu' and c.slug = 'youth'
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
  'daegu-youth-hope-savings-2022',
  '대구 청년희망적금 (2022년)',
  '2022년에 시행된 대구 청년희망적금으로, 저축 기간이 현행(12개월)보다 짧은 6개월이었습니다.',
  r.id, c.id,
  '대구시에 주민등록을 둔 만 19~34세 청년(현행 19~39세보다 좁은 연령대)으로, 대구·경북 소재 사업장에서 6개월 이상 근로를 지속해야 했습니다. 본인 월 소득 세전 50만원~191만 4,440원, 부양의무자 가구 기준중위소득 120% 이하, 졸업(예정)자 또는 휴학생이어야 했습니다.',
  '청년희망적금 전용계좌에 6개월간 월 10만원씩 저축하면(총 60만원) 대구시가 180만원을 추가로 지원했습니다(총 240만원, 현행과 총액은 같지만 저축 기간과 매칭 비율이 다릅니다).',
  '청년사회진입활동지원시스템에서 온라인으로 신청했습니다. 2022년 접수 기간은 2월 7일~3월 7일이었고, 2차 모집도 추가로 진행됐습니다.',
  array['재직증명서', '재학·휴학 증빙서류', '소득 증빙서류'],
  array['이 페이지는 2022년도 종료된 모집 정보입니다', '저축 기간이 6개월로 현행 12개월과 다릅니다', '최신 연도 신청 조건은 현재 페이지를 확인하세요'],
  '[]'::jsonb,
  '대구시 청년정책과', 'https://youthdream.daegu.go.kr/',
  '부양의무자 가구 기준중위소득 120% 이하 (본인 월 소득 세전 50만원~191만 4,440원)', 19, 34, null,
  null, null, false,
  '국제뉴스 및 대구시 공고 기준 정리 (과거 연도 기록)', current_date, true,
  'daegu-youth-hope-savings', 2022, false
from regions r, categories c
where r.slug = 'daegu' and c.slug = 'youth'
on conflict (slug) do nothing;

-- -----------------------------------------------------------------------------
-- 부산 청년 디딤돌카드+ (program_slug: busan-youth-didimdol-card)
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
  'busan-youth-didimdol-card-2024',
  '부산 청년 디딤돌카드+ (2024년)',
  '2024년에 시행된 부산 청년 디딤돌카드+로, 지원 연령이 만 39세까지 확대되며 현행과 같은 지원 구조가 시작된 해입니다.',
  r.id, c.id,
  '부산에 주민등록을 둔 만 18~39세 미취업 청년이 대상이었습니다(전년도 18~34세에서 연령 상한이 확대됨).',
  '월 30만원씩 최대 6개월(총 180만원)을 지원하고, 5개월 이내 취업·창업에 성공하면 취업성공금 30만원을 1회 추가로 지급했습니다(전년도 월 50만원 정액 지급에서 금액은 줄고 성공수당이 신설됨).',
  '부산청년플랫폼에서 온라인으로 신청했습니다. 2024년 신청 기간은 3월 29일~4월 12일, 사업 기간은 6월~11월이었습니다.',
  array['최종학력 졸업증명서', '건강보험료 납부확인서'],
  array['이 페이지는 2024년도 종료된 모집 정보입니다', '이 해부터 월 지원액이 30만원으로 줄고 취업성공금이 신설된 현행 구조가 시작됐습니다', '최신 연도 신청 조건은 현재 페이지를 확인하세요'],
  '[]'::jsonb,
  '부산시 청년정책담당관', 'https://young.busan.go.kr/',
  null, 18, 39, null,
  null, null, false,
  '부산광역시 공고 기준 정리 (과거 연도 기록)', current_date, true,
  'busan-youth-didimdol-card', 2024, false
from regions r, categories c
where r.slug = 'busan' and c.slug = 'youth'
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
  'busan-youth-didimdol-card-2023',
  '부산 청년 디딤돌카드+ (2023년)',
  '2023년에 시행된 부산 청년 디딤돌카드+로, 월 50만원씩 정액 지원되던 마지막 해입니다.',
  r.id, c.id,
  '부산에 주민등록을 둔 만 18~34세 미취업 청년으로, 기준중위소득 150% 이하여야 했습니다.',
  '월 최대 50만원씩 6개월(최대 300만원)을 지원했습니다(현행 월 30만원+취업성공금 30만원 구조보다 매달 지원액이 더 많았습니다).',
  '부산청년플랫폼에서 온라인으로 신청했습니다. 1차 500명을 선발했고, 사업 기간은 4월~9월이었습니다.',
  array['최종학력 졸업증명서', '건강보험료 납부확인서', '소득 증빙서류'],
  array['이 페이지는 2023년도 종료된 모집 정보입니다', '현행보다 매달 지원액이 많았던 마지막 해입니다', '최신 연도 신청 조건은 현재 페이지를 확인하세요'],
  '[]'::jsonb,
  '부산시 청년정책담당관', 'https://young.busan.go.kr/',
  '기준중위소득 150% 이하', 18, 34, null,
  null, null, false,
  'SENTV 보도 및 웰로 공지 기준 정리 (과거 연도 기록)', current_date, true,
  'busan-youth-didimdol-card', 2023, false
from regions r, categories c
where r.slug = 'busan' and c.slug = 'youth'
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
  'busan-youth-didimdol-card-2022',
  '부산 청년 디딤돌카드+ (2022년)',
  '2022년에 시행된 부산 청년 디딤돌카드+로, 두 차례에 걸쳐 총 1,100명을 선발했습니다.',
  r.id, c.id,
  '부산에 주민등록을 둔 만 18~34세 미취업 청년으로, 기준중위소득 150% 이하여야 했습니다.',
  '월 최대 50만원씩 6개월(최대 300만원)을 지원했습니다.',
  '부산청년플랫폼에서 온라인으로 신청했습니다. 1차 550명(2월), 2차 550명(4월 8일~4월 18일 추가 모집)으로 총 1,100명을 선발했습니다.',
  array['최종학력 졸업증명서', '건강보험료 납부확인서', '소득 증빙서류'],
  array['이 페이지는 2022년도 종료된 모집 정보입니다', '1차·2차로 나뉘어 모집됐습니다', '최신 연도 신청 조건은 현재 페이지를 확인하세요'],
  '[]'::jsonb,
  '부산시 청년정책담당관', 'https://young.busan.go.kr/',
  '기준중위소득 150% 이하', 18, 34, null,
  null, null, false,
  '파이낸셜뉴스 및 뉴시스 보도 기준 정리 (과거 연도 기록)', current_date, true,
  'busan-youth-didimdol-card', 2022, false
from regions r, categories c
where r.slug = 'busan' and c.slug = 'youth'
on conflict (slug) do nothing;

-- -----------------------------------------------------------------------------
-- 울산 청년수당 (program_slug: ulsan-youth-allowance)
-- 2025년까지는 "울산청년 구직지원금"이라는 이름으로 운영되었고 금액도 현행의
-- 절반(월 30만원) 수준이었습니다. 과거 연도 기록은 당시 실제 명칭을 그대로
-- 사용했습니다.
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
  'ulsan-youth-allowance-2025',
  '울산청년 구직지원금 (2025년)',
  '2025년까지 "울산 청년수당"의 전신인 "울산청년 구직지원금"으로 운영됐으며, 지원액이 현행의 절반 수준이었습니다.',
  r.id, c.id,
  '울산에 거주하는 미취업 청년으로, 만 19~34세는 기준중위소득 120~150% 구간, 만 35~39세는 기준중위소득 60~150% 구간이어야 했습니다(현행은 만 19~34세, 중위소득 150% 이하 단일 기준으로 단순화됨).',
  '매월 30만원씩 최대 6개월(최대 180만원)을 클린카드 포인트로 지급했습니다(현행 월 50만원의 절반 수준).',
  '짝수월 1일~10일 상시 접수했습니다.',
  array['최종학력 졸업(중퇴·수료)증명서', '소득 증빙서류'],
  array['이 페이지는 2025년도 "울산청년 구직지원금" 시절의 정보입니다(현재 명칭: 울산 청년수당)', '지원액이 현행의 절반 수준이었습니다', '최신 연도 신청 조건은 현재 페이지를 확인하세요'],
  '[]'::jsonb,
  '울산시 청년정책담당관', 'https://www.ulsan.go.kr/',
  '만 19~34세 중위소득 120~150% / 만 35~39세 중위소득 60~150%', 19, 39, null,
  null, null, true,
  '울산경제일자리진흥원 공고 및 웰로 기준 정리 (과거 연도 기록)', current_date, true,
  'ulsan-youth-allowance', 2025, false
from regions r, categories c
where r.slug = 'ulsan' and c.slug = 'youth'
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
  'ulsan-youth-allowance-2022',
  '울산청년 구직지원금 (2022년)',
  '2022년에 시행된 "울산청년 구직지원금"으로, "울산 청년수당"의 전신입니다.',
  r.id, c.id,
  '울산에 거주하는 만 19~34세 미취업 청년으로, 기준중위소득 120~150% 구간(4인 가구 기준 약 614만 5천원~768만 2천원)이어야 했습니다.',
  '매월 30만원씩 최대 6개월(최대 180만원)을 지원하고, 취업에 성공하면 취업성공금(축하금) 30만원을 1회 추가로 지급했습니다.',
  '울산시 청년정책 공고를 통해 신청했습니다. 120명을 선발했습니다.',
  array['최종학력 졸업(중퇴·수료)증명서', '소득 증빙서류'],
  array['이 페이지는 2022년도 "울산청년 구직지원금" 시절의 정보입니다(현재 명칭: 울산 청년수당)', '지원액이 현행의 절반 수준이었습니다', '최신 연도 신청 조건은 현재 페이지를 확인하세요'],
  '[]'::jsonb,
  '울산시 청년정책담당관', 'https://www.ulsan.go.kr/',
  '기준중위소득 120~150% (4인가구 약 614만 5천원~768만 2천원)', 19, 34, null,
  null, null, false,
  '울산시 공고 기준 정리 (과거 연도 기록)', current_date, true,
  'ulsan-youth-allowance', 2022, false
from regions r, categories c
where r.slug = 'ulsan' and c.slug = 'youth'
on conflict (slug) do nothing;
