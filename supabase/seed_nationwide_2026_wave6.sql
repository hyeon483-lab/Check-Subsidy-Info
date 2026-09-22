-- =============================================================================
-- 전국 확대 6차 배치 (2026년 기준): 결혼·출산 카테고리 추가 보완
-- 충북(결혼), 강원(출산), 전남(결혼)
--
-- 재확인 후에도 제외한 항목 (시·도 단위 공식 사업 없음/현금 지원 없음):
--   - 울산 결혼: 시 자체 사업 없음, 중구·북구 등 구별 개별 조례만 존재
--   - 울산 출산: 시 자체 출산지원금 폐지됨, 5개 구·군이 개별 운영
--   - 충남 결혼: 도 통합 사업 없음, 보령·공주·서천·부여 등 시군별 개별 운영
--   - 충남 출산: 도비 출산장려금 없음(시군비로만 운영), 도 차원 지원은
--     "힘쎈충남 풀케어" 의료·돌봄 서비스 패키지로 가구당 확정 현금액이 아님
-- =============================================================================

-- 충북 결혼비용·출산가정 대출이자 지원사업 (marriage)
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
  'chungbuk-newlywed-birth-loan-interest-support',
  '충북 결혼비용·출산가정 대출이자 지원사업',
  '충청북도 내 신혼부부·출산가정이 결혼비용이나 출산 관련 대출을 받았을 때 이자를 지원하는 도 전역 사업입니다.',
  r.id, c.id,
  '충청북도 11개 시·군에 거주하며, 신청일 기준 가구원 합산 소득이 기준중위소득 180% 이하이고 혼인신고일(또는 자녀 출생일)로부터 1년 이내인 가구가 대상입니다.',
  '1·2금융권 신용대출, 주택자금 대출 등에 대해 이미 낸 이자를 연 최대 50만원까지 지원합니다. 결혼비용 목적은 최대 2년, 출산가정 목적은 최대 3년까지 지원받을 수 있습니다.',
  '주소지 관할 시·군청 또는 충청북도 청년정책 플랫폼 "가치자람"(gachi.chungbuk.go.kr)을 통해 신청합니다.',
  array['혼인관계증명서 또는 출생신고 관련 서류', '대출 관련 서류', '소득 증빙서류'],
  array['기준중위소득 180% 이하 요건을 확인하세요', '인구감소지역(제천·보은·영동·괴산·단양) 5개 시군은 별도의 결혼지원금(100만원)과 중복 가능 여부를 문의해보세요', '대출 범위(신용대출/주택자금 대출)는 시군별 공고에 따라 다를 수 있습니다'],
  '[]'::jsonb,
  '충청북도 청년정책과', 'https://gachi.chungbuk.go.kr/',
  '기준중위소득 180% 이하', null, null, '신혼부부',
  null, null, true,
  '충청북도 공고 및 언론 보도 기준 정리', current_date, true,
  'chungbuk-newlywed-birth-loan-interest-support', 2026, true
from regions r, categories c
where r.slug = 'chungbuk' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 강원 육아기본수당 (birth)
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
  'gangwon-basic-childcare-allowance',
  '강원 육아기본수당',
  '강원특별자치도에 거주하는 영유아 가정에 개월 수 구간별로 매달 수당을 지급하는 도 전역 사업입니다.',
  r.id, c.id,
  '2019년 1월 1일 이후 출생한 자녀를 양육하며, 신청일 기준 12개월 전부터 부 또는 모가 강원특별자치도에 주민등록을 두고 계속 거주한 가정이 대상입니다.',
  '생후 12~47개월은 매달 50만원, 48~71개월은 매달 30만원, 72~95개월은 매달 10만원을 지급합니다.',
  '주소지 관할 읍·면·동 주민센터를 통해 신청합니다.',
  array['가족관계증명서', '주민등록등본'],
  array['자녀의 현재 개월 수에 따라 지급액이 달라지니 구간을 확인하세요', '전입 가정은 강원도 거주 12개월 요건을 채웠는지 먼저 확인하세요', '이 제도는 출산장려금(일시금)이 아닌 매달 지급되는 육아수당입니다'],
  '[]'::jsonb,
  '강원특별자치도 아동청소년과', 'https://www.provin.gangwon.kr/',
  null, 1, 7, null,
  null, null, true,
  '강원특별자치도 조례 및 공식 홈페이지 기준 정리', current_date, true,
  'gangwon-basic-childcare-allowance', 2026, true
from regions r, categories c
where r.slug = 'gangwon' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 전남형 결혼축하금 (marriage)
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
  'jeonnam-marriage-celebration-grant',
  '전남형 결혼축하금',
  '전라남도에 거주하는 신혼부부에게 도 차원에서 결혼축하금을 지급하는 사업으로, 시·군 자체 축하금과 함께 받을 수 있습니다.',
  r.id, c.id,
  '혼인신고일 기준 부부 모두 만 49세 이하이며, 혼인신고 이후 부부 모두 전라남도 내에서 6개월 이상 거주(또는 부부 중 1명 이상 해당 시·군 거주)해야 합니다. 외국인 배우자는 결혼비자 발급일을 기준일로 적용합니다.',
  '부부당 200만원을 일시금으로 지급합니다. 일부 시·군은 자체 축하금을 더해 최대 400만~600만원까지 받을 수 있습니다.',
  '혼인신고일로부터 6개월이 지난 시점부터 1년 6개월 이내에 주소지 관할 읍·면·동 행정복지센터 또는 온라인 "전남 아이톡" 포털에서 신청합니다.',
  array['혼인관계증명서', '주민등록등본'],
  array['혼인신고 후 6개월이 지나야 신청할 수 있고, 1년 6개월이 지나면 신청할 수 없습니다', '시·군별 자체 축하금과 중복 지급되는지 함께 확인하세요', '2026년 7월 전남·광주 통합 이후 운영 방식이 바뀔 수 있으니 신청 전 최신 공고를 반드시 확인하세요'],
  '[]'::jsonb,
  '전라남도 인구청년정책관', 'https://www.jeonnam.go.kr/',
  null, null, null, '신혼부부',
  null, null, true,
  '전라남도 공고 및 언론 보도 기준 정리', current_date, true,
  'jeonnam-marriage-celebration-grant', 2026, true
from regions r, categories c
where r.slug = 'jeonnam' and c.slug = 'marriage'
on conflict (slug) do nothing;
