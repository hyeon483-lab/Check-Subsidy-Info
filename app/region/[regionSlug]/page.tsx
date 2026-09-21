import { notFound } from "next/navigation";
import type { Metadata } from "next";
import { getBenefits, getCategories, getRegionBySlug, getRegions } from "@/lib/data";
import FilterBar from "@/components/FilterBar";
import BenefitCard from "@/components/BenefitCard";

export const revalidate = 3600;

export async function generateStaticParams() {
  const regions = await getRegions();
  return regions.map((r) => ({ regionSlug: r.slug }));
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ regionSlug: string }>;
}): Promise<Metadata> {
  const { regionSlug } = await params;
  const region = await getRegionBySlug(regionSlug);
  if (!region) return {};
  return {
    title: `${region.name} 지원금·혜택 모음`,
    description: `${region.name}에서 받을 수 있는 정부·지자체 지원금과 혜택을 정리했습니다.`,
  };
}

export default async function RegionPage({ params }: { params: Promise<{ regionSlug: string }> }) {
  const { regionSlug } = await params;
  const region = await getRegionBySlug(regionSlug);
  if (!region) notFound();

  const [regions, categories, benefits] = await Promise.all([
    getRegions(),
    getCategories(),
    getBenefits({ regionSlug }),
  ]);

  return (
    <div className="mx-auto max-w-5xl px-4 py-10">
      <h1 className="mb-2 text-2xl font-bold text-gray-900 md:text-3xl">{region.name} 지원금·혜택</h1>
      <p className="mb-8 text-gray-600">
        {region.name}에서 신청할 수 있는 지원 제도를 카테고리별로 확인하세요.
      </p>

      <FilterBar regions={regions} categories={categories} activeRegionSlug={region.slug} />

      {benefits.length === 0 ? (
        <p className="rounded-lg border border-dashed border-gray-300 p-8 text-center text-gray-500">
          {region.name}에 등록된 지원금이 아직 없습니다.
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
