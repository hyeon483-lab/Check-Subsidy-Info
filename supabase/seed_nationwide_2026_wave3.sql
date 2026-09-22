-- =============================================================================
-- 전국 확대 3차 배치 (2026년 기준): 울산·세종·강원·제주 신규 지역 추가
-- =============================================================================

insert into regions (slug, name, level, parent_id) values
  ('ulsan', '울산광역시', 'sido', null),
  ('sejong', '세종특별자치시', 'sido', null),
  ('gangwon', '강원특별자치도', 'sido', null),
  ('jeju', '제주특별자치도', 'sido', null)
on conflict (slug) do nothing;

-- 울산 청년 월세 지원 (housing)
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
  'ulsan-youth-rent-support',
  '울산 청년 월세 지원',
  '울산의 무주택 청년에게 월세를 최장 24개월간 지원하는 제도입니다.',
  r.id, c.id,
  '울산시 내에서 부모와 별도로 거주하는 만 19~34세 무주택 청년으로, 청년 독립가구 소득이 기준 중위소득 60% 이하이면서 원가구 소득이 중위소득 100% 이하여야 합니다. 임차보증금 5,000만원 이하·월세 60만원 이하 주택이 대상입니다.',
  '실제 월세 범위 내에서 매달 최대 20만원씩 최장 24개월(최대 480만원)을 지원합니다.',
  '복지로(bokjiro.go.kr) 온라인 신청 또는 울산시 4개 구·1개 군의 읍·면·동 행정복지센터를 방문해 신청합니다.',
  array['임대차계약서', '가족관계증명서', '소득·재산 증빙서류'],
  array['임차보증금 5,000만원, 월세 60만원 한도를 넘지 않는지 확인하세요', '원가구(부모 포함) 소득 기준도 함께 충족해야 합니다'],
  '[]'::jsonb,
  '울산시 청년정책담당관', 'https://www.ulsan.go.kr/s/house',
  '청년가구 중위소득 60% 이하 & 원가구 중위소득 100% 이하', 19, 34, '1인가구',
  null, null, false,
  '울산시 공고 및 언론 보도 기준 정리', current_date, true,
  'ulsan-youth-rent-support', 2026, true
from regions r, categories c
where r.slug = 'ulsan' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 울산 청년수당 (youth)
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
  'ulsan-youth-allowance',
  '울산 청년수당',
  '울산의 미취업 청년에게 구직 활동비를 체크카드 포인트로 지원하는 제도입니다.',
  r.id, c.id,
  '울산광역시에 주민등록이 되어 있는 만 19~34세 청년으로, 최종 학력이 졸업·중퇴·수료 상태인 미취업자여야 합니다. 가구의 기준 중위소득이 150% 이하여야 합니다.',
  '매월 50만원씩 최대 6개월(총 300만원)을 체크카드 포인트 방식으로 지원합니다.',
  '울산시 청년정책 홈페이지 또는 복지로에서 온라인으로 신청합니다.',
  array['최종학력 졸업(중퇴·수료)증명서', '소득 증빙서류'],
  array['재학 중이라면 신청할 수 없습니다', '체크카드 포인트로 지급되니 사용처 제한이 있는지 확인하세요'],
  '[]'::jsonb,
  '울산시 청년정책담당관', 'https://www.ulsan.go.kr/',
  '기준 중위소득 150% 이하', 19, 34, null,
  null, null, false,
  '울산시 공고 및 언론 보도 기준 정리', current_date, true,
  'ulsan-youth-allowance', 2026, true
from regions r, categories c
where r.slug = 'ulsan' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 세종시 출생축하금 (birth)
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
  'sejong-birth-celebration-grant',
  '세종시 출생축하금',
  '세종시에 거주하며 출산한 가정에 지역화폐로 축하금을 지급하는 제도입니다.',
  r.id, c.id,
  '신생아의 출생일 기준으로 부 또는 모가 3개월 이전부터 세종시에 계속 주민등록을 두고 거주했거나, 출생일을 포함해 3개월 이상 계속 거주해야 합니다.',
  '출생아 1인당 120만원을 지역화폐(여민전)로 일시금 지급합니다.',
  '출생신고하는 관할 행정복지센터 또는 정부24를 통해 신청합니다.',
  array['출생신고 관련 서류', '주민등록등본'],
  array['출생일 전후 거주 요건(3개월)을 충족하는지 확인하세요', '여민전으로 지급되므로 사용 가능한 가맹점을 미리 확인하세요'],
  '[]'::jsonb,
  '세종시 보건복지국', 'https://www.sejong.go.kr/life/sub01_010110.do',
  null, null, null, null,
  null, null, true,
  '세종시 공식 홈페이지 기준 정리', current_date, true,
  'sejong-birth-celebration-grant', 2026, true
from regions r, categories c
where r.slug = 'sejong' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 세종청년희망적금 (youth)
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
  'sejong-youth-hope-savings',
  '세종청년희망적금',
  '세종시 청년의 장기 저축과 자산 형성을 돕기 위해 저축액만큼 추가 지원금을 얹어주는 제도입니다.',
  r.id, c.id,
  '세종시에 거주하는 청년이 대상입니다. 정확한 연령·소득 기준과 근속 요건은 세종청년센터 공고문에서 확인해야 합니다.',
  '매달 15만원씩 36개월간 저축하면, 동일한 금액(월 15만원)을 세종시가 추가로 적립해줍니다. 만기 시 본인 납입분과 지원금을 합쳐 최대 1,080만원과 이자를 받을 수 있습니다.',
  '세종청년센터(4242.or.kr) 또는 세종청년희망내일센터를 통해 신청합니다.',
  array['재직증명서 또는 소득 증빙서류', '적금 전용계좌 개설 확인서'],
  array['36개월이라는 장기 저축 기간을 유지해야 만기 지원금을 받을 수 있습니다', '중도 해지 시 지원금이 삭감되거나 지급되지 않을 수 있습니다'],
  '[]'::jsonb,
  '세종시 청년정책과', 'https://www.4242.or.kr/',
  null, null, null, null,
  null, null, true,
  '세종시 공고 및 언론 보도 기준 정리', current_date, true,
  'sejong-youth-hope-savings', 2026, true
from regions r, categories c
where r.slug = 'sejong' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 강원 청년월세 특별지원 (housing)
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
  'gangwon-youth-rent-support',
  '강원 청년월세 특별지원',
  '강원특별자치도의 무주택 청년에게 월세를 최장 24개월간 지원하는 제도로, 춘천·원주·횡성 등 도내 시군에서 운영됩니다.',
  r.id, c.id,
  '만 19~34세 무주택 청년으로 부모와 별도로 거주해야 합니다(기혼 청년도 혼인 여부와 무관하게 신청 가능). 청년가구 소득이 기준 중위소득 60% 이하, 원가구(부모 포함) 소득이 중위소득 100% 이하여야 하며, 임차보증금은 5,000만원 이하여야 합니다.',
  '매달 최대 20만원씩 최장 24개월(최대 480만원)을 지원합니다.',
  '복지로(bokjiro.go.kr) 온라인 신청 또는 거주지 관할 행정복지센터를 방문해 신청합니다.',
  array['임대차계약서', '가족관계증명서', '소득·재산 증빙서류'],
  array['기혼 청년도 신청할 수 있는지 거주지 시군에 확인해보세요', '임차보증금이 5,000만원을 넘지 않는지 확인하세요'],
  '[]'::jsonb,
  '강원특별자치도 청년정책과', 'https://job.gwd.go.kr/youth',
  '청년가구 중위소득 60% 이하 & 원가구 중위소득 100% 이하', 19, 34, null,
  null, null, false,
  '강원특별자치도 공고 및 언론 보도 기준 정리', current_date, true,
  'gangwon-youth-rent-support', 2026, true
from regions r, categories c
where r.slug = 'gangwon' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 제주 육아지원금 (birth)
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
  'jeju-childcare-support-grant',
  '제주 육아지원금',
  '제주에 거주하며 2026년 이후 출산한 가정에 다년간 분할 지급되는 제주도 자체 육아지원금입니다.',
  r.id, c.id,
  '2026년 1월 1일 이후 제주특별자치도에서 출생한 자녀를 양육하는 가정이 대상입니다.',
  '첫째아는 5년간 총 500만원을, 둘째아 이상은 9년간 총 1,000만원을 나누어 지급합니다. 이는 국가 지원 첫만남이용권(첫째 200만원, 둘째 이상 300만원)과는 별도로 지급되는 제주도 자체 지원금입니다.',
  '출생신고하는 관할 읍면동 주민센터 또는 정부24를 통해 신청합니다.',
  array['출생신고 관련 서류', '주민등록등본'],
  array['국가 지원 첫만남이용권과는 별도로 받을 수 있는 제주도 자체 지원금입니다', '첫째와 둘째 이상 자녀의 지급 기간·총액이 다릅니다'],
  '[{"question": "한 번에 다 받나요?", "answer": "아니요, 첫째는 5년, 둘째 이상은 9년에 걸쳐 나누어 지급됩니다."}]'::jsonb,
  '제주특별자치도 여성가족청소년과', 'https://www.jeju.go.kr/wel/child/childPolicy/workSupport.htm',
  null, null, null, null,
  null, null, true,
  '제주특별자치도 공식 홈페이지 및 언론 보도 기준 정리', current_date, true,
  'jeju-childcare-support-grant', 2026, true
from regions r, categories c
where r.slug = 'jeju' and c.slug = 'birth'
on conflict (slug) do nothing;
