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
  const category = await getCategoryBySlug(categorySlug);
  if (!category) return {};
  const title = `${category.name} 지원금·혜택 모음`;
  const description = category.description ?? `${category.name} 관련 지원 제도를 정리했습니다.`;
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

  return (
    <div>
      <section className="border-b border-slate-200 bg-gradient-to-b from-brand-50/70 via-white to-white">
        <div className="mx-auto max-w-5xl px-4 pb-10 pt-12 sm:px-6 sm:pt-16">
          <span
            className={`mb-3 inline-flex h-11 w-11 items-center justify-center rounded-xl ${style.iconWrap}`}
          >
            <Icon className="h-5 w-5" />
          </span>
          <h1 className="mb-2 text-2xl font-bold tracking-tight text-slate-900 sm:text-3xl">{category.name} 지원금·혜택</h1>
          {category.description && <p className="text-[15px] text-slate-500">{category.description}</p>}
        </div>
      </section>

      <div className="mx-auto max-w-5xl px-4 py-10 sm:px-6">
        <div className="mb-8 rounded-2xl bg-white p-5 shadow-card ring-1 ring-slate-100">
          <FilterBar regions={regions} categories={categories} activeCategorySlug={category.slug} />
        </div>

        {benefits.length === 0 ? (
          <p className="rounded-2xl border border-dashed border-slate-300 bg-white p-10 text-center text-sm text-slate-500">
            등록된 지원금이 아직 없습니다.
          </p>
        ) : (
          <>
            <div className="grid gap-4 sm:grid-cols-2">
              {items.map((benefit) => (
                <BenefitCard key={benefit.id} benefit={benefit} />
              ))}
            </div>
            <AdSlot slot={process.env.NEXT_PUBLIC_ADSENSE_SLOT_LISTING} className="mt-6" />
            <Pagination currentPage={currentPage} totalPages={totalPages} basePath={`/category/${category.slug}`} />
          </>
        )}
      </div>
    </div>
  );
}
