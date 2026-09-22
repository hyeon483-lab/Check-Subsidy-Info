import { notFound } from "next/navigation";
import type { Metadata } from "next";
import { getBenefits, getCategories, getRegionBySlug, getRegions } from "@/lib/data";
import FilterBar from "@/components/FilterBar";
import BenefitCard from "@/components/BenefitCard";
import { RegionIcon } from "@/components/icons";
import { siteUrl } from "@/lib/site";

// Supabase의 데이터가 DB에 반영되는 즉시(재배포 없이) 사이트에 나타나도록
// 빌드 시점에 굳히는 정적 생성 대신 매 요청마다 새로 렌더링합니다.
export const dynamic = "force-dynamic";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ regionSlug: string }>;
}): Promise<Metadata> {
  const { regionSlug } = await params;
  const region = await getRegionBySlug(regionSlug);
  if (!region) return {};
  const title = `${region.name} 지원금·혜택 모음`;
  const description = `${region.name}에서 받을 수 있는 정부·지자체 지원금과 혜택을 정리했습니다.`;
  const url = `${siteUrl}/region/${region.slug}`;
  return {
    title,
    description,
    alternates: { canonical: url },
    openGraph: { title, description, url },
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
    <div>
      <section className="border-b border-slate-200 bg-gradient-to-b from-brand-50/70 via-white to-white">
        <div className="mx-auto max-w-5xl px-4 pb-10 pt-12 sm:px-6 sm:pt-16">
          <span className="mb-3 inline-flex items-center gap-1.5 rounded-full bg-white px-3 py-1 text-xs font-semibold text-brand-700 ring-1 ring-inset ring-brand-100">
            <RegionIcon className="h-3.5 w-3.5" />
            지역별 지원금
          </span>
          <h1 className="mb-2 text-2xl font-bold tracking-tight text-slate-900 sm:text-3xl">{region.name} 지원금·혜택</h1>
          <p className="text-[15px] text-slate-500">
            {region.name}에서 신청할 수 있는 지원 제도를 카테고리별로 확인하세요.
          </p>
        </div>
      </section>

      <div className="mx-auto max-w-5xl px-4 py-10 sm:px-6">
        <div className="mb-8 rounded-2xl bg-white p-5 shadow-card ring-1 ring-slate-100">
          <FilterBar regions={regions} categories={categories} activeRegionSlug={region.slug} />
        </div>

        {benefits.length === 0 ? (
          <p className="rounded-2xl border border-dashed border-slate-300 bg-white p-10 text-center text-sm text-slate-500">
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
    </div>
  );
}
