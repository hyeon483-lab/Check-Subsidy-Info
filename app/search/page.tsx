import type { Metadata } from "next";
import { getBenefits } from "@/lib/data";
import { Benefit } from "@/lib/types";
import { paginate } from "@/lib/paginate";
import BenefitCard from "@/components/BenefitCard";
import SearchBox from "@/components/SearchBox";
import Pagination from "@/components/Pagination";
import { siteUrl } from "@/lib/site";

// 검색 결과 페이지는 입력값에 따라 내용이 계속 바뀌는 데다, 중복/저가치 콘텐츠로
// 오인될 수 있어 색인에서는 제외하고(noindex) 내부 탐색 용도로만 사용합니다.
export const dynamic = "force-dynamic";

export async function generateMetadata({
  searchParams,
}: {
  searchParams: Promise<{ q?: string }>;
}): Promise<Metadata> {
  const { q } = await searchParams;
  const query = (q ?? "").trim();
  const title = query ? `"${query}" 검색 결과` : "지원금 검색";
  return {
    title,
    alternates: { canonical: `${siteUrl}/search` },
    robots: { index: false, follow: true },
  };
}

function matchesQuery(benefit: Benefit, query: string) {
  const haystack = [
    benefit.title,
    benefit.summary,
    benefit.eligibility,
    benefit.region?.name,
    benefit.category?.name,
    benefit.agency_name,
  ]
    .filter(Boolean)
    .join(" ")
    .toLowerCase();

  return query
    .toLowerCase()
    .split(/\s+/)
    .filter(Boolean)
    .every((term) => haystack.includes(term));
}

export default async function SearchPage({
  searchParams,
}: {
  searchParams: Promise<{ q?: string; page?: string }>;
}) {
  const { q, page } = await searchParams;
  const query = (q ?? "").trim();
  const allBenefits = query ? await getBenefits({}) : [];
  const results = query ? allBenefits.filter((b) => matchesQuery(b, query)) : [];
  const { items, currentPage, totalPages } = paginate(results, Number(page) || 1);

  return (
    <div>
      <section className="border-b border-slate-200 bg-gradient-to-b from-brand-50/70 via-white to-white">
        <div className="mx-auto max-w-3xl px-4 pb-10 pt-12 sm:px-6 sm:pt-16">
          <h1 className="mb-4 text-2xl font-bold tracking-tight text-slate-900 sm:text-3xl">지원금 검색</h1>
          <SearchBox defaultValue={query} />
        </div>
      </section>

      <div className="mx-auto max-w-5xl px-4 py-10 sm:px-6">
        {!query ? (
          <p className="rounded-2xl border border-dashed border-slate-300 bg-white p-10 text-center text-sm text-slate-500">
            찾고 싶은 지원금, 지역, 제도명을 입력해보세요. (예: 청년월세, 서울, 출산장려금)
          </p>
        ) : results.length === 0 ? (
          <p className="rounded-2xl border border-dashed border-slate-300 bg-white p-10 text-center text-sm text-slate-500">
            &ldquo;{query}&rdquo;에 대한 검색 결과가 없습니다. 다른 검색어나 지역명을 입력해보세요.
          </p>
        ) : (
          <>
            <p className="mb-4 text-sm text-slate-500">
              &ldquo;{query}&rdquo; 검색 결과 <span className="font-semibold text-slate-700">{results.length}건</span>
            </p>
            <div className="grid gap-4 sm:grid-cols-2">
              {items.map((benefit) => (
                <BenefitCard key={benefit.id} benefit={benefit} />
              ))}
            </div>
            <Pagination currentPage={currentPage} totalPages={totalPages} basePath="/search" searchParams={{ q: query }} />
          </>
        )}
      </div>
    </div>
  );
}
