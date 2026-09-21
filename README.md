# Check-Subsidy-Info · 내 지원금 찾기

지역(시/도, 시/군/구)과 생애 이벤트(결혼, 출산·육아, 청년, 주거) 기준으로
정부·지자체 지원금과 혜택을 찾아볼 수 있는 정보 사이트입니다. Google AdSense 수익화를 목표로 합니다.

## 스택

- **프론트엔드**: Next.js 14 (App Router) + TypeScript + Tailwind CSS
- **호스팅**: Vercel (개발 중에는 `*.vercel.app`, 이후 커스텀 도메인으로 전환)
- **DB**: Supabase (Postgres + RLS)
- **광고**: Google AdSense (도메인 연결 및 콘텐츠 확보 후 신청)

## 로컬 개발

```bash
npm install
cp .env.example .env.local   # Supabase 값이 없어도 실행 가능 (아래 참고)
npm run dev
```

`.env.local`에 `NEXT_PUBLIC_SUPABASE_URL` / `NEXT_PUBLIC_SUPABASE_ANON_KEY`를 넣지 않으면
`lib/seedData.ts`의 예시 데이터로 동작합니다. Supabase를 연결하면 자동으로 DB 데이터를 사용합니다.
(`lib/data.ts`가 이 분기를 처리합니다.)

## Supabase 연결하기

1. Supabase 프로젝트를 생성합니다.
2. `supabase/migrations/0001_init.sql`을 SQL Editor(또는 Supabase CLI)로 실행해 스키마를 만듭니다.
3. 필요하면 `supabase/seed.sql`을 실행해 예시 데이터를 넣어봅니다.
   - **주의**: `seed.sql`의 지원금 정보는 UI 확인용 예시이며 실제 데이터가 아닙니다.
     실서비스 전에 공공데이터포털의 "지자체복지서비스" API 등 검증된 출처로 교체하세요.
4. Project Settings → API에서 URL과 anon key를 복사해 Vercel 환경변수 및 `.env.local`에 설정합니다.
5. `supabase/migrations`를 저장소에 계속 커밋해 스키마 변경 이력을 Git으로 관리합니다.

## Vercel 배포 & 도메인 전환

1. 이 GitHub 저장소를 Vercel 프로젝트로 Import 합니다. `main` 브랜치 → Production, 그 외 브랜치/PR → Preview로 자동 배포됩니다.
2. Vercel 프로젝트 설정에 아래 환경변수를 등록합니다.
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - `NEXT_PUBLIC_SITE_URL` (개발 중엔 `https://<project>.vercel.app`)
   - `NEXT_PUBLIC_ADSENSE_CLIENT_ID` (AdSense 승인 후 발급되는 `ca-pub-...` 값)
3. 커스텀 도메인을 구입하면 Vercel의 Domains 설정에서 연결하고, `NEXT_PUBLIC_SITE_URL`을 새 도메인으로 업데이트합니다.
4. 도메인 전환 시:
   - Supabase Auth를 나중에 추가한다면 Redirect URL을 새 도메인으로 갱신해야 합니다.
   - 이전 `vercel.app` 주소에서 새 도메인으로 검색엔진이 갈아탈 수 있도록 리다이렉트를 고려하세요.

## AdSense 신청 전 체크리스트

- [ ] 커스텀 도메인 연결 완료 (`vercel.app` 서브도메인 상태에서는 신청하지 않기)
- [ ] `app/about`, `app/privacy`, `app/terms`, `app/contact`에 실질적인 텍스트 보강
- [ ] 지원금 상세 콘텐츠를 최소 15~20건 이상 확보 (공공데이터 가공 + 체크리스트/FAQ 자체 작성)
- [ ] `public/ads.txt`를 실제 publisher id로 교체
- [ ] `app/sitemap.ts`, `app/robots.ts`가 정상 노출되는지 확인 후 Google Search Console에 등록
- [ ] 서버 렌더링(SSG/ISR)로 콘텐츠가 크롤러에 텍스트로 보이는지 확인 (`view-source:` 로 점검)

## 폴더 구조

```
app/                  # Next.js App Router 페이지
  region/[regionSlug]/     지역별 목록
  category/[categorySlug]/ 카테고리별 목록
  benefits/[slug]/         지원금 상세
  about, privacy, terms, contact
  sitemap.ts, robots.ts
components/           # UI 컴포넌트
lib/
  types.ts             # 도메인 타입
  supabase.ts          # Supabase 클라이언트 (env 없으면 null)
  data.ts              # 데이터 조회 (Supabase 우선, 없으면 seedData로 폴백)
  seedData.ts           # 로컬 예시 데이터 (supabase/seed.sql과 동일 내용)
supabase/
  migrations/0001_init.sql  # 스키마 (regions, categories, benefits)
  seed.sql                  # 예시 시드 데이터
```

## 데이터 관련 유의사항

- `benefits` 테이블의 각 레코드는 원문 공공데이터를 그대로 복사하지 않고, 쉬운 말 요약·체크리스트·FAQ를
  직접 가공해서 넣는 것을 전제로 설계했습니다. (`eligibility`, `checklist`, `faq` 컬럼)
- 신청 기간이 지난 지원금이 계속 노출되지 않도록 `application_end_date` / `is_ongoing` 값을 주기적으로
  갱신하는 배치(예: Vercel Cron 또는 Supabase Edge Function)를 추후 추가하는 것을 권장합니다.
- 이용자의 나이, 소득 등 개인 조건은 서버에 저장하지 않고 브라우저에서만 필터링하는 방식을 유지하세요.
