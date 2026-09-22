-- =============================================================================
-- 2026년 기준 현재 제도 확대 (11건 신규)
-- 서울/경기/인천의 남은 카테고리(결혼/출산/청년/주거)와 구·시 단위(강남구, 수원시)까지
-- 폭을 넓힌 실제 지원금 데이터입니다. 공식 페이지/언론 보도를 종합해 재구성했습니다.
-- 제도는 예산 소진, 조례 개정 등으로 수시로 바뀔 수 있으니 agency_url에서 다시 확인하세요.
-- =============================================================================

-- 서울시 청년수당 (youth)
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
  'seoul-youth-allowance',
  '서울시 청년수당',
  '미취업 청년의 구직 활동을 돕기 위해 서울시가 매월 현금을 지원하는 제도입니다.',
  r.id, c.id,
  '공고일 기준 서울시에 거주하는 만 19~34세 미취업 청년(최종학력 졸업자)으로, 가구 중위소득 150% 이하이며 주 30시간 이하로만 근로 중인 경우 신청할 수 있습니다.',
  '매월 50만원씩 최장 6개월(최대 300만원)을 지원합니다.',
  '청년몽땅정보통(youth.seoul.go.kr)에서 온라인 접수합니다. 연중 여러 차수로 나누어 모집하며, 회차별 신청 기간이 다릅니다.',
  array['최종학력 졸업증명서', '가족관계증명서', '소득 증빙서류'],
  array['주 30시간을 초과해 근무 중이라면 신청할 수 없습니다', '이미 청년수당을 지원받은 적이 있다면 재참여 제한이 있을 수 있습니다', '모집 차수별 신청 기간을 놓치지 않도록 청년몽땅정보통 공지사항을 확인하세요'],
  '[{"question": "청년수당은 어디에 써야 하나요?", "answer": "구직활동과 관련된 직접·간접 비용에 자유롭게 사용할 수 있습니다."}]'::jsonb,
  '서울시 청년정책담당관', 'https://youth.seoul.go.kr/',
  '기준 중위소득 150% 이하', 19, 34, null,
  null, null, false,
  '서울시 공고 및 언론 보도 기준 정리', current_date, true,
  'seoul-youth-allowance', 2026, true
from regions r, categories c
where r.slug = 'seoul' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 서울시 산모·신생아 건강관리 지원 (birth)
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
  'seoul-maternal-newborn-care',
  '서울시 산모·신생아 건강관리 지원',
  '출산 가정에 산모·신생아 건강관리사 파견 비용과 산후조리경비 바우처를 지원하는 서울시 제도입니다.',
  r.id, c.id,
  '서울시에 거주하는 출산 가정이 대상입니다. 산모·신생아 건강관리사 파견 서비스는 소득 기준과 관계없이 이용할 수 있으며, 본인부담금의 90%를 지원받으려면 생계·의료·주거·교육급여 수급자이거나 차상위계층이어야 합니다.',
  '산후조리경비 바우처는 2026년 3월 30일부터 자녀 수에 따라 첫째 100만원, 둘째 120만원, 셋째 이상 150만원으로 차등 지원됩니다(서울 거주요건과 바우처 사용지역 제한은 2026년 7월 1일부터 적용). 별도로 산모·신생아 건강관리사 파견 서비스 이용 시, 저소득 가구는 본인부담금의 90%를 지원받을 수 있습니다.',
  '서울시 임신·출산 정보센터 또는 거주지 보건소를 통해 신청합니다.',
  array['산모수첩 또는 출생신고 서류', '주민등록등본', '수급자·차상위 증빙서류(해당 시)'],
  array['바우처 지원 금액이 자녀 수에 따라 다른지 확인하세요', '거주요건·사용지역 제한은 2026년 7월 1일부터 적용됩니다', '저소득 가구는 건강관리사 서비스 본인부담금 90% 지원도 함께 확인하세요'],
  '[]'::jsonb,
  '서울시 여성가족정책실 / 관할 보건소', 'https://seoul-agi.seoul.go.kr/health-support',
  '본인부담금 90% 지원은 수급자·차상위계층 기준 (바우처 자체는 소득 무관)', null, null, null,
  null, null, true,
  '서울시 공고 및 언론 보도 기준 정리', current_date, true,
  'seoul-maternal-newborn-care', 2026, true
from regions r, categories c
where r.slug = 'seoul' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 서울시 신혼부부 결혼·살림비용 지원 (marriage)
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
  'seoul-newlywed-wedding-cost-support',
  '서울시 신혼부부 결혼·살림비용 지원',
  '경제적으로 어려운 신혼부부에게 혼수·살림 장만 비용을 현금으로 지원하는 서울시 시범사업입니다.',
  r.id, c.id,
  '2025년 7월 14일 이후 혼인신고(초혼·재혼 모두 해당)한 부부 중 1인 이상이 서울에 거주하며, 신청일 기준 180일 이상 거주해야 합니다. 부부합산 소득이 기준 중위소득 120% 이하여야 하고, 생애 1회만 지원됩니다.',
  '가구당 최대 100만원을 현금으로 지원합니다. 총 1,000가구 규모로 운영되며, 예산 초과 시 소득이 낮은 순 → 신청일이 빠른 순 → 혼인신고일이 빠른 순으로 지원 대상을 정합니다.',
  '탄생육아 몽땅정보통(umppa.seoul.go.kr)에서 온라인으로 신청합니다.',
  array['혼인관계증명서', '주민등록등본', '소득 증빙서류'],
  array['부부 중 한 명이라도 이미 지원받았다면 신청할 수 없습니다', '혼인신고일이 2025년 7월 14일 이후인지 확인하세요', '예산 소진 시 조기 마감될 수 있습니다'],
  '[{"question": "재혼도 지원 대상인가요?", "answer": "네, 초혼과 재혼 모두 지원 대상에 포함됩니다."}]'::jsonb,
  '서울시 여성가족정책실', 'https://umppa.seoul.go.kr/',
  '기준 중위소득 120% 이하', null, null, '신혼부부',
  null, null, false,
  '서울시 공고 및 언론 보도 기준 정리', current_date, true,
  'seoul-newlywed-wedding-cost-support', 2026, true
from regions r, categories c
where r.slug = 'seoul' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 경기도 신혼부부 전세자금 대출이자 지원 (marriage)
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
  'gyeonggi-newlywed-jeonse-loan-interest',
  '경기도 신혼부부 전세자금 대출이자 지원',
  '경기도 내 무주택 신혼부부의 전세자금 대출이자 일부를 지원하는 제도입니다.',
  r.id, c.id,
  '경기도 내 무주택 신혼부부로 혼인 7년 이내이며, 부부합산 소득이 기준 중위소득 180% 이하여야 합니다. 전용면적 85㎡ 이하, 전세보증금 5억원 이하 주택이 대상입니다.',
  '전세자금 대출잔액의 1% 범위 내에서 최대 100만원을 지원합니다. 다른 이자지원 사업과는 중복으로 받을 수 없습니다.',
  '거주지 행정복지센터에 방문해 신청합니다.',
  array['혼인관계증명서', '전세임대차계약서', '대출 관련 서류', '소득 증빙서류'],
  array['다른 전세자금 이자지원 사업과 중복 신청이 되는지 미리 확인하세요', '전용면적과 전세보증금 한도를 넘지 않는지 확인하세요', '정확한 소득·자격 기준은 시군마다 다를 수 있어 행정복지센터 확인이 필요합니다'],
  '[]'::jsonb,
  '경기도 주택정책과', 'https://housing.gg.go.kr/',
  '부부합산 기준 중위소득 180% 이하', null, null, '신혼부부',
  null, null, true,
  '경기주거복지포털 및 언론 보도 기준 정리', current_date, true,
  'gyeonggi-newlywed-jeonse-loan-interest', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 경기도 산후조리비 지원 (birth)
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
  'gyeonggi-postpartum-care-support',
  '경기도 산후조리비 지원',
  '경기도에 거주하며 출산한 가정에 산후조리비를 지역화폐로 지급하는 제도입니다.',
  r.id, c.id,
  '출생일 및 신청일 기준 부모 중 한 명이 경기도에 주민등록을 두고 실제 거주 중이어야 하며, 출생일로부터 12개월 이내에 신청해야 합니다. 소득 기준은 없습니다.',
  '출생아 1인당 50만원을 지역화폐로 지급합니다. 다태아는 출생아 수만큼 50만원씩 곱해 지급됩니다(쌍둥이 100만원 등).',
  '출생신고하는 관할 행정복지센터를 방문하거나, 경기민원24 온라인으로 신청합니다.',
  array['출생신고 관련 서류', '주민등록등본'],
  array['출생일로부터 12개월 이내에 신청해야 합니다', '매년 접수 마감일이 정해져 있으니 미리 확인하세요', '다태아는 출생아 수만큼 지급액이 늘어납니다'],
  '[]'::jsonb,
  '경기도 인구정책과', 'https://www.gg.go.kr/',
  null, null, null, null,
  null, null, true,
  '경기도 공고 및 언론 보도 기준 정리', current_date, true,
  'gyeonggi-postpartum-care-support', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi' and c.slug = 'birth'
on conflict (slug) do nothing;

-- 경기도 전세보증금 반환보증 보증료 지원 (housing)
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
  'gyeonggi-jeonse-guarantee-fee-support',
  '경기도 전세보증금 반환보증 보증료 지원',
  '전세보증금을 지키기 위해 반환보증에 가입한 경기도민에게 보증료를 지원하는 제도입니다.',
  r.id, c.id,
  '전세보증금 3억원 이하 주택에 거주하는 무주택 세입자가 대상입니다. 소득 기준은 청년(만 19~39세) 5천만원 이하, 청년 외 6천만원 이하, 신혼부부 7천5백만원 이하입니다. 외국인, 등록임대사업자의 등록임대주택 임차인, 법인 임차인은 제외됩니다.',
  '청년과 신혼부부는 이미 납부한 보증료 전액(최대 40만원)을, 그 외 대상자는 보증료의 90%(최대 40만원)를 지원합니다.',
  '경기민원24(gg24.gg.go.kr) 또는 경기주거복지포털에서 온라인 신청합니다. 저소득·신혼부부 대상 주택도시보증공사 보증료 할인 대상자는 반환보증 가입 시 별도 절차 없이 자동 접수됩니다.',
  array['전세보증금 반환보증 가입 증서', '보증료 납부 영수증', '임대차계약서', '소득 증빙서류'],
  array['전세보증금이 3억원을 넘지 않는지 확인하세요', '등록임대사업자의 임대주택에 거주한다면 대상이 아닙니다', '청년·신혼부부는 보증료 전액을, 그 외는 90%를 지원받습니다'],
  '[]'::jsonb,
  '경기도 주택정책과', 'https://housing.gg.go.kr/html/51502.do',
  '청년 5천만원 이하 / 청년 외 6천만원 이하 / 신혼부부 7천5백만원 이하', null, null, '무관',
  null, null, true,
  '경기도 공고 및 언론 보도 기준 정리', current_date, true,
  'gyeonggi-jeonse-guarantee-fee-support', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 인천시 청년·신혼부부 주택임차보증금 이자 지원 (marriage)
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
  'incheon-newlywed-jeonse-loan-interest',
  '인천시 청년·신혼부부 주택임차보증금 이자 지원',
  '인천에 거주하는 청년과 신혼부부의 전세·보증부월세 임차보증금 대출이자를 지원하는 제도입니다.',
  r.id, c.id,
  '신혼부부는 부부합산 연소득 8천만원 이하이며, 임차보증금 2억 5천만원 이하인 전세 또는 보증부월세 주택에 거주해야 합니다.',
  '인천시 이자 지원금리 연 3.0~3.5%를 지원합니다.',
  '인천주거포털을 통해 대상자 여부를 확인한 뒤 협약은행에서 대출을 신청합니다.',
  array['혼인관계증명서', '임대차계약서', '부부합산 소득 증빙서류'],
  array['부부합산 연소득이 8천만원을 넘지 않는지 확인하세요', '임차보증금이 2억 5천만원을 넘지 않는지 확인하세요'],
  '[]'::jsonb,
  '인천시 주택정책과', 'https://www.incheon.go.kr/housing/hou060201',
  '부부합산 연소득 8천만원 이하', null, null, '신혼부부',
  null, null, true,
  '인천주거포털 및 언론 보도 기준 정리', current_date, true,
  'incheon-newlywed-jeonse-loan-interest', 2026, true
from regions r, categories c
where r.slug = 'incheon' and c.slug = 'marriage'
on conflict (slug) do nothing;

-- 인천시 전세보증금 반환보증 보증료 지원 (housing)
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
  'incheon-jeonse-guarantee-fee-support',
  '인천시 전세보증금 반환보증 보증료 지원',
  '전세사기를 예방하기 위해 반환보증에 가입한 인천시민에게 보증료를 지원하는 제도입니다.',
  r.id, c.id,
  '인천시에 거주하며 전세보증금 반환보증에 가입한 임차인이 대상입니다.',
  '실제 납부한 보증료를 최대 40만원 한도로 지원합니다.',
  '인천시 또는 관할 구청을 통해 신청합니다. 정확한 신청 채널과 서류는 공고문을 확인해야 합니다.',
  array['전세보증금 반환보증 가입 증서', '보증료 납부 영수증', '임대차계약서'],
  array['반환보증에 먼저 가입한 뒤 보증료 납부 영수증을 보관하세요', '지원 한도(최대 40만원)를 넘는 보증료는 자비 부담입니다'],
  '[]'::jsonb,
  '인천시 주택정책과', 'https://www.incheon.go.kr/',
  null, null, null, '무관',
  null, null, true,
  '인천시 공고 및 언론 보도 기준 정리', current_date, true,
  'incheon-jeonse-guarantee-fee-support', 2026, true
from regions r, categories c
where r.slug = 'incheon' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 인천시 드림체크카드(구직활동비 지원) (youth)
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
  'incheon-dream-check-card',
  '인천시 드림체크카드(구직활동비 지원)',
  '인천의 미취업 청년에게 구직활동비를 현금과 지역화폐로 지원하는 제도입니다.',
  r.id, c.id,
  '공고일 기준 인천시에 거주하는 만 18~39세 구직활동 중인 미취업 청년이 대상입니다(2026년 기준 1986년 1월 2일~2008년 1월 1일 출생자). 의무복무 제대군인은 복무기간에 따라 지원 연령 상한이 최대 3년까지 연장됩니다.',
  '1인당 월 50만원씩 최장 6개월(최대 300만원)을 지원합니다. 드림체크카드 30만원과 인천e음 소비쿠폰 20만원으로 나누어 지급됩니다. 지원 규모는 600명입니다.',
  '인천청년포털(youth.incheon.go.kr)에서 온라인으로 신청합니다.',
  array['신분증', '구직활동 증빙서류', '병역관련 서류(해당 시)'],
  array['지원 인원이 600명으로 한정되어 있어 조기 마감될 수 있습니다', '제대군인은 복무기간에 따른 연령 상한 연장 여부를 확인하세요'],
  '[]'::jsonb,
  '인천시 청년정책담당관', 'https://youth.incheon.go.kr/',
  null, 18, 39, null,
  null, null, false,
  '인천청년포털 및 언론 보도 기준 정리', current_date, true,
  'incheon-dream-check-card', 2026, true
from regions r, categories c
where r.slug = 'incheon' and c.slug = 'youth'
on conflict (slug) do nothing;

-- 강남구 청년 월세 지원 (housing, sigungu)
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
  'gangnam-youth-rent-support',
  '강남구 청년 월세 지원 (국토부 사업 강남구 시행)',
  '국토교통부 청년월세 한시특별지원을 강남구에서 시행하는 사업으로, 부모와 별도 거주하는 무주택 청년의 월세를 지원합니다.',
  r.id, c.id,
  '만 19~34세 무주택 청년으로 부모와 별도로 거주해야 합니다. 청년 본인 가구 기준 중위소득 60% 이하 및 원가구 기준 중위소득 100% 이하, 재산은 청년 본인 가구 1억 2천 2백만원 이하 및 원가구 4억 7천만원 이하여야 합니다.',
  '실제 납부하는 월세를 최대 20만원까지 지원합니다. 강남구 모집 인원은 371명입니다.',
  '복지로(bokjiro.go.kr) 온라인 신청 또는 주소지 관할 주민센터 방문 신청이 가능합니다.',
  array['임대차계약서', '가족관계증명서', '소득·재산 증빙서류'],
  array['원가구(부모 포함)와 청년 본인 가구 모두 소득·재산 기준을 충족해야 합니다', '모집 인원이 한정되어 있어 조기 마감될 수 있습니다', '신청 기간을 놓치지 않도록 공고문을 미리 확인하세요'],
  '[]'::jsonb,
  '강남구청 사회보장과', 'https://www.gangnam.go.kr/',
  '청년가구 중위소득 60% 이하 & 원가구 중위소득 100% 이하', 19, 34, '1인가구',
  null, null, false,
  '강남구청 공고 기준 정리', current_date, true,
  'gangnam-youth-rent-support', 2026, true
from regions r, categories c
where r.slug = 'seoul-gangnam' and c.slug = 'housing'
on conflict (slug) do nothing;

-- 수원시 청년 주거 패키지 지원 (housing, sigungu)
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
  'suwon-youth-housing-package',
  '수원시 청년 주거 패키지 지원',
  '수원시가 청년의 월세·이사비·중개보수비를 함께 지원하는 주거비 패키지 사업입니다.',
  r.id, c.id,
  '수원시에 거주하는 청년이 대상입니다. 정확한 연령·소득 기준은 수원시청 공고문을 통해 확인해야 합니다.',
  '1인당 최대 100만원을 지원합니다. 월 임차료는 10만원씩 최장 5개월(최대 50만원), 이사비·중개보수비는 최대 50만원까지 실비로 지원됩니다.',
  '수원시청 홈페이지에서 온라인으로 신청한 뒤, 자격 요건 증빙 서류를 이메일로 제출합니다.',
  array['임대차계약서', '이사비·중개보수비 영수증', '주민등록등본'],
  array['월세 지원과 이사비 지원 한도가 각각 다르니 헷갈리지 마세요', '서류는 이메일로 별도 제출해야 합니다'],
  '[]'::jsonb,
  '수원시청소년청년재단', 'https://www.suwon.go.kr/',
  null, null, null, '무관',
  null, null, true,
  '수원시 공고 및 언론 보도 기준 정리', current_date, true,
  'suwon-youth-housing-package', 2026, true
from regions r, categories c
where r.slug = 'gyeonggi-suwon' and c.slug = 'housing'
on conflict (slug) do nothing;
