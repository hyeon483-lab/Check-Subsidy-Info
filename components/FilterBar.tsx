import Link from "next/link";
import { Category, Region } from "@/lib/types";

export default function FilterBar({
  regions,
  categories,
  activeRegionSlug,
  activeCategorySlug,
}: {
  regions: Region[];
  categories: Category[];
  activeRegionSlug?: string;
  activeCategorySlug?: string;
}) {
  const sidoRegions = regions.filter((r) => r.level === "sido");

  function buildHref(regionSlug?: string, categorySlug?: string) {
    const params = new URLSearchParams();
    if (regionSlug) params.set("region", regionSlug);
    if (categorySlug) params.set("category", categorySlug);
    const qs = params.toString();
    return qs ? `/?${qs}` : "/";
  }

  return (
    <div className="mb-8 space-y-3">
      <div className="flex flex-wrap gap-2">
        <Link
          href={buildHref(undefined, activeCategorySlug)}
          className={`rounded-full border px-3 py-1 text-sm ${
            !activeRegionSlug ? "border-brand-500 bg-brand-50 text-brand-700" : "border-gray-200 text-gray-600"
          }`}
        >
          전체 지역
        </Link>
        {sidoRegions.map((region) => (
          <Link
            key={region.id}
            href={buildHref(region.slug, activeCategorySlug)}
            className={`rounded-full border px-3 py-1 text-sm ${
              activeRegionSlug === region.slug
                ? "border-brand-500 bg-brand-50 text-brand-700"
                : "border-gray-200 text-gray-600"
            }`}
          >
            {region.name}
          </Link>
        ))}
      </div>
      <div className="flex flex-wrap gap-2">
        <Link
          href={buildHref(activeRegionSlug, undefined)}
          className={`rounded-full border px-3 py-1 text-sm ${
            !activeCategorySlug ? "border-brand-500 bg-brand-50 text-brand-700" : "border-gray-200 text-gray-600"
          }`}
        >
          전체 카테고리
        </Link>
        {categories.map((category) => (
          <Link
            key={category.id}
            href={buildHref(activeRegionSlug, category.slug)}
            className={`rounded-full border px-3 py-1 text-sm ${
              activeCategorySlug === category.slug
                ? "border-brand-500 bg-brand-50 text-brand-700"
                : "border-gray-200 text-gray-600"
            }`}
          >
            {category.name}
          </Link>
        ))}
      </div>
    </div>
  );
}
