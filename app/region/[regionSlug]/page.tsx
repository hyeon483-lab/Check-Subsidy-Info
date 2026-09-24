import { notFound } from "next/navigation";
import type { Metadata } from "next";
import { getBenefits, getCategories, getRegionBySlug, getRegions } from "@/lib/data";
import { paginate } from "@/lib/paginate";
import { paginationMetadata } from "@/lib/paginationMeta";
import FilterBar from "@/components/FilterBar";
import BenefitCard from "@/components/BenefitCard";
import Pagination from "@/components/Pagination";
import AdSlot from "@/components/AdSlot";
import { RegionIcon } from "@/components/icons";
import { siteUrl } from "@/lib/site";
import { getLocale } from "@/lib/i18n/getLocale";
import { getDictionary } from "@/lib/i18n/dictionaries";
import { localizeBenefits, localizeCategories, localizeRegion, localizeRegions } from "@/lib/i18n/localize";
import { localizedHref } from "@/lib/i18n/href";
import { localeAlternates } from "@/lib/i18n/metadata";

// Supabase의 데이터가 DB에 반영되는 즉시(재배포 없이) 사이트에 나타나도록
// 빌드 시점에 굳히는 정적 생성 대신 매 요청마다 새로 렌더링합니다.
export const dynamic = "force-dynamic";

export async function generateMetadata({
  params,
  searchParams,
}: {
  params: Promise<{ regionSlug: string }>;
  searchParams: Promise<{ page?: string }>;
}): Promise<Metadata> {
  const { regionSlug } = await params;
  const { page } = await searchParams;
  const locale = await getLocale();
  const dict = getDictionary(locale);
  const region = await getRegionBySlug(regionSlug);
  if (!region) return {};
  const localizedRegion = localizeRegion(region, locale);
  const title = `${localizedRegion.name} ${dict.region.titleSuffix}`;
  const description = `${localizedRegion.name}${dict.region.description}`;
  const benefits = await getBenefits({ regionSlug });
  const { currentPage } = paginate(benefits, Number(page) || 1);
  const path = localizedHref(`/region/${region.slug}`, locale);
  return {
    title,
    description,
    openGraph: { title, description, url: `${siteUrl}${path}` },
    ...paginationMetadata(path, {}, currentPage, localeAlternates(`/region/${region.slug}`)),
  };
}

export default async function RegionPage({
  params,
  searchParams,
}: {
  params: Promise<{ regionSlug: string }>;
  searchParams: Promise<{ page?: string }>;
}) {
  const { regionSlug } = await params;
  const { page } = await searchParams;
  const locale = await getLocale();
  const dict = getDictionary(locale);
  const region = await getRegionBySlug(regionSlug);
  if (!region) notFound();

  const [regions, categories, benefits] = await Promise.all([
    getRegions(),
    getCategories(),
    getBenefits({ regionSlug }),
  ]);
  const { items, currentPage, totalPages } = paginate(benefits, Number(page) || 1);
  const localizedRegion = localizeRegion(region, locale);

  return (
    <div>
      <section className="border-b border-slate-200 bg-gradient-to-b from-brand-50/70 via-white to-white">
        <div className="mx-auto max-w-5xl px-4 pb-10 pt-12 sm:px-6 sm:pt-16">
          <span className="mb-3 inline-flex items-center gap-1.5 rounded-full bg-white px-3 py-1 text-xs font-semibold text-brand-700 ring-1 ring-inset ring-brand-100">
            <RegionIcon className="h-3.5 w-3.5" />
            {dict.region.badgeLabel}
          </span>
          <h1 className="mb-2 text-2xl font-bold tracking-tight text-slate-900 sm:text-3xl">
            {localizedRegion.name} {dict.region.titleSuffix}
          </h1>
          <p className="text-[15px] text-slate-500">
            {localizedRegion.name}
            {dict.region.description}
          </p>
        </div>
      </section>

      <div className="mx-auto max-w-5xl px-4 py-10 sm:px-6">
        <div className="mb-8 rounded-2xl bg-white p-5 shadow-card ring-1 ring-slate-100">
          <FilterBar
            regions={localizeRegions(regions, locale)}
            categories={localizeCategories(categories, locale)}
            activeRegionSlug={region.slug}
            dict={dict}
            locale={locale}
          />
        </div>

        {benefits.length === 0 ? (
          <p className="rounded-2xl border border-dashed border-slate-300 bg-white p-10 text-center text-sm text-slate-500">
            {dict.region.emptyListPrefix}
            {localizedRegion.name}
            {dict.region.emptyListSuffix}
          </p>
        ) : (
          <>
            <div className="grid gap-4 sm:grid-cols-2">
              {localizeBenefits(items, locale).map((benefit) => (
                <BenefitCard key={benefit.id} benefit={benefit} dict={dict} locale={locale} />
              ))}
            </div>
            <AdSlot slot={process.env.NEXT_PUBLIC_ADSENSE_SLOT_LISTING} className="mt-6" />
            <Pagination
              currentPage={currentPage}
              totalPages={totalPages}
              basePath={localizedHref(`/region/${region.slug}`, locale)}
              dict={dict}
            />
          </>
        )}
      </div>
    </div>
  );
}
