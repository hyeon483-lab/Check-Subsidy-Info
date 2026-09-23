-- =============================================================================
-- "어르신" 카테고리 콘텐츠 1차 배치: 국가 단위(전국 공통) 지원제도 7건
--
-- 이 파일을 실행하려면 먼저 seed_senior_category.sql(어르신 카테고리 신설)을
-- 실행해야 합니다. 또한 지역별 프로그램이 아닌 전국 공통 제도를 위해 새로운
-- 가상 지역 "전국"(slug: nationwide)을 추가합니다. 이 지역은 어느 시·도를
-- 선택해도 함께 노출되도록 lib/data.ts의 matchingRegionIds에서 항상
-- 포함시키게 되어 있습니다.
--
-- 모든 금액은 2026년 기준으로 조사한 실제 수치이며(기초연금 등 물가연동
-- 항목은 2025년 대비 인상분까지 확인), 지자체별로 소득 기준 등이 다르게
-- 운영될 수 있는 항목(치매검진 지원 등)은 그 사실을 본문에 명시했습니다.
-- KTX 등 철도 할인율처럼 출처 간 수치가 엇갈린 항목은 구체적인 퍼센트를
-- 단정하지 않고 공식 홈페이지 확인을 안내하는 방식으로 처리했습니다.
-- =============================================================================

insert into regions (slug, name, level, parent_id)
values ('nationwide', '전국', 'sido', null)
on conflict (slug) do nothing;

-- 기초연금
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
  'basic-pension-senior',
  '기초연금',
  '소득인정액이 일정 기준 이하인 만 65세 이상 어르신에게 매달 현금을 지급하는 국가 기초 생활 지원 제도입니다.',
  r.id, c.id,
  '만 65세 이상 대한민국 국적자로 국내에 거주하며, 가구의 월 소득인정액이 선정기준액 이하여야 합니다. 2026년 선정기준액은 단독가구 월 247만원 이하, 부부가구 월 395만 2,000원 이하입니다.',
  '기준연금액 기준 월 최대 34만 9,700원을 지급합니다(2025년 34만 2,510원 대비 인상). 실제 지급액은 개인 소득·재산 수준과 부부 동시 수급 여부에 따라 달라집니다.',
  '읍·면·동 행정복지센터나 국민연금공단 지사를 방문하거나, 복지로(bokjiro.go.kr) 온라인으로 신청합니다. 만 65세 생일이 속한 달의 전달 1일부터 신청할 수 있습니다.',
  array['신분증', '소득·재산 신고서', '통장 사본'],
  array['배우자가 있는 경우 배우자 금융정보 제공동의서 등 추가 서류가 필요할 수 있습니다', '부부가 함께 수급하면 감액이 적용될 수 있습니다'],
  '[]'::jsonb,
  '보건복지부·국민연금공단', 'https://www.bokjiro.go.kr/',
  '단독가구 월 247만원 이하 / 부부가구 월 395만 2,000원 이하 (2026년 선정기준액)', 65, null, null,
  null, null, true,
  '보건복지부 보도자료 및 언론 보도 기준 정리', current_date, true,
  'basic-pension-senior', 2026, true
from regions r, categories c
where r.slug = 'nationwide' and c.slug = 'senior'
on conflict (slug) do nothing;

-- 노인일자리 및 사회활동 지원사업
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
  'senior-job-social-activity-support',
  '노인일자리 및 사회활동 지원사업',
  '어르신에게 공익활동·사회서비스 등 다양한 유형의 일자리를 연결해 활동비를 지원하는 국가 사업입니다.',
  r.id, c.id,
  '공익활동형은 만 65세 이상 기초연금 수급자가 대상이며(지역에 따라 만 60~64세 차상위계층도 예외적으로 참여 가능), 사회서비스형·시장형은 대체로 만 60세 이상부터 신청할 수 있습니다.',
  '공익활동형은 월 30시간(주 2~3회) 활동 시 월 약 29만~30만원의 활동비를 지급합니다. 사회서비스형은 월 60시간 근무 기준 주휴수당 포함 약 78만원 내외를 받을 수 있고, 시장형·노인역량활용형은 기본 활동비에 사업 실적에 따른 추가 배분금이 더해집니다. 2026년에는 역대 최대인 115만 2,000개 일자리가 제공됩니다.',
  '거주지 주민센터(행정복지센터)나 시니어클럽·노인복지관·대한노인회 등 수행기관을 방문하거나, 노인일자리여기(seniorro.or.kr) 또는 복지로 온라인으로 신청합니다. 2026년 모집은 지역별로 다르며 통상 전년 11~12월에 진행됩니다.',
  array['신분증', '기초연금 수급 확인서류'],
  array['공익활동형 활동비는 기타소득으로 분류돼 기초연금 소득인정액에 거의 영향을 주지 않습니다', '유형(공익활동형/사회서비스형/시장형)에 따라 지원액과 근무 조건이 크게 다르니 공고에서 확인하세요'],
  '[]'::jsonb,
  '보건복지부·한국노인인력개발원', 'https://www.seniorro.or.kr/',
  null, 60, null, null,
  null, null, false,
  '정책브리핑 및 보건복지부 공고 기준 정리', current_date, true,
  'senior-job-social-activity-support', 2026, true
from regions r, categories c
where r.slug = 'nationwide' and c.slug = 'senior'
on conflict (slug) do nothing;

-- 노인장기요양보험
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
  'long-term-care-insurance-senior',
  '노인장기요양보험',
  '거동이 불편한 어르신의 재가·시설 돌봄 비용을 국민건강보험공단이 지원하는 사회보험 제도입니다.',
  r.id, c.id,
  '만 65세 이상이거나, 65세 미만이어도 치매·뇌혈관성 질환 등 노인성 질병이 있는 경우 신청할 수 있습니다. 등급판정위원회가 신체·인지·행동·간호·재활 상태를 종합 평가해 1~5등급 및 인지지원등급을 부여합니다.',
  '2026년 재가급여 월 한도액은 1등급 251만 2,900원, 2등급 233만 1,200원, 3등급 152만 8,200원, 4등급 140만 9,700원, 5등급 120만 8,900원, 인지지원등급 67만 6,320원입니다. 본인부담률은 재가급여 15%, 시설급여 20%이며, 의료급여수급자·저소득층은 경감됩니다.',
  '국민건강보험공단 지사를 방문하거나 장기요양보험 홈페이지(longtermcare.or.kr)에서 온라인으로 신청합니다. 콜센터(1577-1000)로도 문의할 수 있습니다.',
  array['신분증', '의사소견서(등급판정 시 필요)'],
  array['등급판정위원회의 등급 판정을 받아야 급여를 이용할 수 있습니다', '재가급여와 시설급여의 본인부담률이 다릅니다'],
  '[]'::jsonb,
  '국민건강보험공단(장기요양보험)', 'https://www.longtermcare.or.kr/',
  null, 65, null, null,
  null, null, true,
  '국민건강보험공단 및 보건복지부 기준 정리', current_date, true,
  'long-term-care-insurance-senior', 2026, true
from regions r, categories c
where r.slug = 'nationwide' and c.slug = 'senior'
on conflict (slug) do nothing;

-- 경로우대제도
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
  'senior-discount-program',
  '경로우대제도',
  '만 65세 이상 어르신에게 도시철도 무료 이용과 각종 공공시설 할인을 제공하는 법정 우대 제도입니다.',
  r.id, c.id,
  '만 65세 이상으로 신분증(주민등록증·운전면허증·여권 등)을 제시하면 별도 소득 기준 없이 적용됩니다.',
  '도시철도(지하철)는 전국 공통으로 전액 무료입니다. 고궁·능원·박물관·공원 등 공공시설은 시설별로 무료 또는 할인되며, 기초연금 수급자 등 일부는 이동통신요금 감면도 받을 수 있습니다. 코레일 일반열차 할인율은 노선·상품별로 다르니 코레일 공식 홈페이지에서 확인하는 것이 정확합니다.',
  '별도 신청 없이 신분증만 제시하면 즉시 적용됩니다. 우대용 교통카드가 필요한 경우 관할 구청이나 교통공사에서 발급받을 수 있습니다.',
  array['신분증'],
  array['도시철도 무료 이용은 전국 공통이지만 운영은 지자체별 교통공사가 담당합니다', '공공시설별 할인 폭이 다르니 방문 전 확인하세요'],
  '[]'::jsonb,
  '보건복지부(노인복지법 제26조)', 'https://www.easylaw.go.kr/',
  null, 65, null, null,
  null, null, true,
  '노인복지법 및 국가기록원 자료 기준 정리', current_date, true,
  'senior-discount-program', 2026, true
from regions r, categories c
where r.slug = 'nationwide' and c.slug = 'senior'
on conflict (slug) do nothing;

-- 노인 틀니·임플란트 건강보험 지원
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
  'senior-denture-implant-insurance-support',
  '노인 틀니·임플란트 건강보험 지원',
  '만 65세 이상 건강보험 가입자의 틀니·임플란트 치료비 본인부담을 낮춰주는 건강보험 급여 제도입니다.',
  r.id, c.id,
  '만 65세 이상 건강보험 가입자 또는 피부양자가 대상입니다. 임플란트는 자연치아가 1개 이상 남아있는 부분 무치악 환자만 해당하며, 완전 무치악은 틀니 대상으로 분류됩니다. 임플란트는 1인당 평생 2개, 틀니는 1인당 1개(상악 또는 하악)를 7년 주기로 지원받을 수 있습니다.',
  '일반 건강보험 가입자는 총 진료비의 30%만 본인이 부담합니다(임플란트 1개 기준 본인부담 약 38만~40만원 내외). 차상위·의료급여 2종은 20%, 의료급여 1종은 10%로 부담이 경감됩니다.',
  '건강보험이 적용되는 치과 의료기관에서 진료를 받으면 자동으로 적용되며, 별도 신청 절차는 없습니다.',
  array['건강보험증 또는 신분증'],
  array['임플란트는 평생 2개, 틀니는 7년 주기로 1개까지만 지원됩니다', '완전 무치악은 임플란트가 아닌 틀니 대상입니다'],
  '[]'::jsonb,
  '국민건강보험공단', 'https://www.nhis.or.kr/',
  '일반 30% / 차상위·의료급여 2종 20% / 의료급여 1종 10% 본인부담', 65, null, null,
  null, null, true,
  '국민건강보험공단 급여 안내 기준 정리', current_date, true,
  'senior-denture-implant-insurance-support', 2026, true
from regions r, categories c
where r.slug = 'nationwide' and c.slug = 'senior'
on conflict (slug) do nothing;

-- 노인맞춤돌봄서비스
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
  'customized-care-service-for-elderly',
  '노인맞춤돌봄서비스',
  '독거·저소득 등 돌봄이 필요한 어르신에게 안부 확인, 가사 지원, 병원 동행 등을 무료로 제공하는 서비스입니다.',
  r.id, c.id,
  '만 65세 이상 중 국민기초생활수급자, 차상위계층, 또는 기초연금 수급자로서 저소득·독거·취약 어르신이 대상입니다. 본인뿐 아니라 가족·이웃·공무원도 대신 신청할 수 있습니다.',
  '정기 안부확인, 안전점검, 가사지원, 병원 동행, 문화·여가활동, 영양·건강관리 교육을 본인부담금 없이 전액 무료로 제공합니다. 2026년부터는 AI 센서·스마트워치를 활용한 디지털 돌봄과 퇴원 후 집중케어도 강화됩니다.',
  '주소지 관할 읍·면·동 주민센터에 신청서를 제출하면 수행기관 전담사회복지사가 방문 상담을 진행합니다. 접수일로부터 공휴일 제외 30일 이내(최대 30일 연장 가능)에 자격 결정 결과를 서면으로 통보받습니다.',
  array['신분증'],
  array['가족이 대신 신청하는 경우 관계를 확인할 수 있는 서류가 추가로 필요할 수 있습니다', '위기가구는 신청 절차가 간소화되어 더 빠르게 지원받을 수 있습니다'],
  '[]'::jsonb,
  '보건복지부·독거노인종합지원센터', 'https://www.1661-2129.or.kr/',
  null, 65, null, null,
  null, null, true,
  '보건복지부 사업안내 기준 정리', current_date, true,
  'customized-care-service-for-elderly', 2026, true
from regions r, categories c
where r.slug = 'nationwide' and c.slug = 'senior'
on conflict (slug) do nothing;

-- 치매검진 및 치매치료관리비 지원사업
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
  'dementia-screening-treatment-cost-support',
  '치매검진 및 치매치료관리비 지원사업',
  '치매안심센터를 통해 어르신의 치매 검진 비용과 치료·약제비를 지원하는 제도입니다.',
  r.id, c.id,
  '검진비 지원은 만 60세 이상 기준 중위소득 120% 이하(지자체에 따라 완화 운영), 치료관리비 지원은 만 60세 이상 치매환자 중 기준 중위소득 140% 이하가 대상입니다.',
  '진단검사는 1인당 최대 15만원, 감별검사는 의료기관 종별로 1인당 최대 11만원까지 지원합니다. 치매치료관리비(약제비·진료비 본인부담)는 월 최대 3만원, 연간 최대 36만원까지 지원받을 수 있습니다.',
  '주민등록 주소지 관할 보건소 내 치매안심센터를 방문해 신청합니다.',
  array['신분증', '진단서 또는 소견서(치료관리비 지원 시)'],
  array['검진비와 치료관리비는 각각 별도로 신청해야 합니다', '소득 기준은 지자체별로 다르게 운영될 수 있으니 관할 치매안심센터에서 다시 확인하세요'],
  '[]'::jsonb,
  '보건복지부·중앙치매센터', 'https://www.nid.or.kr/',
  '검진비 중위소득 120% 이하 / 치료관리비 중위소득 140% 이하 (지자체별 차이 있음)', 60, null, null,
  null, null, true,
  '중앙치매센터 및 언론 보도 기준 정리', current_date, true,
  'dementia-screening-treatment-cost-support', 2026, true
from regions r, categories c
where r.slug = 'nationwide' and c.slug = 'senior'
on conflict (slug) do nothing;
