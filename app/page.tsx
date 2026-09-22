import type { Metadata } from "next";
import { getBenefits, getCategories, getRegions } from "@/lib/data";
import { paginate } from "@/lib/paginate";
import { paginationMetadata } from "@/lib/paginationMeta";
import { siteUrl } from "@/lib/site";
import FilterBar from "@/components/FilterBar";
import BenefitCard from "@/components/BenefitCard";
import Pagination from "@/components/Pagination";
import AdSlot from "@/components/AdSlot";
import ToolsShowcase from "@/components/ToolsShowcase";
import CategoryGrid from "@/components/CategoryGrid";
import OfficialLinks from "@/components/OfficialLinks";
import RecentlyViewedSection from "@/components/RecentlyViewedSection";
import HomeIntro from "@/components/HomeIntro";

export const revalidate = 3600;

type HomeSearchParams = { region?: string; category?: string; page?: string };

const homeTitle = "내 지원금 찾기 | 지역별 정부·지자체 지원금 모음";
const homeDescription =
  "결혼, 출산, 청년, 주거 등 생애 이벤트와 지역별로 받을 수 있는 정부·지자체 지원금과 혜택을 쉽게 찾아보세요.";

export async function generateMetadata({
  searchParams,
}: {
  searchParams: Promise<HomeSearchParams>;
}): Promise<Metadata> {
  const { region, category, page } = await searchParams;
  const benefits = await getBenefits({ regionSlug: region, categorySlug: category });
  const { currentPage } = paginate(benefits, Number(page) || 1);
  return {
    title: homeTitle,
    description: homeDescription,
    openGraph: { title: homeTitle, description: homeDescription, url: siteUrl },
    ...paginationMetadata("/", { region, category }, currentPage),
  };
}

export default async function HomePage({
  searchParams,
}: {
  searchParams: Promise<HomeSearchParams>;
}) {
  const { region, category, page } = await searchParams;
  const [regions, categories, benefits, allBenefits] = await Promise.all([
    getRegions(),
    getCategories(),
    getBenefits({ regionSlug: region, categorySlug: category }),
    getBenefits({}),
  ]);
  const { items, currentPage, totalPages } = paginate(benefits, Number(page) || 1);

  const categoriesWithCount = categories.map((c) => ({
    ...c,
    count: allBenefits.filter((b) => b.category_id === c.id).length,
  }));

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
        <div className="mb-12">
          <ToolsShowcase />
        </div>

        <RecentlyViewedSection />

        <div className="mb-12">
          <CategoryGrid categories={categoriesWithCount} />
        </div>

        <div id="benefits-list" className="mb-8 scroll-mt-20 rounded-2xl bg-white p-5 shadow-card ring-1 ring-slate-100">
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
            <AdSlot slot={process.env.NEXT_PUBLIC_ADSENSE_SLOT_LISTING} className="mt-6" />
            <Pagination
              currentPage={currentPage}
              totalPages={totalPages}
              basePath="/"
              searchParams={{ region, category }}
            />
          </>
        )}

        <div className="mt-16">
          <HomeIntro />
          <OfficialLinks />
        </div>
      </div>
    </div>
  );
}
