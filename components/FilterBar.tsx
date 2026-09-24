import Link from "next/link";
import { Category, Region } from "@/lib/types";
import { getCategoryStyle } from "@/lib/categoryStyle";
import { RegionIcon } from "./icons";
import type { Dictionary } from "@/lib/i18n/dictionaryType";
import type { Locale } from "@/lib/i18n/config";
import { localizedHref } from "@/lib/i18n/href";

export default function FilterBar({
  regions,
  categories,
  activeRegionSlug,
  activeCategorySlug,
  dict,
  locale,
}: {
  regions: Region[];
  categories: Category[];
  activeRegionSlug?: string;
  activeCategorySlug?: string;
  dict: Dictionary;
  locale: Locale;
}) {
  const sidoRegions = regions.filter((r) => r.level === "sido");

  function buildHref(regionSlug?: string, categorySlug?: string) {
    const params = new URLSearchParams();
    if (regionSlug) params.set("region", regionSlug);
    if (categorySlug) params.set("category", categorySlug);
    const qs = params.toString();
    const base = localizedHref("/", locale);
    return qs ? `${base}?${qs}` : base;
  }

  return (
    <div className="space-y-4">
      <div>
        <p className="mb-2 flex items-center gap-1.5 text-xs font-semibold uppercase tracking-wide text-slate-400">
          <RegionIcon className="h-3.5 w-3.5" />
          {dict.filterBar.regionLabel}
        </p>
        <div className="flex flex-wrap gap-2">
          <Link
            href={buildHref(undefined, activeCategorySlug)}
            className={`rounded-full px-3.5 py-1.5 text-sm font-medium transition ${
              !activeRegionSlug
                ? "bg-brand-600 text-white shadow-sm"
                : "bg-white text-slate-600 ring-1 ring-inset ring-slate-200 hover:bg-slate-50"
            }`}
          >
            {dict.filterBar.allRegions}
          </Link>
          {sidoRegions.map((region) => (
            <Link
              key={region.id}
              href={buildHref(region.slug, activeCategorySlug)}
              className={`rounded-full px-3.5 py-1.5 text-sm font-medium transition ${
                activeRegionSlug === region.slug
                  ? "bg-brand-600 text-white shadow-sm"
                  : "bg-white text-slate-600 ring-1 ring-inset ring-slate-200 hover:bg-slate-50"
              }`}
            >
              {region.name}
            </Link>
          ))}
        </div>
      </div>

      <div>
        <p className="mb-2 text-xs font-semibold uppercase tracking-wide text-slate-400">{dict.filterBar.categoryLabel}</p>
        <div className="flex flex-wrap gap-2">
          <Link
            href={buildHref(activeRegionSlug, undefined)}
            className={`rounded-full px-3.5 py-1.5 text-sm font-medium transition ${
              !activeCategorySlug
                ? "bg-slate-900 text-white shadow-sm"
                : "bg-white text-slate-600 ring-1 ring-inset ring-slate-200 hover:bg-slate-50"
            }`}
          >
            {dict.filterBar.allCategories}
          </Link>
          {categories.map((category) => {
            const style = getCategoryStyle(category.slug);
            const Icon = style.icon;
            const active = activeCategorySlug === category.slug;
            return (
              <Link
                key={category.id}
                href={buildHref(activeRegionSlug, category.slug)}
                className={`inline-flex items-center gap-1.5 rounded-full px-3.5 py-1.5 text-sm font-medium transition ${
                  active
                    ? "bg-slate-900 text-white shadow-sm"
                    : "bg-white text-slate-600 ring-1 ring-inset ring-slate-200 hover:bg-slate-50"
                }`}
              >
                <Icon className={`h-3.5 w-3.5 ${active ? "text-white" : "text-slate-400"}`} />
                {category.name}
              </Link>
            );
          })}
        </div>
      </div>
    </div>
  );
}
