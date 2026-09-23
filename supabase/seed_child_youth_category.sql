-- =============================================================================
-- "아동·청소년" 카테고리 신설 (6번째 생애주기 카테고리)
--
-- 출산·육아와 청년 사이(만 7~18세)를 채우는 카테고리입니다. 결혼(1)·출산·
-- 육아(2) 다음 순서(3)로 넣고, 기존 청년(3→4)·주거(4→5)·어르신(5→6)의
-- sort_order를 한 칸씩 밀었습니다.
-- =============================================================================

update categories set sort_order = 6 where slug = 'senior';
update categories set sort_order = 5 where slug = 'housing';
update categories set sort_order = 4 where slug = 'youth';

insert into categories (slug, name, description, sort_order) values
  ('child-youth', '아동·청소년', '만 7~18세 아동·청소년과 그 가정을 위한 지원 제도', 3)
on conflict (slug) do nothing;
