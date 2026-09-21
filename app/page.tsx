import { getBenefits, getCategories, getRegions } from "@/lib/data";
import FilterBar from "@/components/FilterBar";
import BenefitCard from "@/components/BenefitCard";

export const revalidate = 3600;

export default async function HomePage({
  searchParams,
}: {
  searchParams: Promise<{ region?: string; category?: string }>;
}) {
  const { region, category } = await searchParams;
  const [regions, categories, benefits] = await Promise.all([
    getRegions(),
    getCategories(),
    getBenefits({ regionSlug: region, categorySlug: category }),
  ]);

  return (
    <div className="mx-auto max-w-5xl px-4 py-10">
      <section className="mb-10">
        <h1 className="mb-2 text-2xl font-bold text-gray-900 md:text-3xl">
          우리 동네 지원금, 한눈에 찾아보세요
        </h1>
        <p className="text-gray-600">
          결혼, 출산·육아, 청년, 주거 등 생애 이벤트에 맞는 정부·지자체 지원금과 혜택을 지역별로 정리했습니다.
        </p>
      </section>

      <FilterBar
        regions={regions}
        categories={categories}
        activeRegionSlug={region}
        activeCategorySlug={category}
      />

      {benefits.length === 0 ? (
        <p className="rounded-lg border border-dashed border-gray-300 p-8 text-center text-gray-500">
          조건에 맞는 지원금이 아직 등록되지 않았습니다.
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
