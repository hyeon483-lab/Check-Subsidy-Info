import { getBenefits, getCategories, getRegions } from "@/lib/data";
import { paginate } from "@/lib/paginate";
import FilterBar from "@/components/FilterBar";
import BenefitCard from "@/components/BenefitCard";
import Pagination from "@/components/Pagination";

export const revalidate = 3600;

export default async function HomePage({
  searchParams,
}: {
  searchParams: Promise<{ region?: string; category?: string; page?: string }>;
}) {
  const { region, category, page } = await searchParams;
  const [regions, categories, benefits] = await Promise.all([
    getRegions(),
    getCategories(),
    getBenefits({ regionSlug: region, categorySlug: category }),
  ]);
  const { items, currentPage, totalPages } = paginate(benefits, Number(page) || 1);

  return (
    <div>
      <section className="border-b border-slate-200 bg-gradient-to-b from-brand-50/70 via-white to-white">
        <div className="mx-auto max-w-5xl px-4 pb-10 pt-14 text-center sm:px-6 sm:pt-20">
          <span className="mb-4 inline-block rounded-full bg-white px-3 py-1 text-xs font-semibold text-brand-700 ring-1 ring-inset ring-brand-100">
            지역별 · 생애주기별 지원금 정보
          </span>
          <h1 className="mx-auto mb-3 max-w-2xl text-3xl font-bold leading-tight tracking-tight text-slate-900 sm:text-4xl">
            우리 동네 지원금,
            <br />
            한눈에 찾아보세요
          </h1>
          <p className="mx-auto max-w-xl text-[15px] leading-relaxed text-slate-500">
            결혼, 출산·육아, 청년, 주거 등 생애 이벤트에 맞는 정부·지자체 지원금과 혜택을 지역별로 정리했습니다.
          </p>
        </div>
      </section>

      <div className="mx-auto max-w-5xl px-4 py-10 sm:px-6">
        <div className="mb-8 rounded-2xl bg-white p-5 shadow-card ring-1 ring-slate-100 sm:-mt-6">
          <FilterBar
            regions={regions}
            categories={categories}
            activeRegionSlug={region}
            activeCategorySlug={category}
          />
        </div>

        {benefits.length === 0 ? (
          <p className="rounded-2xl border border-dashed border-slate-300 bg-white p-10 text-center text-sm text-slate-500">
            조건에 맞는 지원금이 아직 등록되지 않았습니다.
          </p>
        ) : (
          <>
            <div className="grid gap-4 sm:grid-cols-2">
              {items.map((benefit) => (
                <BenefitCard key={benefit.id} benefit={benefit} />
              ))}
            </div>
            <Pagination
              currentPage={currentPage}
              totalPages={totalPages}
              basePath="/"
              searchParams={{ region, category }}
            />
          </>
        )}
      </div>
    </div>
  );
}
