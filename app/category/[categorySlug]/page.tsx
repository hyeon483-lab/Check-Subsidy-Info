import { notFound } from "next/navigation";
import type { Metadata } from "next";
import { getBenefits, getCategories, getCategoryBySlug, getRegions } from "@/lib/data";
import FilterBar from "@/components/FilterBar";
import BenefitCard from "@/components/BenefitCard";

export const revalidate = 3600;

export async function generateStaticParams() {
  const categories = await getCategories();
  return categories.map((c) => ({ categorySlug: c.slug }));
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ categorySlug: string }>;
}): Promise<Metadata> {
  const { categorySlug } = await params;
  const category = await getCategoryBySlug(categorySlug);
  if (!category) return {};
  return {
    title: `${category.name} 지원금·혜택 모음`,
    description: category.description ?? `${category.name} 관련 지원 제도를 정리했습니다.`,
  };
}

export default async function CategoryPage({ params }: { params: Promise<{ categorySlug: string }> }) {
  const { categorySlug } = await params;
  const category = await getCategoryBySlug(categorySlug);
  if (!category) notFound();

  const [regions, categories, benefits] = await Promise.all([
    getRegions(),
    getCategories(),
    getBenefits({ categorySlug }),
  ]);

  return (
    <div className="mx-auto max-w-5xl px-4 py-10">
      <h1 className="mb-2 text-2xl font-bold text-gray-900 md:text-3xl">{category.name} 지원금·혜택</h1>
      {category.description && <p className="mb-8 text-gray-600">{category.description}</p>}

      <FilterBar regions={regions} categories={categories} activeCategorySlug={category.slug} />

      {benefits.length === 0 ? (
        <p className="rounded-lg border border-dashed border-gray-300 p-8 text-center text-gray-500">
          등록된 지원금이 아직 없습니다.
        </p>
      ) : (
        <div className="grid gap-4 sm:grid-cols-2">
          {benefits.map((benefit) => (
            <BenefitCard key={benefit.id} benefit={benefit} />
          ))}
        </div>
      )}
    </div>
  );
}
