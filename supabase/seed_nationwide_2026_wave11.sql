-- =============================================================================
-- 전국 확대 11차 배치 (2026년 기준): 호남·충청·강원 주요 도시 7곳 확장
-- 전주시(전북), 여수시·순천시·목포시(전남), 청주시(충북), 춘천시·원주시(강원)
--
-- 아래 항목은 도 표준사업(도비 매칭)과 중복되거나 근거가 불충분해 제외했습니다.
--  - 여수시·순천시·목포시 "청년부부 결혼축하금 200만원": 세 도시 모두 금액·
--    자격요건이 동일해 전라남도 표준사업으로 판단되며, 이미 8차 배치에서
--    "전남형 결혼축하금"(전남 전역, 200만원)으로 등록되어 있어 중복 제외.
--  - 순천시·목포시 "출생기본수당(월 20만원, 도-시 매칭)": 이미 등록된
--    "전남 출산·육아복지로"(전남 전역, 0~23개월 월 50만~100만원)와
--    같은 계열의 도-시 매칭사업으로 판단되어 중복 제외.
--  - 청주시 청년월세 지원사업(24회 확대): 국토부 한시 국비사업에 청주시가
--    자체 예산을 더한 것으로, 국비 부분과 시비 확대분을 명확히 분리하기
--    어려워 제외.
--  - 춘천시 신혼부부 전월세 대출이자 지원, 춘천시·원주시 청년월세: 강원도
--    표준사업 또는 국비 한시사업으로 추정되어 제외(조사 에이전트 자체 권고).
--  - 원주시 청년 자격시험 응시료 지원: 단일 출처(비공식 정보 사이트)만
--    확인되어 제외.
--  - 여수시 전입 청년 웰컴박스, 여수형 청년임대주택 확대: 현물 구성/개별
--    임대조건이 불명확해 제외.
--  - 목포시 결혼축하금 200만원: 단일 출처(시 자체 성과페이지)이며 위 세
--    도시 공통 금액과 일치해 도 표준사업 추정으로 제외.
-- 원주시 산모 출산축하 지원은 현금이 아닌 지역 농축산물(현물) 지원임을
-- 요약·체크리스트에 명시했습니다.
-- =============================================================================

insert into regions (slug, name, level, parent_id)
select 'jeonbuk-jeonju', '전주시', 'sigungu', id from regions where slug = 'jeonbuk'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'jeonnam-yeosu', '여수시', 'sigungu', id from regions where slug = 'jeonnam'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'jeonnam-suncheon', '순천시', 'sigungu', id from regions where slug = 'jeonnam'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'jeonnam-mokpo', '목포시', 'sigungu', id from regions where slug = 'jeonnam'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'chungbuk-cheongju', '청주시', 'sigungu', id from regions where slug = 'chungbuk'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'gangwon-chuncheon', '춘천시', 'sigungu', id from regions where slug = 'gangwon'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'gangwon-wonju', '원주시', 'sigungu', id from regions where slug = 'gangwon'
on conflict (slug) do nothing;

-- 전주시 청년부부 결혼비용(스드메) 지원사업 (marriage)
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
  'jeonju-newlywed-wedding-cost-support',
  '전주시 청년부부 결혼비용(스드메) 지원사업',
  '전주시가 혼인신고한 청년부부의 스튜디오·드레스·메이크업(스드메) 비용을 직접 지원하는 제도입니다.',
  r.id, c.id,
  '올해 1월 1일~5월 31일 사이 혼인신고한 부부로, 부부 중 1명 이상 만 18~39세여야 합니다. 신청일 기준 6개월 이상 전주시에 거주하고, 부부합산 소득이 기준중위소득 120% 이하여야 합니다.',
  '스튜디오·드레스·메이크업(스드메) 비용을 최대 100만원까지 지원하며, 연간 30쌍을 선정합니다.',
  '전주시 통합지원신청사이트를 통해 온라인으로 신청하며, 상반기(6월 초)와 하반기(12월) 연 2회 접수합니다.',
  array['혼인관계증명서', '예식 관련 영수증'],
  array['연간 30쌍 한정이니 신청 시기를 놓치지 마세요', '전북도의 결혼비용 대출이자 지원사업과는 별개의 제도입니다'],
  '[]'::jsonb,
  '전주시청', 'https://www.jeonju.go.kr/',
  '기준중위소득 120% 이하', null, null, '신혼부부',
  null, null, false,
  '전라일보 및 전주시 공식 기준 정리', current_date, true,
  'jeonju-newlywed-wedding-cost-support', 2026, true
from regions r, categories c
where r.slug = 'jeonbuk-jeonju' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 전주시 출생축하금 (birth)
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
  'jeonju-birth-celebration-grant',
  '전주시 출생축하금',
  '전주시가 2026년 조례 개정으로 모든 출생아에게 지급하기 시작한 출생축하금입니다.',
  r.id, c.id,
  '2026년 1월 1일 이후 전주시에서 출생신고한 아동 전원이 대상입니다.',
  '출생아 1인당 100만원을 일시금으로 지급합니다(국비 첫만남이용권, 부모급여 등과는 별개입니다).',
  '행정복지센터 또는 정부24를 통해 신청합니다(정확한 신청 방법은 시행 공고에서 확인하세요).',
  array['출생신고 관련 서류', '주민등록등본'],
  array['2025년 12월 조례 개정으로 신설된 제도이니 시행 여부를 공식 공고에서 다시 확인하세요', '국비 지원금과는 별도로 받을 수 있습니다'],
  '[]'::jsonb,
  '전주시청', 'https://www.jeonju.go.kr/',
  null, null, null, null,
  null, null, true,
  '전북도민일보 등 언론 보도 기준 정리', current_date, true,
  'jeonju-birth-celebration-grant', 2026, true
from regions r, categories c
where r.slug = 'jeonbuk-jeonju' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 전주시 청년만원주택 청춘★별채 (housing)
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
  'jeonju-youth-one-won-housing',
  '전주시 청년만원주택 청춘★별채',
  '전주시가 무주택 미혼 청년에게 초저가 임대주택을 공급하는 제도입니다.',
  r.id, c.id,
  '공고일 기준 무주택 미혼 청년(대학생, 졸업 2년 이내 취업준비생 포함)으로 만 19~39세가 대상입니다.',
  '보증금 50만원, 월 임대료 1만~3만원으로 최초 2년 거주할 수 있고, 재계약을 통해 최대 10년까지 거주할 수 있습니다.',
  '전주시 공고에 따라 예비입주자를 모집하며, 방문 또는 온라인으로 신청합니다.',
  array['무주택 확인서류', '주민등록등본'],
  array['모집 시기가 정해져 있으니 공고를 확인하세요', '2026년 하반기 141호까지 공급이 확대됩니다'],
  '[]'::jsonb,
  '전주시청', 'https://www.jeonju.go.kr/',
  null, 19, 39, '1인가구',
  null, null, false,
  '전주시청 보도자료 및 경향신문 기준 정리', current_date, true,
  'jeonju-youth-one-won-housing', 2026, true
from regions r, categories c
where r.slug = 'jeonbuk-jeonju' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 전주시 청년월세 지원사업 (housing)
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
  'jeonju-youth-rent-support',
  '전주시 청년월세 지원사업',
  '전주시의 무주택 청년에게 월세를 지원하는 제도로, 한시사업에서 계속사업으로 전환됐습니다.',
  r.id, c.id,
  '만 19~34세 무주택 청년으로 부모와 별도 거주해야 합니다. 청년가구 기준중위소득 60% 이하(재산 1억 2,200만원 이하) 또는 청년+부모가구 합산 기준중위소득 100% 이하(재산 4억 7,000만원 이하)여야 합니다.',
  '매달 최대 20만원씩 최장 24개월을 지원합니다.',
  '매년 봄(3월 말~5월 말) 접수 기간에 신청합니다.',
  array['임대차계약서', '가족관계증명서', '소득·재산 증빙서류'],
  array['한시사업에서 계속사업으로 전환되어 매년 신규 대상자를 모집합니다'],
  '[]'::jsonb,
  '전주시청', 'https://www.jeonju.go.kr/',
  '청년가구 중위소득 60% 이하 또는 원가구 중위소득 100% 이하', 19, 34, '1인가구',
  null, null, false,
  '뉴스핌 및 전라매일신문 기준 정리', current_date, true,
  'jeonju-youth-rent-support', 2026, true
from regions r, categories c
where r.slug = 'jeonbuk-jeonju' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 여수시 임신축하금 (birth)
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
  'yeosu-pregnancy-celebration-grant',
  '여수시 임신축하금',
  '여수시가 임신부에게 출산 전 임신 중에 지급하는 축하금 제도입니다.',
  r.id, c.id,
  '여수시에 6개월 이상 거주하며 보건소 등에 등록한 임신부가 대상입니다(외국인 임신부 제외).',
  '임신부 1인당 50만원을 연 1회 지급합니다.',
  '여수시 보건소 또는 중부보건지소를 방문해 임신출산 진료비지급 신청서 발급일부터 분만 전까지 신청합니다.',
  array['임신확인서', '주민등록등본'],
  array['출산 후에는 신청할 수 없으니 임신 중에 미리 신청하세요', '이미 출산한 경우 지원 대상에서 제외됩니다'],
  '[]'::jsonb,
  '여수시 보건소', 'https://www.yeosu.go.kr/',
  null, null, null, null,
  null, null, true,
  '여수시 임신·출산지원조례 및 천지일보 기준 정리', current_date, true,
  'yeosu-pregnancy-celebration-grant', 2026, true
from regions r, categories c
where r.slug = 'jeonnam-yeosu' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 순천시 신혼부부 주택전세자금 대출이자 지원사업 (marriage)
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
  'suncheon-newlywed-jeonse-interest-support',
  '순천시 신혼부부 주택전세자금 대출이자 지원사업',
  '순천시의 무주택 신혼부부에게 전세자금 대출이자를 지원하는 제도입니다.',
  r.id, c.id,
  '순천시에 거주하는 만 18~45세 무주택 신혼부부로, 전세보증금 3억원 이하·전용면적 85㎡ 이하 주택에 거주해야 합니다.',
  '매달 최대 10만원씩 최대 4년간 전세자금 대출이자를 지원합니다.',
  '순천시청 청년정책 공고를 통해 신청합니다.',
  array['혼인관계증명서', '전세계약서', '대출 관련 서류'],
  array['최대 4년간 지속 지원받으려면 매년 요건을 유지해야 합니다'],
  '[]'::jsonb,
  '순천시청', 'https://www.suncheon.go.kr/',
  null, 18, 45, '신혼부부',
  null, null, false,
  '아주경제 기준 정리', current_date, true,
  'suncheon-newlywed-jeonse-interest-support', 2026, true
from regions r, categories c
where r.slug = 'jeonnam-suncheon' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 순천시 출산장려금 (birth)
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
  'suncheon-birth-grant',
  '순천시 출산장려금',
  '순천시에서 출산한 가정에 자녀 수에 따라 최대 2,000만원까지 지급하는 출산장려금 제도입니다.',
  r.id, c.id,
  '2023년 1월 1일 이후 순천시에서 출생한 아동으로, 부모 모두 6개월 이상 순천시에 거주해야 합니다.',
  '첫째아 500만원, 둘째아 1,000만원, 셋째아 1,500만원, 넷째아 이상 2,000만원을 지급합니다. 출생신고 시 100만원을 우선 지급하고 나머지는 자녀의 생일월에 맞춰 분할 지급합니다.',
  '관할 행정복지센터를 방문하거나 온라인으로 신청합니다.',
  array['출생신고 관련 서류', '주민등록등본'],
  array['지급액은 출생 시 일부와 생일월 분할로 나뉘어 지급됩니다', '금액이 크고 조례 개정 이력이 있을 수 있으니 최신 기준을 다시 확인하세요'],
  '[]'::jsonb,
  '순천시청', 'https://www.suncheon.go.kr/',
  null, null, null, null,
  null, null, true,
  '순천시청 공식 자료 및 호남닷컴 기준 정리', current_date, true,
  'suncheon-birth-grant', 2026, true
from regions r, categories c
where r.slug = 'jeonnam-suncheon' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 순천시 청년활동 포인트제 (youth)
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
  'suncheon-youth-activity-points',
  '순천시 청년활동 포인트제',
  '순천시 청년의 시정 참여 실적을 지역화폐로 환산해 지급하는 제도입니다.',
  r.id, c.id,
  '순천시에 거주하는 청년으로, 시정 참여 활동에 참여해야 포인트를 받을 수 있습니다.',
  '시정 참여 실적을 모바일 순천사랑상품권으로 환산해 연 최대 40만원까지 지급합니다.',
  '순천시 청년정책 공고를 통해 참여 신청합니다.',
  array['참여 활동 증빙서류'],
  array['단순 신청만으로는 받을 수 없고 실제 시정 참여 활동이 필요합니다'],
  '[]'::jsonb,
  '순천시청', 'https://www.suncheon.go.kr/',
  null, null, null, null,
  null, null, true,
  '아주경제 기준 정리', current_date, true,
  'suncheon-youth-activity-points', 2026, true
from regions r, categories c
where r.slug = 'jeonnam-suncheon' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 순천시 청년 취업자 주거비 지원사업 (housing)
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
  'suncheon-youth-worker-housing-support',
  '순천시 청년 취업자 주거비 지원사업',
  '순천시의 무주택 근로청년에게 월세를 지원하는 제도입니다.',
  r.id, c.id,
  '만 18~45세 무주택 근로청년이 대상입니다.',
  '매달 20만원씩 1년간 월세를 지원합니다.',
  '순천시 청년정책 공고에 따라 매년 접수합니다.',
  array['임대차계약서', '재직 증빙서류'],
  array['근로 중인 청년만 신청할 수 있습니다'],
  '[]'::jsonb,
  '순천시청', 'https://www.suncheon.go.kr/',
  null, 18, 45, '1인가구',
  null, null, false,
  '아주경제 및 순천시청 청년정책 공고 기준 정리', current_date, true,
  'suncheon-youth-worker-housing-support', 2026, true
from regions r, categories c
where r.slug = 'jeonnam-suncheon' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 목포시 신혼부부·다자녀가정 보금자리 지원사업 (marriage)
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
  'mokpo-newlywed-multichild-housing-support',
  '목포시 신혼부부·다자녀가정 보금자리 지원사업',
  '목포시가 2026년 신설한 신혼부부·다자녀가정 주택구입 대출이자 지원 제도입니다.',
  r.id, c.id,
  '혼인신고 7년 이내이며 부부 모두 만 49세 이하로 부부합산 연소득 8,500만원 이하인 신혼부부, 또는 미성년 자녀 2명 이상(그중 1명은 만 12세 이하)이며 합산 연소득 1억원 이하인 다자녀가정이 대상입니다.',
  '주택구입 대출이자를 매달 최대 25만원씩 36개월간 지원하며, 38가구를 선정합니다.',
  '9월 1일부터 10월 16일까지 주소지 관할 동 행정복지센터를 방문해 신청합니다.',
  array['혼인관계증명서 또는 가족관계증명서', '주택 매매계약서', '대출 관련 서류'],
  array['2026년 신규 사업으로 38가구 한정이니 신청 기한을 놓치지 마세요', '신혼부부와 다자녀가정 중 하나의 요건만 충족하면 됩니다'],
  '[]'::jsonb,
  '목포시청 청년인구과', 'https://www.mokpo.go.kr/',
  '신혼부부 합산 연소득 8,500만원 이하 / 다자녀가정 합산 연소득 1억원 이하', null, 49, '신혼부부',
  null, null, false,
  '국제뉴스 및 매일일보 기준 정리', current_date, true,
  'mokpo-newlywed-multichild-housing-support', 2026, true
from regions r, categories c
where r.slug = 'jeonnam-mokpo' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 목포시 청년 자립지원(자산형성) 사업 (youth)
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
  'mokpo-youth-asset-building-account',
  '목포시 청년 자립지원(자산형성) 사업',
  '목포시 청년의 저축액에 목포시가 동일 금액을 매칭 적립해주는 자산형성 지원 제도입니다.',
  r.id, c.id,
  '목포시에 거주하는 청년이 대상입니다. 정확한 연령·소득 기준은 목포시 청년정책 공고에서 확인할 수 있습니다.',
  '매달 10만원씩 3년간 저축하면 목포시가 동일한 금액을 매칭 적립합니다. 만기 시 원금의 2배와 이자를 받을 수 있습니다.',
  '목포시 청년정책 공고를 통해 신청합니다.',
  array['소득 증빙서류', '주민등록등본'],
  array['3년간 꾸준히 저축을 유지해야 매칭 금액을 받을 수 있습니다'],
  '[]'::jsonb,
  '목포시청', 'https://www.mokpo.go.kr/',
  null, null, null, null,
  null, null, false,
  '아이뉴스24 기준 정리', current_date, true,
  'mokpo-youth-asset-building-account', 2026, true
from regions r, categories c
where r.slug = 'jeonnam-mokpo' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 목포시 청년 취업자 주거비 지원사업 (housing)
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
  'mokpo-youth-worker-housing-support',
  '목포시 청년 취업자 주거비 지원사업',
  '목포시의 무주택 청년 근로자·사업자에게 전월세 주거비를 지원하는 제도입니다.',
  r.id, c.id,
  '만 18~45세 무주택 청년 근로자 또는 사업자로, 소득인정액이 기준중위소득 150% 이하여야 합니다. 전세대출 5,000만원 이상 또는 월세 60만원 이하 주택에 거주해야 합니다.',
  '매달 최대 20만원씩 최대 12개월을 분기별로 지원하며, 올해 지원 규모는 20명입니다.',
  '목포시청 청년인구과 공고를 통해 신청합니다.',
  array['임대차계약서', '재직 또는 사업자 증빙서류', '소득 증빙서류'],
  array['지원 인원이 20명으로 제한되어 있습니다', '분기별로 나누어 지급됩니다'],
  '[]'::jsonb,
  '목포시청 청년인구과', 'https://www.mokpo.go.kr/',
  '기준중위소득 150% 이하', 18, 45, '1인가구',
  null, null, false,
  '네이트뉴스 기준 정리', current_date, true,
  'mokpo-youth-worker-housing-support', 2026, true
from regions r, categories c
where r.slug = 'jeonnam-mokpo' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 청주시 결혼비용 대출이자 지원사업 (marriage)
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
  'cheongju-marriage-cost-loan-interest-support',
  '청주시 결혼비용 대출이자 지원사업',
  '청주시에 거주하는 신혼부부의 결혼비용 관련 대출이자를 지원하는 제도입니다.',
  r.id, c.id,
  '청주시에 거주하는 만 19~39세로 혼인 1년 이내이며, 부부합산 소득이 기준중위소득 180% 이하(3인가구 기준 월 904만 5,000원)여야 합니다.',
  '결혼비용 관련 대출이자를 연 최대 50만원씩 2년간(최대 100만원) 지원합니다.',
  '청주시청 누리집에서 본인인증 후 서류를 준비해 여성가족과에 우편 또는 방문 제출합니다.',
  array['혼인관계증명서', '대출 관련 서류', '소득 증빙서류'],
  array['충청북도의 결혼비용 대출이자 지원사업과 명칭이 비슷하니 중복 여부를 문의해 확인하세요'],
  '[]'::jsonb,
  '청주시청 여성가족과', 'https://www.cheongju.go.kr/',
  '기준중위소득 180% 이하 (3인가구 월 904만 5,000원)', 19, 39, '신혼부부',
  null, null, false,
  '중도일보 및 서울Pn 기준 정리', current_date, true,
  'cheongju-marriage-cost-loan-interest-support', 2026, true
from regions r, categories c
where r.slug = 'chungbuk-cheongju' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 청주시 출산가정 대출이자 지원사업 (birth)
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
  'cheongju-birth-household-loan-interest-support',
  '청주시 출산가정 대출이자 지원사업',
  '청주시가 출산가정의 대출이자를 지원하는 제도입니다.',
  r.id, c.id,
  '자녀 출생일로부터 1년 이내인 가정이 대상입니다.',
  '출산 관련 대출이자를 3년간 최대 150만원까지 지원합니다.',
  '청주시청 여성가족과에 서류를 제출해 신청합니다.',
  array['출생신고 관련 서류', '대출 관련 서류'],
  array['출생일로부터 1년 이내에 신청해야 합니다'],
  '[]'::jsonb,
  '청주시청 여성가족과', 'https://www.cheongju.go.kr/',
  null, null, null, null,
  null, null, false,
  '중도일보 및 서울Pn 기준 정리', current_date, true,
  'cheongju-birth-household-loan-interest-support', 2026, true
from regions r, categories c
where r.slug = 'chungbuk-cheongju' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 청주시 신혼부부 주택자금 대출이자 지원사업 (housing)
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
  'cheongju-newlywed-housing-loan-interest-support',
  '청주시 신혼부부 주택자금 대출이자 지원사업',
  '청주시의 신혼부부에게 전세·매입 주택자금 대출이자를 지원하는 제도입니다.',
  r.id, c.id,
  '신청일 기준 혼인 7년 이내이며 부부 모두 2024년 7월 1일 이전부터 청주시에 거주해야 합니다. 2024년 귀속 부부합산소득이 무자녀 8,000만원, 1자녀 8,800만원, 2자녀 이상 9,800만원 이하여야 하며, 전세보증금 2억 2,000만원 이하 또는 매입가 2억 8,000만원 이하·전용면적 85㎡ 이하 주택이 대상입니다.',
  '대출 잔액의 1.2%를 가구당 연 최대 100만원(자녀가 있으면 110만원)까지 지원합니다.',
  '청주시청 공고 기간(2025년 기준 7월 7일~8월 8일)에 신청합니다.',
  array['혼인관계증명서', '주택 매매·임대차계약서', '대출 관련 서류'],
  array['자녀 유무에 따라 소득 기준과 지원 한도가 다릅니다', '매년 접수 기간이 정해져 있으니 공고를 확인하세요'],
  '[]'::jsonb,
  '청주시청', 'https://www.cheongju.go.kr/',
  '부부합산소득 무자녀 8,000만원 / 1자녀 8,800만원 / 2자녀 이상 9,800만원 이하', null, null, '신혼부부',
  null, null, false,
  '뉴시스 및 더퍼블릭 기준 정리', current_date, true,
  'cheongju-newlywed-housing-loan-interest-support', 2026, true
from regions r, categories c
where r.slug = 'chungbuk-cheongju' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 춘천시 출생축하금 (birth)
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
  'chuncheon-birth-celebration-grant',
  '춘천시 출생축하금',
  '중단됐던 출산장려금을 이름을 바꿔 재개한 춘천시의 출생축하금 제도입니다.',
  r.id, c.id,
  '생후 12개월 이내 영아로, 출생일(또는 입양신고일) 기준 6개월 전부터 계속 춘천시에 거주해야 합니다.',
  '첫째아 50만원, 둘째아 70만원, 셋째아 이상 100만원을 지급합니다.',
  '생후 12개월 이내에 읍면동 행정복지센터를 방문해 신청합니다.',
  array['출생신고 관련 서류', '주민등록등본'],
  array['생후 12개월이 지나면 신청할 수 없습니다', '아이돌봄서비스 본인부담금 50~100% 추가 지원도 함께 확인하세요'],
  '[]'::jsonb,
  '춘천시청', 'https://www.chuncheon.go.kr/',
  null, null, null, null,
  null, null, true,
  '춘천시 복지포털 및 언론 보도 기준 정리', current_date, true,
  'chuncheon-birth-celebration-grant', 2026, true
from regions r, categories c
where r.slug = 'gangwon-chuncheon' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 원주시 산모 출산축하 지역 농축산물 지원 (birth)
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
  'wonju-birth-local-produce-support',
  '원주시 산모 출산축하 지역 농축산물 지원',
  '원주시에서 출산한 가정에 현금이 아닌 원주쌀, 한우 등 지역 농축산물을 지원하는 제도입니다.',
  r.id, c.id,
  '원주시에 주민등록을 두고 실거주하며 원주시에 출생신고한 가정이 대상입니다(국외 출생신고 및 출생 1개월 초과 신고는 제외).',
  '원주쌀(토토미), 치악산 한우, 들기름, 미역 등 15만원 상당의 지역 농축산물·가공품을 현물로 지원합니다(현금 지원이 아닙니다).',
  '출생신고 시 관할 행정복지센터를 통해 함께 신청합니다.',
  array['출생신고 관련 서류', '주민등록등본'],
  array['현금이 아닌 지역 농축산물 현물로 지급됩니다', '연간 예산이 정해져 있어 소진 시 조기 종료될 수 있습니다'],
  '[]'::jsonb,
  '원주시청', 'https://www.wonju.go.kr/',
  null, null, null, null,
  null, null, true,
  '원주시 복지포털 기준 정리', current_date, true,
  'wonju-birth-local-produce-support', 2026, true
from regions r, categories c
where r.slug = 'gangwon-wonju' and c.slug = 'birth'
on conflict (slug) do nothing;
