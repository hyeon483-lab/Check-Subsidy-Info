-- =============================================================================
-- "어르신" 카테고리 콘텐츠 2차 배치: 지자체 효도수당·장수수당 17건
--
-- 효도수당/효행수당(부양 가구에 지급)과 장수수당/장수축하금(어르신 본인에게
-- 지급, 월정액 또는 100세 등 도달 시 1회성 축하금)을 구분해 반영했습니다.
-- 성남시·홍천군·영동군은 현금이 아닌 지역화폐(상품권)로, 부산 기장군은
-- 현금·지역화폐가 아닌 가전제품 현물로 지급되는 점을 본문에 명시했습니다.
--
-- 조사 결과 근거가 단일 출처이거나(용인시 장수수당은 2006년 기사만 확인,
-- 인천 강화군·옹진군, 구미시, 대구 달성군은 아거리게이터 사이트 또는
-- 검증 요약만 확인) 지속 여부를 재확인하기 어려운 항목은 이번 배치에서
-- 제외했습니다.
-- =============================================================================

insert into regions (slug, name, level, parent_id)
select 'gyeonggi-ansan', '안산시', 'sigungu', id from regions where slug = 'gyeonggi'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'gyeonggi-icheon', '이천시', 'sigungu', id from regions where slug = 'gyeonggi'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'gangwon-hongcheon', '홍천군', 'sigungu', id from regions where slug = 'gangwon'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'chungbuk-yeongdong', '영동군', 'sigungu', id from regions where slug = 'chungbuk'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'chungbuk-danyang', '단양군', 'sigungu', id from regions where slug = 'chungbuk'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'jeonbuk-iksan', '익산시', 'sigungu', id from regions where slug = 'jeonbuk'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'jeonnam-damyang', '담양군', 'sigungu', id from regions where slug = 'jeonnam'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'gyeongbuk-uljin', '울진군', 'sigungu', id from regions where slug = 'gyeongbuk'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'gyeongnam-geochang', '거창군', 'sigungu', id from regions where slug = 'gyeongnam'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'gwangju-namgu', '남구', 'sigungu', id from regions where slug = 'gwangju'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'daejeon-seogu', '서구', 'sigungu', id from regions where slug = 'daejeon'
on conflict (slug) do nothing;

insert into regions (slug, name, level, parent_id)
select 'busan-gijang', '기장군', 'sigungu', id from regions where slug = 'busan'
on conflict (slug) do nothing;

-- 수원시 효도수당
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
  'suwon-hyodo-allowance',
  '수원시 효도수당',
  '만 80세 이상 어르신을 모시는 3세대 이상 동거 가구에 반기별로 지급하는 효도수당입니다.',
  r.id, c.id,
  '수원시에 5년 이상 연속으로 동일 거주지에 실거주하며, 만 80세 이상 어르신을 포함해 3세대 이상이 함께 사는 가구가 대상입니다. 수급자는 어르신 본인이 아닌 부양 가구입니다.',
  '매년 6월 20일과 12월 20일, 반기마다 5만원씩 가구당 지급합니다.',
  '관할 동 행정복지센터를 방문해 신청합니다.',
  array['신분증', '가족관계증명서', '주민등록등본'],
  array['수급자는 어르신 본인이 아니라 함께 사는 부양 가구입니다', '5년 이상 동일 거주지 실거주 요건을 충족해야 합니다'],
  '[]'::jsonb,
  '수원특례시 노인복지과', 'https://www.suwon.go.kr/',
  null, 80, null, null,
  null, null, true,
  '수원특례시청 공식 페이지 기준 정리', current_date, true,
  'suwon-hyodo-allowance', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-suwon' and c.slug = 'senior'
on conflict (slug) do nothing;

-- 고양시 효도수당지원사업
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
  'goyang-hyodo-allowance-support',
  '고양시 효도수당지원사업',
  '직계존속을 포함해 4세대 이상이 함께 사는 가정에 매달 효도수당을 지급하는 제도입니다.',
  r.id, c.id,
  '고양시에 3년 이상 계속 동일 주소로 거주하며, 직계존속을 포함해 4세대 이상이 함께 사는 가정이 대상입니다.',
  '매달 7만원을 지급합니다.',
  '관할 동 행정복지센터에 신청서, 신분증, 통장사본 등을 제출해 신청합니다.',
  array['신청서', '신분증', '통장사본', '가족관계증명서'],
  array['4세대 이상 동거 가정만 대상입니다', '3년 이상 동일 주소 거주 요건을 충족해야 합니다'],
  '[]'::jsonb,
  '고양특례시 노인복지과', 'https://www.goyang.go.kr/',
  null, null, null, null,
  null, null, true,
  '고양특례시청 공식 페이지 기준 정리', current_date, true,
  'goyang-hyodo-allowance-support', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-goyang' and c.slug = 'senior'
on conflict (slug) do nothing;

-- 화성시 장수수당
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
  'hwaseong-jangsu-allowance',
  '화성시 장수수당',
  '만 80세 이상 어르신에게 매달 지급하는 장수수당으로, 기초연금 수급자는 제외됩니다.',
  r.id, c.id,
  '화성시에 거주하는 만 80세 이상 어르신 중 기초연금을 받지 않는 분이 대상입니다.',
  '매달 20일, 월 3만원을 지급합니다.',
  '관할 읍·면·동 행정복지센터를 방문해 신청합니다.',
  array['신분증'],
  array['기초연금 수급자는 대상에서 제외됩니다'],
  '[]'::jsonb,
  '화성특례시청', 'https://www.hscity.go.kr/',
  null, 80, null, null,
  null, null, true,
  '화성시 장수수당 지급조례 기준 정리', current_date, true,
  'hwaseong-jangsu-allowance', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-hwaseong' and c.slug = 'senior'
on conflict (slug) do nothing;

-- 안산시 장수수당 및 100세 축하금
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
  'ansan-longevity-allowance-and-centenarian-grant',
  '안산시 장수수당 및 100세 축하금',
  '만 85세 이상 어르신에게 매달 장수수당을, 100세를 맞은 어르신에게는 별도의 축하금을 지급하는 제도입니다.',
  r.id, c.id,
  '안산시에 1년 이상 거주하는 만 85세 이상 어르신 중 기초연금을 받지 않는 분이 장수수당 대상이며, 100세 축하금은 만 100세에 도달한 어르신에게 별도로 지급됩니다.',
  '장수수당은 매달 15일, 월 3만원을 지급합니다. 100세를 맞은 어르신에게는 100세 축하금으로 50만원을 1회 지급합니다.',
  '관할 동 행정복지센터를 방문해 신청합니다.',
  array['신분증'],
  array['기초연금 수급자는 장수수당 대상에서 제외됩니다', '100세 축하금은 장수수당과 별도로 신청해야 합니다'],
  '[]'::jsonb,
  '안산시청', 'https://www.ansan.go.kr/',
  null, 85, null, null,
  null, null, true,
  '안산시청 노인복지 안내 및 언론 보도 기준 정리', current_date, true,
  'ansan-longevity-allowance-and-centenarian-grant', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-ansan' and c.slug = 'senior'
on conflict (slug) do nothing;

-- 이천시 장수수당 및 100세 축하금
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
  'icheon-longevity-allowance-and-centenarian-grant',
  '이천시 장수수당 및 100세 축하금',
  '만 90세 이상 어르신에게 매달 장수수당을, 100세를 맞은 어르신에게는 별도의 축하금을 지급하는 제도입니다.',
  r.id, c.id,
  '이천시에 1년 이상 거주하는 만 90세 이상 어르신 중 기초연금을 받지 않는 분이 장수수당 대상이며, 100세 축하금은 만 100세에 도달한 어르신에게 별도로 지급됩니다.',
  '장수수당은 매달 20일, 월 4만원을 지급합니다. 100세를 맞은 어르신에게는 100세 축하금으로 100만원을 1회 지급합니다.',
  '관할 읍·면·동 행정복지센터를 방문해 신청합니다.',
  array['신분증'],
  array['기초연금 수급자는 장수수당 대상에서 제외됩니다', '100세 축하금은 장수수당과 별도로 신청해야 합니다'],
  '[]'::jsonb,
  '이천시청', 'https://www.icheon.go.kr/',
  null, 90, null, null,
  null, null, true,
  '이천시청 및 이천시의회 자료 기준 정리', current_date, true,
  'icheon-longevity-allowance-and-centenarian-grant', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-icheon' and c.slug = 'senior'
on conflict (slug) do nothing;

-- 성남시 장수축하금
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
  'seongnam-longevity-celebration-grant',
  '성남시 장수축하금',
  '100세를 맞은 어르신에게 지역화폐로 축하금을 지급하는 제도로, 장수시민증도 함께 수여합니다.',
  r.id, c.id,
  '성남시에 3년 이상 계속 거주한 만 100세 어르신이 대상입니다.',
  '50만원 상당의 성남사랑상품권(지역화폐)과 장수시민증을 지급합니다. 현금이 아닌 지역화폐로 지급되는 점에 유의하세요.',
  '관할 동 행정복지센터를 통해 신청합니다.',
  array['신분증', '주민등록등본'],
  array['현금이 아닌 지역화폐(성남사랑상품권)로 지급됩니다', '3년 이상 계속 거주 요건을 충족해야 합니다'],
  '[]'::jsonb,
  '성남시청', 'https://www.seongnam.go.kr/',
  null, 100, null, null,
  null, null, true,
  '성남시 장수노인 예우 및 지원에 관한 조례 및 언론 보도 기준 정리', current_date, true,
  'seongnam-longevity-celebration-grant', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-seongnam' and c.slug = 'senior'
on conflict (slug) do nothing;

-- 홍천군 장수축하금
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
  'hongcheon-longevity-celebration-grant',
  '홍천군 장수축하금',
  '만 90세 이상 어르신에게 지역화폐로 축하금을 지급하는 제도입니다.',
  r.id, c.id,
  '홍천군에 3년 이상 계속 주민등록을 두고 거주한 만 90세 이상 어르신이 대상입니다.',
  '50만원 상당의 지역화폐를 1회 지급합니다. 현금이 아닌 지역화폐로 지급되는 점에 유의하세요.',
  '매년 1월 2일부터 관할 읍·면 행정복지센터에서 신청합니다.',
  array['신분증', '주민등록등본'],
  array['현금이 아닌 지역화폐로 지급됩니다', '91세 이상도 한시적으로 소급 신청할 수 있는 해가 있으니 공고를 확인하세요'],
  '[]'::jsonb,
  '홍천군청', 'https://www.hongcheon.go.kr/',
  null, 90, null, null,
  null, null, false,
  '언론 보도 기준 정리', current_date, true,
  'hongcheon-longevity-celebration-grant', 2026, true
from regions r, categories c
where r.slug = 'gangwon-hongcheon' and c.slug = 'senior'
on conflict (slug) do nothing;

-- 영동군 100세 축하금
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
  'yeongdong-centenarian-celebration-grant',
  '영동군 100세 축하금',
  '만 100세에 도달한 어르신에게 지역상품권으로 축하금을 지급하는 충북 11개 시군 중 최초의 제도입니다.',
  r.id, c.id,
  '영동군에 3년 이상 연속 거주한 만 100세 도달 어르신이 대상이며, 100세가 되는 달부터 1년 이내에 신청해야 합니다.',
  '50만원 상당의 영동사랑상품권을 1회 지급합니다. 현금이 아닌 지역상품권으로 지급되는 점에 유의하세요.',
  '관할 읍·면사무소를 방문해 신청합니다.',
  array['신분증', '주민등록등본'],
  array['100세가 되는 달부터 1년 이내에 신청해야 합니다', '현금이 아닌 영동사랑상품권으로 지급됩니다'],
  '[]'::jsonb,
  '영동군청', 'https://www.yd21.go.kr/',
  null, 100, null, null,
  null, null, true,
  '노컷뉴스 및 서울신문 등 언론 보도 기준 정리', current_date, true,
  'yeongdong-centenarian-celebration-grant', 2026, true
from regions r, categories c
where r.slug = 'chungbuk-yeongdong' and c.slug = 'senior'
on conflict (slug) do nothing;

-- 단양군 효도수당
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
  'danyang-hyodo-allowance',
  '단양군 효도수당',
  '3세대 이상이 함께 사는 가정에 매달 효도수당을 지급하는 제도입니다.',
  r.id, c.id,
  '단양군에 거주하며 3세대 이상이 함께 사는 가정이 대상입니다.',
  '매달 5만원을 지급합니다.',
  '관할 읍·면 행정복지센터를 방문해 신청합니다.',
  array['신분증', '가족관계증명서'],
  array['3세대 이상 동거 가정만 대상입니다'],
  '[]'::jsonb,
  '단양군청', 'https://www.danyang.go.kr/',
  null, null, null, null,
  null, null, true,
  '언론 보도 기준 정리', current_date, true,
  'danyang-hyodo-allowance', 2026, true
from regions r, categories c
where r.slug = 'chungbuk-danyang' and c.slug = 'senior'
on conflict (slug) do nothing;

-- 익산시 효도수당
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
  'iksan-hyodo-allowance',
  '익산시 효도수당',
  '4세대 이상이 함께 사는 가정의 만 65세 이상 구성원에게 1인당 매달 효도수당을 지급하는 제도입니다.',
  r.id, c.id,
  '익산시에 1년 이상 거주하며 4세대 이상이 함께 사는 가정 내 만 65세 이상 구성원이 대상입니다.',
  '구성원 1인당 매달 10만원을 매월 25일 계좌로 지급합니다.',
  '관할 읍·면·동 사무소를 방문해 신청합니다.',
  array['신분증', '가족관계증명서', '통장 사본'],
  array['4세대 이상 동거 가정만 대상입니다', '1년 이상 거주 요건을 충족해야 합니다'],
  '[]'::jsonb,
  '익산시청', 'https://www.iksan.go.kr/',
  null, 65, null, null,
  null, null, true,
  '복지로 지자체 서비스 안내 기준 정리', current_date, true,
  'iksan-hyodo-allowance', 2026, true
from regions r, categories c
where r.slug = 'jeonbuk-iksan' and c.slug = 'senior'
on conflict (slug) do nothing;

-- 담양군 효도수당
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
  'damyang-hyodo-allowance',
  '담양군 효도수당',
  '만 80세 이상 어르신을 모시는 3대 이상 동거가정에 명절마다 지급하는 효도수당입니다.',
  r.id, c.id,
  '신청일 기준 가구원 전원이 담양군에 1년 이상 거주하며, 만 80세 이상(1946년 12월 31일 이전 출생) 어르신을 모시는 3대 이상 동거가정이 대상입니다.',
  '설날과 추석, 명절마다 각 20만원씩 연 40만원을 지급합니다.',
  '명절별로 접수 기간에 맞춰 신청합니다(예: 설 신청 마감 2월 4일 등 매년 공고에 따라 달라집니다).',
  array['신분증', '가족관계증명서', '주민등록등본'],
  array['명절마다 별도로 신청해야 합니다', '가구원 전원이 1년 이상 거주해야 합니다'],
  '[]'::jsonb,
  '담양군청', 'https://www.damyang.go.kr/',
  null, 80, null, null,
  null, null, false,
  '아시아경제 및 뉴스핌 등 언론 보도 기준 정리', current_date, true,
  'damyang-hyodo-allowance', 2026, true
from regions r, categories c
where r.slug = 'jeonnam-damyang' and c.slug = 'senior'
on conflict (slug) do nothing;

-- 울진군 장수축하금
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
  'uljin-longevity-celebration-grant',
  '울진군 장수축하금',
  '만 100세에 도달한 어르신에게 생애 1회 지급하는 장수축하금 제도입니다.',
  r.id, c.id,
  '울진군에 주민등록을 두고 거주하는 만 100세 도달 어르신이 대상입니다.',
  '100만원을 생애 1회 지급합니다.',
  '100세 생일이 속한 달에 읍·면 담당 공무원이 가정을 방문해 신청서를 접수하며, 다음 달 계좌로 지급됩니다.',
  array['신분증', '주민등록등본'],
  array['생애 1회만 지급됩니다', '담당 공무원이 직접 방문해 접수를 도와줍니다'],
  '[]'::jsonb,
  '울진군청', 'https://www.uljin.go.kr/',
  null, 100, null, null,
  null, null, true,
  '경북일보 및 매일신문 등 언론 보도 기준 정리', current_date, true,
  'uljin-longevity-celebration-grant', 2026, true
from regions r, categories c
where r.slug = 'gyeongbuk-uljin' and c.slug = 'senior'
on conflict (slug) do nothing;

-- 거창군 효도수당
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
  'geochang-hyodo-allowance',
  '거창군 효도수당',
  '만 80세 이상 어르신을 모시는 3세대 이상 동거가구에 매달 지급하는 효도수당으로, 2026년부터 대상이 확대됐습니다.',
  r.id, c.id,
  '거창군에 1년 이상 거주하며 만 80세 이상 어르신을 포함해 3세대 이상이 함께 사는 가구가 대상입니다(2026년부터 기존 4세대 이상에서 3세대 이상으로 확대).',
  '매달 5만원씩 연 최대 60만원을 지급합니다.',
  '관할 읍·면 행정복지센터를 방문해 신청합니다.',
  array['신분증', '가족관계증명서'],
  array['2026년부터 3세대 이상 가구로 대상이 확대됐습니다', '신청을 유지하는 동안 계속 지급됩니다'],
  '[]'::jsonb,
  '거창군청', 'https://www.geochang.go.kr/',
  null, 80, null, null,
  null, null, true,
  '뉴스핌 및 경남도민일보 등 언론 보도 기준 정리', current_date, true,
  'geochang-hyodo-allowance', 2026, true
from regions r, categories c
where r.slug = 'gyeongnam-geochang' and c.slug = 'senior'
on conflict (slug) do nothing;

-- 광주 남구 장수효도수당
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
  'gwangju-namgu-longevity-hyodo-allowance',
  '광주 남구 장수효도수당',
  '만 80세 이상 어르신을 모시는 3세대 효도가정에 반기별로 지급하는 수당입니다.',
  r.id, c.id,
  '신청일 기준 5년 이상 동일 주민등록을 유지하며 실거주하고, 만 80세 이상 어르신을 포함한 3세대 효도가정이 대상입니다.',
  '매년 6월과 12월, 반기마다 15만원씩 연 30만원을 지급합니다.',
  '관할 동 행정복지센터를 방문해 신청합니다.',
  array['신분증', '가족관계증명서', '주민등록등본'],
  array['5년 이상 동일 주민등록 유지 및 실거주 요건을 충족해야 합니다'],
  '[]'::jsonb,
  '광주광역시 남구청', 'https://www.gwangjunamgu.go.kr/',
  null, 80, null, null,
  null, null, true,
  '언론 보도 기준 정리', current_date, true,
  'gwangju-namgu-longevity-hyodo-allowance', 2026, true
from regions r, categories c
where r.slug = 'gwangju-namgu' and c.slug = 'senior'
on conflict (slug) do nothing;

-- 대전 서구 장수축하금
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
  'daejeon-seogu-longevity-celebration-grant',
  '대전 서구 장수축하금',
  '만 100세에 도달한 어르신에게 지급하는 장수축하금 제도입니다.',
  r.id, c.id,
  '대전광역시에 2년 이상 계속 거주한 만 100세 도달 어르신이 대상이며, 지급기준일로부터 3개월 이내에 신청해야 합니다.',
  '100만원을 지급합니다.',
  '관할 동 주민센터에 신청서, 신분증, 통장, 위임장(대리 신청 시) 등을 제출해 신청합니다.',
  array['신분증', '통장 사본', '위임장(대리 신청 시)'],
  array['지급기준일로부터 3개월 이내에 신청해야 합니다', '대전광역시 2년 이상 계속 거주 요건을 충족해야 합니다'],
  '[]'::jsonb,
  '대전광역시 서구청 노인장애인과', 'https://www.seogu.go.kr/',
  null, 100, null, null,
  null, null, true,
  '대전광역시 서구청 공식 페이지 기준 정리', current_date, true,
  'daejeon-seogu-longevity-celebration-grant', 2026, true
from regions r, categories c
where r.slug = 'daejeon-seogu' and c.slug = 'senior'
on conflict (slug) do nothing;

-- 부산 기장군 장수축하물품
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
  'busan-gijang-longevity-celebration-gift',
  '부산 기장군 장수축하물품',
  '만 100세 이상 어르신에게 현금이나 상품권이 아닌 가전제품을 지급하는 이례적인 장수 축하 제도입니다.',
  r.id, c.id,
  '기장군에 1년 이상 거주한 만 100세 이상 어르신이 대상입니다.',
  '청소기·제습기·공기청정기 등 가전제품 중 하나를 50만원 상당으로 선택해 지급합니다. 현금이나 지역화폐가 아닌 물품으로 지급되는 점이 특징입니다.',
  '생일을 기준으로 관할 읍·면·동 행정복지센터를 통해 신청합니다.',
  array['신분증', '주민등록등본'],
  array['현금이나 지역화폐가 아닌 가전제품으로 지급됩니다', '1년 이상 거주 요건을 충족해야 합니다'],
  '[]'::jsonb,
  '부산광역시 기장군청', 'https://www.gijang.go.kr/',
  null, 100, null, null,
  null, null, true,
  '기장군 장수축하물품 지급에 관한 조례 및 언론 보도 기준 정리', current_date, true,
  'busan-gijang-longevity-celebration-gift', 2026, true
from regions r, categories c
where r.slug = 'busan-gijang' and c.slug = 'senior'
on conflict (slug) do nothing;

-- 제주특별자치도 장수노인수당
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
  'jeju-longevity-senior-allowance',
  '제주특별자치도 장수노인수당',
  '만 80세 이상 어르신에게 매달 지급하는 제주도 전역의 장수노인수당으로, 2004년부터 시행되고 있습니다.',
  r.id, c.id,
  '제주특별자치도에 주민등록을 둔 만 80세 이상 어르신이 대상입니다.',
  '매달 2만 5,000원을 지급합니다.',
  '제주시 또는 서귀포시를 통해 신청합니다.',
  array['신분증', '주민등록등본'],
  array['2004년부터 시행돼온 제주도 전역 제도입니다'],
  '[]'::jsonb,
  '제주특별자치도', 'https://www.jeju.go.kr/',
  null, 80, null, null,
  null, null, true,
  '제주특별자치도 장수노인수당 지급 등에 관한 조례 및 언론 보도 기준 정리', current_date, true,
  'jeju-longevity-senior-allowance', 2026, true
from regions r, categories c
where r.slug = 'jeju' and c.slug = 'senior'
on conflict (slug) do nothing;
