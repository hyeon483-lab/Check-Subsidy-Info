import { notFound } from "next/navigation";
import type { Metadata } from "next";
import { getBenefits, getCategories, getCategoryBySlug, getRegions } from "@/lib/data";
import { paginate } from "@/lib/paginate";
import { paginationMetadata } from "@/lib/paginationMeta";
import FilterBar from "@/components/FilterBar";
import BenefitCard from "@/components/BenefitCard";
import Pagination from "@/components/Pagination";
import AdSlot from "@/components/AdSlot";
import { getCategoryStyle } from "@/lib/categoryStyle";
import { siteUrl } from "@/lib/site";
import { getLocale } from "@/lib/i18n/getLocale";
import { getDictionary } from "@/lib/i18n/dictionaries";
import { localizeBenefits, localizeCategories, localizeCategory, localizeRegions } from "@/lib/i18n/localize";

// Supabase의 데이터가 DB에 반영되는 즉시(재배포 없이) 사이트에 나타나도록
// 빌드 시점에 굳히는 정적 생성 대신 매 요청마다 새로 렌더링합니다.
export const dynamic = "force-dynamic";

export async function generateMetadata({
  params,
  searchParams,
}: {
  params: Promise<{ categorySlug: string }>;
  searchParams: Promise<{ page?: string }>;
}): Promise<Metadata> {
  const { categorySlug } = await params;
  const { page } = await searchParams;
  const locale = await getLocale();
  const dict = getDictionary(locale);
  const category = await getCategoryBySlug(categorySlug);
  if (!category) return {};
  const localizedCategory = localizeCategory(category, locale);
  const title = `${localizedCategory.name} ${dict.category.metaTitleSuffix}`;
  const description = localizedCategory.description ?? `${localizedCategory.name} ${dict.category.defaultDescriptionSuffix}`;
  const benefits = await getBenefits({ categorySlug });
  const { currentPage } = paginate(benefits, Number(page) || 1);
  return {
    title,
    description,
    openGraph: { title, description, url: `${siteUrl}/category/${category.slug}` },
    ...paginationMetadata(`/category/${category.slug}`, {}, currentPage),
  };
}

export default async function CategoryPage({
  params,
  searchParams,
}: {
  params: Promise<{ categorySlug: string }>;
  searchParams: Promise<{ page?: string }>;
}) {
  const { categorySlug } = await params;
  const { page } = await searchParams;
  const locale = await getLocale();
  const dict = getDictionary(locale);
  const category = await getCategoryBySlug(categorySlug);
  if (!category) notFound();

  const [regions, categories, benefits] = await Promise.all([
    getRegions(),
    getCategories(),
    getBenefits({ categorySlug }),
  ]);
  const { items, currentPage, totalPages } = paginate(benefits, Number(page) || 1);

  const style = getCategoryStyle(category.slug);
  const Icon = style.icon;
  const localizedCategory = localizeCategory(category, locale);

  return (
    <div>
      <section className="border-b border-slate-200 bg-gradient-to-b from-brand-50/70 via-white to-white">
        <div className="mx-auto max-w-5xl px-4 pb-10 pt-12 sm:px-6 sm:pt-16">
          <span
            className={`mb-3 inline-flex h-11 w-11 items-center justify-center rounded-xl ${style.iconWrap}`}
          >
            <Icon className="h-5 w-5" />
          </span>
          <h1 className="mb-2 text-2xl font-bold tracking-tight text-slate-900 sm:text-3xl">
            {localizedCategory.name} {dict.category.titleSuffix}
          </h1>
          {localizedCategory.description && <p className="text-[15px] text-slate-500">{localizedCategory.description}</p>}
        </div>
      </section>

      <div className="mx-auto max-w-5xl px-4 py-10 sm:px-6">
        <div className="mb-8 rounded-2xl bg-white p-5 shadow-card ring-1 ring-slate-100">
          <FilterBar
            regions={localizeRegions(regions, locale)}
            categories={localizeCategories(categories, locale)}
            activeCategorySlug={category.slug}
            dict={dict}
          />
        </div>

        {benefits.length === 0 ? (
          <p className="rounded-2xl border border-dashed border-slate-300 bg-white p-10 text-center text-sm text-slate-500">
            {dict.category.emptyList}
          </p>
        ) : (
          <>
            <div className="grid gap-4 sm:grid-cols-2">
              {localizeBenefits(items, locale).map((benefit) => (
                <BenefitCard key={benefit.id} benefit={benefit} dict={dict} />
              ))}
            </div>
            <AdSlot slot={process.env.NEXT_PUBLIC_ADSENSE_SLOT_LISTING} className="mt-6" />
            <Pagination currentPage={currentPage} totalPages={totalPages} basePath={`/category/${category.slug}`} dict={dict} />
          </>
        )}
      </div>
    </div>
  );
}
