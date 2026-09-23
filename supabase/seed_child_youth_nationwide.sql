-- =============================================================================
-- "아동·청소년" 카테고리 콘텐츠 1차 배치: 국가 단위(전국 공통) 지원제도 5건
--
-- 이 파일을 실행하려면 먼저 seed_child_youth_category.sql(카테고리 신설)을
-- 실행해야 합니다. 전국 공통 제도라 기존에 만들어둔 가상 지역
-- "전국"(slug: nationwide)을 그대로 사용합니다.
--
-- 조사 결과 다음 항목은 이번 배치에서 제외했습니다.
--  - 아동수당: 2026년 확대돼도 상한이 만 9세 미만이라 초중고 학생보다는
--    영유아~초1 가구 대상에 가까워 기존 "출산·육아" 카테고리 영역으로 보고
--    제외했습니다.
--  - 방과후자유수강권·현장체험학습비·졸업앨범비·인터넷통신비 등 교육급여
--    부가 항목: 시·도교육청별로 금액이 달라 전국 공통 금액을 확정할 수
--    없어 제외했습니다(교육급여 체크리스트에 안내만 남겼습니다).
--  - 저소득층 자녀 교육정보화 지원(PC·인터넷비): 출처마다 금액이 달라
--    신뢰할 수 있는 단일 수치를 확인하지 못해 제외했습니다.
-- =============================================================================

-- 교육급여
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
  'education-benefit-child-youth',
  '교육급여',
  '저소득층 초·중·고 학생에게 교육활동지원비를 바우처로 지급하고, 고등학생은 입학금·수업료·교과서비까지 지원하는 국가 기초생활보장 제도입니다.',
  r.id, c.id,
  '초·중·고에 재학 중이며, 가구 소득인정액이 기준 중위소득 50% 이하인 학생이 대상입니다. 부양의무자 기준은 적용되지 않습니다.',
  '2026학년도 교육활동지원비는 초등학생 연 50만 2,000원, 중학생 연 69만 9,000원, 고등학생 연 86만원을 바우처로 지급합니다. 고등학생은 무상교육 대상이 아닌 경우 입학금·수업료·교과서비도 전액 지원받습니다.',
  '읍·면·동 행정복지센터를 방문하거나 복지로(bokjiro.go.kr), 교육비 원클릭(oneclick.neis.go.kr)에서 온라인으로 신청합니다. 2026년 집중신청기간은 3월 3일~3월 20일입니다.',
  array['사회보장급여 신청서', '소득·재산 신고서', '금융정보 등 제공동의서'],
  array['현금이 아닌 바우처로 지급됩니다', '만 14세 이상 학생 본인도 신청할 수 있습니다', '급식비·방과후자유수강권 등은 시·도교육청별로 별도 운영되니 교육청 공고를 확인하세요'],
  '[]'::jsonb,
  '교육부·보건복지부', 'https://www.bokjiro.go.kr/',
  '기준 중위소득 50% 이하', null, null, null,
  null, null, false,
  '대한민국 정책브리핑 및 복지로 기준 정리', current_date, true,
  'education-benefit-child-youth', 2026, true
from regions r, categories c
where r.slug = 'nationwide' and c.slug = 'child-youth'
on conflict (slug) do nothing;

-- 드림스타트
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
  'dream-start-child-support',
  '드림스타트',
  '취약계층 아동에게 건강·정서·인지발달·가족지원을 통합적으로 제공하는 사례관리형 돌봄 서비스입니다.',
  r.id, c.id,
  '만 12세 이하(초등학생 이하) 아동 중 국민기초생활수급, 차상위계층, 한부모가족 등 취약 가구가 대상입니다. 중·고등학생은 대상이 아닙니다.',
  '건강검진, 가정방문, 학습·정서 지원, 각종 복지서비스 연계 등을 사례관리사가 맞춤형으로 제공합니다. 정해진 현금 지급액은 없으며 아동별 상황에 따라 서비스 내용이 달라집니다.',
  '관할 시·군·구 드림스타트센터를 방문하거나 전화로 신청하며, 정부24(gov.kr) 온라인 신청도 가능합니다.',
  array['신분증', '가족관계증명서'],
  array['만 12세 이하(초등학생 이하)까지만 대상입니다', '현금이나 정액 바우처가 아닌 사례관리 서비스입니다'],
  '[]'::jsonb,
  '보건복지부·국가아동권리보장원', 'https://www.mohw.go.kr/',
  null, null, 12, null,
  null, null, true,
  '보건복지부 및 정부24 기준 정리', current_date, true,
  'dream-start-child-support', 2026, true
from regions r, categories c
where r.slug = 'nationwide' and c.slug = 'child-youth'
on conflict (slug) do nothing;

-- 청소년 방과후 아카데미
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
  'youth-after-school-academy',
  '청소년 방과후 아카데미',
  '초4~중3 청소년에게 학습·체험·급식 등을 무료로 제공하는 여성가족부의 방과후 돌봄 프로그램입니다.',
  r.id, c.id,
  '초등학교 4학년~중학교 3학년 청소년이 대상이며, 저소득층·한부모·조손·다문화·장애가정·2자녀 이상·맞벌이 가정이 우선 선발됩니다.',
  '학습지원, 체험활동, 급식, 상담 등을 이용료 전액 무료로 제공합니다. 교재비 등 일부 실비만 자기부담입니다.',
  '정부24(gov.kr) 온라인 또는 가까운 청소년수련관 등 청소년방과후아카데미 운영기관을 방문·전화로 신청합니다. 청소년활동정보서비스(youth.go.kr)에서 운영기관을 찾을 수 있습니다.',
  array['신청서', '가구 소득·가족 상황 증빙서류(우선선발 해당 시)'],
  array['우선선발 대상에 해당하면 선발에 유리합니다', '교재비 등 일부 실비는 자기부담입니다'],
  '[]'::jsonb,
  '여성가족부·한국청소년활동진흥원', 'https://www.youth.go.kr/',
  null, null, null, null,
  null, null, true,
  '여성가족부 및 정부24 기준 정리', current_date, true,
  'youth-after-school-academy', 2026, true
from regions r, categories c
where r.slug = 'nationwide' and c.slug = 'child-youth'
on conflict (slug) do nothing;

-- 복권기금 꿈사다리 우수 장학금
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
  'dream-ladder-scholarship',
  '복권기금 꿈사다리 우수 장학금',
  '성장 가능성이 큰 저소득층 초5~고3 학생을 선발해 매달 학업장려금을 지원하고 대학 진학까지 연계하는 국가 장학사업입니다.',
  r.id, c.id,
  '초등학교 5학년~고등학교 3학년 재학생 중 국민기초생활수급자, 한부모가족지원대상자, 법정차상위계층 학생이 대상이며, 학교장 추천을 받아 성장가능성·인성 등을 종합평가해 선발합니다.',
  '매달 학업장려금을 카드 포인트로 지급합니다(초등학생 15만원, 중학생 25만원, 고등학생 35만원). 2026학년도 선발 규모는 꿈장학금 2,700명, 다문화장학금 300명 등 총 3,000명이며, 1:1 멘토링과 진로컨설팅도 함께 제공합니다.',
  '학교 추천을 받아 한국장학재단 학자금지원시스템에서 온라인으로 접수합니다. 2026학년도 신청 기간은 4월 6일~4월 30일이며, 서류심사와 심층평가를 거쳐 7월에 최종 선발합니다.',
  array['학교장 추천서', '가구 소득·가족 상황 증빙서류'],
  array['학교장 추천이 있어야 신청할 수 있습니다', '서류심사와 심층평가를 거쳐 최종 선발되므로 경쟁이 있습니다'],
  '[]'::jsonb,
  '교육부·한국장학재단', 'https://www.kosaf.go.kr/',
  null, null, null, null,
  null, null, false,
  '대한민국 정책브리핑 및 한국장학재단 기준 정리', current_date, true,
  'dream-ladder-scholarship', 2026, true
from regions r, categories c
where r.slug = 'nationwide' and c.slug = 'child-youth'
on conflict (slug) do nothing;

-- 문화누리카드
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
  'culture-nuri-card',
  '문화누리카드',
  '저소득층에게 공연·영화·도서·여행 등에 쓸 수 있는 문화바우처를 지급하는 제도로, 청소년은 추가 금액을 더 받습니다.',
  r.id, c.id,
  '만 6세 이상 국민기초생활수급자, 법정차상위계층이 대상입니다. 만 13~18세 청소년과 만 60~64세는 추가 지원을 받습니다.',
  '1인당 연 15만원을 문화바우처로 지급하며, 만 13~18세 청소년과 만 60~64세는 1만원을 추가해 연 16만원을 받습니다. 공연·영화·도서·여행·체육 등에 사용할 수 있으며, 미사용액은 연말에 소멸합니다.',
  '문화누리카드 누리집(mnuri.kr) 온라인 또는 주소지 읍·면·동 주민센터를 방문해 신청합니다. 2026년 신청 가능 기간은 2월 2일~11월 30일입니다.',
  array['신분증', '수급자 또는 차상위계층 증빙서류'],
  array['현금이 아닌 문화바우처로 지급되며 미사용액은 연말에 소멸합니다', '청소년(만 13~18세)은 기본 금액에 1만원이 추가됩니다'],
  '[]'::jsonb,
  '문화체육관광부', 'https://www.mnuri.kr/',
  null, 6, null, null,
  null, null, false,
  '문화체육관광부 보도자료 기준 정리', current_date, true,
  'culture-nuri-card', 2026, true
from regions r, categories c
where r.slug = 'nationwide' and c.slug = 'child-youth'
on conflict (slug) do nothing;
