-- =============================================================================
-- 전국 확대 8차 배치 (2026년 기준): 청년·주거 카테고리 공백 보완
-- 강원·제주·충남·전북·전남·경북·경남(청년), 세종·제주(주거)
--
-- 확인 불가로 제외한 항목:
--   - 충북 청년: 도 전역 단위의 청년수당/자립수당류 현금 지원 사업을 확인하지
--     못했습니다. 청주시 청년도전지원사업 등 시 단위 개별 사업만 존재합니다.
-- =============================================================================

-- 강원 청년 취업준비 쿠폰 지원사업 (youth)
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
  'gangwon-youth-job-prep-coupon',
  '강원 청년 취업준비 쿠폰 지원사업',
  '강원특별자치도의 미취업 청년에게 취업 준비 경비를 쿠폰으로 지원하는 제도입니다.',
  r.id, c.id,
  '강원특별자치도에 주민등록을 두고 있는 만 18~45세 청년으로, 최종학력 졸업(중퇴)자이며 미취업 상태(주 36시간 미만 근로, 사업자등록 없음)여야 합니다. 가구소득인정액이 만 18~34세는 기준중위소득 120% 초과~180% 이하, 만 35~45세는 180% 이하여야 하며, 최근 2년 이내 참여 이력이 있으면 재참여가 제한됩니다.',
  '매달 50만원씩 최대 6개월(최대 300만원)을 취업준비 경비 쿠폰으로 지원합니다.',
  '강원일자리정보망(job.gwd.go.kr)에서 온라인으로 신청합니다.',
  array['최종학력 졸업증명서', '소득 증빙서류', '주민등록등본'],
  array['최근 2년 내 참여 이력이 있으면 재신청이 제한될 수 있습니다', '연령 구간별로 소득 기준이 다르니 본인 구간을 확인하세요'],
  '[]'::jsonb,
  '강원특별자치도청 일자리경제국', 'https://state.gwd.go.kr/',
  '만 18~34세 중위소득 120% 초과~180% 이하 / 만 35~45세 180% 이하', 18, 45, null,
  null, null, false,
  '강원특별자치도 공고 및 강원일자리정보망 기준 정리', current_date, true,
  'gangwon-youth-job-prep-coupon', 2026, true
from regions r, categories c
where r.slug = 'gangwon' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 제주 청년 희망사다리 재형저축 (youth)
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
  'jeju-youth-hope-ladder-savings',
  '제주 청년 희망사다리 재형저축',
  '제주도 내 중소기업에 재직하는 청년의 장기근속과 자산형성을 돕는 매칭적금 제도입니다.',
  r.id, c.id,
  '제주특별자치도 내 중소기업에 재직 중인 만 15~39세 청년이 대상입니다. 참여기업을 통해 신청해야 합니다.',
  '5년간 매달 청년 본인 10만원, 참여기업 15만원, 제주특별자치도 25만원을 함께 적립해 매달 총 50만원씩 쌓입니다. 만기 시 청년은 원금 3,000만원과 이자를 수령합니다.',
  '재직 중인 참여기업을 통해 신청하며, 공고는 제주테크노파크·제주은행연합 등을 통해 매년 안내됩니다.',
  array['재직증명서', '근로계약서'],
  array['제주도 내 중소기업 재직자만 신청할 수 있습니다', '5년이라는 장기 근속을 유지해야 만기 혜택을 받을 수 있습니다', '참여기업이 사업에 가입되어 있어야 신청 가능합니다'],
  '[]'::jsonb,
  '제주특별자치도 일자리경제과', 'https://www.jeju.go.kr/',
  null, 15, 39, null,
  null, null, true,
  '제주특별자치도 공고 및 언론 보도 기준 정리', current_date, true,
  'jeju-youth-hope-ladder-savings', 2026, true
from regions r, categories c
where r.slug = 'jeju' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 충남 청년 정착플러스 통장 (youth)
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
  'chungnam-youth-settlement-plus-account',
  '충남 청년 정착플러스 통장',
  '충남 주력산업 분야 중소·중견기업에 재직하는 청년의 자산형성을 돕는 매칭적금 제도입니다.',
  r.id, c.id,
  '충청남도에 거주하며 반도체·자동차·디스플레이 등 도내 주력산업 관련 중소·중견기업에 25~60개월간 재직 중인 만 19~39세(군필자는 최대 42세) 청년이 대상입니다. 가구소득은 기준중위소득 180% 이하(1인가구 월 461.6만원 이하)여야 합니다.',
  '24개월간 매달 본인 10만원, 충청남도 10만원을 함께 적립합니다. 만기 시 본인 적립금 240만원, 도 지원금 240만원에 만기축하금 20만원을 더해 총 500만원과 이자를 받을 수 있습니다.',
  '충남경제진흥원(cepa.or.kr) 또는 충남청년포털(youth.chungnam.go.kr)을 통해 신청합니다.',
  array['재직증명서', '소득 증빙서류', '주민등록등본'],
  array['반도체·자동차·디스플레이 등 지정 주력산업 재직자만 신청할 수 있습니다', '군필자는 최대 만 42세까지 신청 가능합니다', '24개월 재직을 유지해야 만기 혜택을 받을 수 있습니다'],
  '[]'::jsonb,
  '충청남도 청년정책과', 'https://youth.chungnam.go.kr/',
  '기준중위소득 180% 이하 (1인가구 월 461.6만원 이하)', 19, 39, null,
  null, null, true,
  '충청남도 공고 및 언론 보도 기준 정리', current_date, true,
  'chungnam-youth-settlement-plus-account', 2026, true
from regions r, categories c
where r.slug = 'chungnam' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 전북형 청년활력수당 (youth)
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
  'jeonbuk-youth-vitality-allowance',
  '전북형 청년활력수당',
  '전북 도내 미취업 청년에게 구직 활동비를 지원하고 구직역량강화교육을 제공하는 제도입니다.',
  r.id, c.id,
  '전북특별자치도에 거주하는 만 18~39세 미취업·미창업 청년으로, 최종학력이 졸업·중퇴·수료 상태여야 합니다. 가구소득인정액이 기준중위소득 150% 이하여야 합니다.',
  '매달 50만원씩 최대 6개월(최대 300만원)을 포인트로 지급하며, 구직역량강화교육도 함께 제공합니다. 지원 기간 중 취업·창업에 성공하면 별도의 성공보상금도 받을 수 있습니다.',
  '전북형 청년수당 전용 사이트(jbyouth.ezwel.com)에서 신청하며, 연중 여러 차수로 나누어 모집합니다.',
  array['최종학력 졸업(중퇴·수료)증명서', '소득 증빙서류'],
  array['모집 차수별 신청 기간을 놓치지 않도록 확인하세요', '재학 중이라면 신청할 수 없습니다'],
  '[]'::jsonb,
  '전북특별자치도 청년정책과', 'https://www.jeonbuk.go.kr/',
  '기준중위소득 150% 이하', 18, 39, null,
  null, null, false,
  '전북특별자치도 공고 및 언론 보도 기준 정리', current_date, true,
  'jeonbuk-youth-vitality-allowance', 2026, true
from regions r, categories c
where r.slug = 'jeonbuk' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 전남 청년 문화복지카드 (youth)
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
  'jeonnam-youth-culture-welfare-card',
  '전남 청년 문화복지카드',
  '전라남도에 거주하는 청년의 문화 활동을 지원하기 위해 매년 포인트를 지급하는 제도입니다.',
  r.id, c.id,
  '전라남도에 2년 이상 거주한 만 17~26세 청년이 대상입니다.',
  '연 25만원을 문화복지카드 포인트로 지급하며, 공연·전시 관람, 도서 구입, 학원 수강 등 문화 관련 활동에 사용할 수 있습니다.',
  '전라남도 청년정책 플랫폼 또는 거주지 관할 읍·면·동 행정복지센터를 통해 신청합니다.',
  array['주민등록등본'],
  array['전라남도 2년 이상 거주 요건을 충족하는지 확인하세요', '사용 가능한 가맹점·용도가 정해져 있으니 미리 확인하세요'],
  '[]'::jsonb,
  '전라남도 청년정책과', 'https://www.jeonnam.go.kr/',
  null, 17, 26, null,
  null, null, true,
  '전라남도 공고 및 언론 보도 기준 정리', current_date, true,
  'jeonnam-youth-culture-welfare-card', 2026, true
from regions r, categories c
where r.slug = 'jeonnam' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 경북 청년愛꿈수당 (youth)
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
  'gyeongbuk-youth-love-dream-allowance',
  '경북 청년愛꿈수당',
  '경북 도내 중소·중견기업에 면접·취업·재직하는 청년에게 단계별로 현금을 지급하는 제도입니다.',
  r.id, c.id,
  '만 19~40세 청년으로, 경상북도 내 중소·중견기업에 면접을 보거나 취업·재직 중이어야 합니다. 근속장려수당은 1년 이상 재직하며 경상북도 내 주민등록을 유지해야 지급됩니다.',
  '면접수당은 1회 7만원씩 최대 5회(최대 35만원), 취업성공 시 축하금 50만원(1회), 재직 중에는 분기별 30만원씩 최대 4회(최대 120만원)의 근속장려수당을 지급합니다. 세 가지를 모두 받으면 최대 205만원입니다.',
  '청년愛꿈수당 홈페이지 또는 경북일자리종합센터를 통해 신청하며, 예산 소진 시 조기 마감될 수 있습니다.',
  array['면접확인서 또는 재직증명서', '주민등록등본'],
  array['예산 소진 시 조기 마감되니 서둘러 신청하세요', '근속장려수당은 1년 이상 재직해야 받을 수 있습니다'],
  '[]'::jsonb,
  '경상북도 일자리경제실', 'https://www.gb.go.kr/',
  null, 19, 40, null,
  null, null, false,
  '경상북도 공고 및 언론 보도 기준 정리', current_date, true,
  'gyeongbuk-youth-love-dream-allowance', 2026, true
from regions r, categories c
where r.slug = 'gyeongbuk' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 경남 모다드림 청년통장 (youth)
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
  'gyeongnam-moda-dream-youth-account',
  '경남 모다드림 청년통장',
  '경남에 거주하며 재직 중인 청년의 자산형성을 돕는 매칭적금 제도입니다.',
  r.id, c.id,
  '경상남도에 거주하며 도내에서 재직 중인 만 18~39세 청년으로, 건강보험과 고용보험에 동시 가입되어 있어야 합니다. 가구 기준중위소득이 50% 초과~130% 이하여야 합니다.',
  '24개월간 매달 청년 본인 20만원, 경상남도·시군이 20만원을 함께 적립합니다. 만기 시 원금 960만원과 이자를 받을 수 있습니다.',
  '모다드림 청년통장 누리집(modadream.kr) 또는 경상남도 청년정보플랫폼(youth.gyeongnam.go.kr)을 통해 신청합니다.',
  array['재직증명서', '건강보험·고용보험 가입확인서', '소득 증빙서류'],
  array['건강보험과 고용보험에 모두 가입되어 있어야 신청할 수 있습니다', '24개월간 꾸준히 납입해야 만기 혜택을 받을 수 있습니다'],
  '[]'::jsonb,
  '경상남도 청년정책과', 'https://youth.gyeongnam.go.kr/',
  '기준중위소득 50% 초과~130% 이하', 18, 39, null,
  null, null, true,
  '경상남도 공고 및 복지로 기준 정리', current_date, true,
  'gyeongnam-moda-dream-youth-account', 2026, true
from regions r, categories c
where r.slug = 'gyeongnam' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 세종시 청년 주거임대료 지원사업 (housing)
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
  'sejong-youth-rent-subsidy',
  '세종시 청년 주거임대료 지원사업',
  '세종시에 거주하는 무주택 1인가구 청년에게 월세를 직접 지원하는 제도입니다.',
  r.id, c.id,
  '세종시에 거주하는 무주택 1인가구 청년(만 19~39세)으로, 전용면적 85㎡ 이하·보증금 1억원 이하·월세 60만원 이하 주택에 거주해야 합니다. 소득은 기준중위소득 150% 이하(1인가구 월 484만원 이하), 재산은 1억 2,200만원 이하여야 합니다.',
  '매달 최대 20만원을 월세로 직접 지원합니다. (2025년 사업 기준 최대 10개월간 지원되며, 정확한 지원 기간은 매년 공고에 따라 달라질 수 있습니다.)',
  '세종시 청년정책 홈페이지 또는 세종청년센터(4242.or.kr)를 통해 온라인으로 신청합니다.',
  array['임대차계약서', '소득·재산 증빙서류', '주민등록등본'],
  array['세종 청년·신혼부부 주택임차보증금 이자지원과는 별개의 사업입니다(중복 신청 가능 여부는 공고에서 확인하세요)', '정확한 지원 개월 수는 매년 공고를 확인하세요'],
  '[]'::jsonb,
  '세종시 청년정책과', 'https://www.4242.or.kr/',
  '기준중위소득 150% 이하 (1인가구 월 484만원 이하)', 19, 39, '1인가구',
  null, null, false,
  '세종시 공고 및 언론 보도 기준 정리', current_date, true,
  'sejong-youth-rent-subsidy', 2026, true
from regions r, categories c
where r.slug = 'sejong' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 제주 청년 희망충전 월세 지원사업 (housing)
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
  'jeju-youth-hope-charge-rent-support',
  '제주 청년 희망충전 월세 지원사업',
  '제주도에 거주하는 무주택 청년에게 월세를 지원하는 제도로, 국가 지원분에 제주도가 지원 기간을 추가로 더해줍니다.',
  r.id, c.id,
  '제주특별자치도에 주소를 둔 만 35~39세 무주택 청년으로, 부모와 별도로 거주해야 합니다. 기준중위소득 60% 이하, 총재산가액 1억 2,200만원 이하여야 합니다.',
  '실제 월세 범위 내에서 매달 최대 20만원을 지원합니다. 국가 지원 기간(최장 2년)에 제주도가 자체적으로 최장 1년을 더해, 합산 최장 3년까지 지원받을 수 있습니다.',
  '복지로(bokjiro.go.kr) 온라인 신청 또는 거주지 관할 읍·면·동 주민센터를 통해 신청합니다.',
  array['임대차계약서', '가족관계증명서', '소득·재산 증빙서류'],
  array['2026년부터 지원 연령 상한이 만 39세로 확대되었습니다', '제주 신혼·출산가구 주택전세대출 이자지원과는 별개의 사업입니다'],
  '[]'::jsonb,
  '제주특별자치도 주거복지센터', 'https://www.jejuhwc.co.kr/',
  '기준중위소득 60% 이하', 35, 39, null,
  null, null, true,
  '제주특별자치도 주거복지센터 및 언론 보도 기준 정리', current_date, true,
  'jeju-youth-hope-charge-rent-support', 2026, true
from regions r, categories c
where r.slug = 'jeju' and c.slug = 'housing'
on conflict (slug) do nothing;
