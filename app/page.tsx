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
import { getLocale } from "@/lib/i18n/getLocale";
import { getDictionary } from "@/lib/i18n/dictionaries";
import { localizeBenefits, localizeCategories, localizeRegions } from "@/lib/i18n/localize";
import { localizedHref } from "@/lib/i18n/href";
import { localeAlternates } from "@/lib/i18n/metadata";

export const dynamic = "force-dynamic";

type HomeSearchParams = { region?: string; category?: string; page?: string };

export async function generateMetadata({
  searchParams,
}: {
  searchParams: Promise<HomeSearchParams>;
}): Promise<Metadata> {
  const { region, category, page } = await searchParams;
  const locale = await getLocale();
  const dict = getDictionary(locale);
  const benefits = await getBenefits({ regionSlug: region, categorySlug: category });
  const { currentPage } = paginate(benefits, Number(page) || 1);
  const url = `${siteUrl}${localizedHref("/", locale)}`;
  return {
    title: dict.home.metaTitle,
    description: dict.home.metaDescription,
    openGraph: { title: dict.home.metaTitle, description: dict.home.metaDescription, url },
    ...paginationMetadata(localizedHref("/", locale), { region, category }, currentPage, localeAlternates("/")),
  };
}

export default async function HomePage({
  searchParams,
}: {
  searchParams: Promise<HomeSearchParams>;
}) {
  const { region, category, page } = await searchParams;
  const locale = await getLocale();
  const dict = getDictionary(locale);
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

  const localizedRegions = localizeRegions(regions, locale);
  const localizedCategories = localizeCategories(categories, locale);
  const localizedCategoriesWithCount = localizeCategories(categoriesWithCount, locale).map((c, i) => ({
    ...c,
    count: categoriesWithCount[i].count,
  }));
  const localizedItems = localizeBenefits(items, locale);

  return (
    <div>
      <section className="border-b border-slate-200 bg-gradient-to-b from-brand-50/70 via-white to-white">
        <div className="mx-auto max-w-5xl px-4 pb-10 pt-14 text-center sm:px-6 sm:pt-20">
          <span className="mb-4 inline-block rounded-full bg-white px-3 py-1 text-xs font-semibold text-brand-700 ring-1 ring-inset ring-brand-100">
            {dict.home.eyebrow}
          </span>
          <h1 className="mx-auto mb-3 max-w-2xl text-3xl font-bold leading-tight tracking-tight text-slate-900 sm:text-4xl">
            {dict.home.heroTitleLine1}
            <br />
            {dict.home.heroTitleLine2}
          </h1>
          <p className="mx-auto max-w-xl text-[15px] leading-relaxed text-slate-500">{dict.home.heroDescription}</p>
        </div>
      </section>

      <div className="mx-auto max-w-5xl px-4 py-10 sm:px-6">
        <div className="mb-12">
          <ToolsShowcase dict={dict} locale={locale} />
        </div>

        <RecentlyViewedSection dict={dict} locale={locale} />

        <div className="mb-12">
          <CategoryGrid categories={localizedCategoriesWithCount} dict={dict} locale={locale} />
        </div>

        <div id="benefits-list" className="mb-8 scroll-mt-20 rounded-2xl bg-white p-5 shadow-card ring-1 ring-slate-100">
          <FilterBar
            regions={localizedRegions}
            categories={localizedCategories}
            activeRegionSlug={region}
            activeCategorySlug={category}
            dict={dict}
            locale={locale}
          />
        </div>

        {benefits.length === 0 ? (
          <p className="rounded-2xl border border-dashed border-slate-300 bg-white p-10 text-center text-sm text-slate-500">
            {dict.home.filterEmpty}
          </p>
        ) : (
          <>
            <div className="grid gap-4 sm:grid-cols-2">
              {localizedItems.map((benefit) => (
                <BenefitCard key={benefit.id} benefit={benefit} dict={dict} locale={locale} />
              ))}
            </div>
            <AdSlot slot={process.env.NEXT_PUBLIC_ADSENSE_SLOT_LISTING} className="mt-6" />
            <Pagination
              currentPage={currentPage}
              totalPages={totalPages}
              basePath={localizedHref("/", locale)}
              searchParams={{ region, category }}
              dict={dict}
            />
          </>
        )}

        <div className="mt-16">
          <HomeIntro dict={dict} locale={locale} />
          <OfficialLinks dict={dict} />
        </div>
      </div>
    </div>
  );
}
