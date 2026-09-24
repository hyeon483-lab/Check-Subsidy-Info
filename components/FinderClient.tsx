"use client";

import { useMemo, useState } from "react";
import { Benefit, Category, Region } from "@/lib/types";
import BenefitCard from "./BenefitCard";
import type { Dictionary } from "@/lib/i18n/dictionaryType";
import type { Locale } from "@/lib/i18n/config";

const HOUSEHOLD_OPTIONS = ["전체", "1인가구", "신혼부부"] as const;

export default function FinderClient({
  benefits,
  regions,
  categories,
  dict,
  locale,
}: {
  benefits: Benefit[];
  regions: Region[];
  categories: Category[];
  dict: Dictionary;
  locale: Locale;
}) {
  const householdLabels: Record<(typeof HOUSEHOLD_OPTIONS)[number], string> = {
    전체: dict.finder.householdAll,
    "1인가구": dict.finder.householdSingle,
    신혼부부: dict.finder.householdNewlywed,
  };
  const sidoRegions = useMemo(
    () => regions.filter((r) => r.level === "sido").sort((a, b) => a.name.localeCompare(b.name, "ko")),
    [regions]
  );
  const sigunguRegions = useMemo(() => regions.filter((r) => r.level === "sigungu"), [regions]);

  const [regionSlug, setRegionSlug] = useState("");
  const [age, setAge] = useState("");
  const [household, setHousehold] = useState("전체");
  const [selectedCategories, setSelectedCategories] = useState<string[]>([]);
  const [submitted, setSubmitted] = useState(false);

  const selectedRegion = regions.find((r) => r.slug === regionSlug);

  const results = useMemo(() => {
    if (!submitted) return [];
    const ageNum = age.trim() ? Number(age) : null;

    return benefits.filter((benefit) => {
      if (selectedRegion) {
        const benefitRegion = benefit.region;
        const sameRegion = benefitRegion?.slug === selectedRegion.slug;
        const benefitIsChildOfSelected =
          selectedRegion.level === "sido" && benefitRegion?.parent_id === selectedRegion.id;
        const selectedIsChildOfBenefitRegion =
          benefitRegion?.level === "sido" && selectedRegion.parent_id === benefitRegion.id;
        if (!sameRegion && !benefitIsChildOfSelected && !selectedIsChildOfBenefitRegion) return false;
      }

      if (ageNum !== null) {
        if (benefit.age_min !== null && ageNum < benefit.age_min) return false;
        if (benefit.age_max !== null && ageNum > benefit.age_max) return false;
      }

      if (
        household !== "전체" &&
        benefit.household_type &&
        benefit.household_type !== "무관" &&
        benefit.household_type !== household
      ) {
        return false;
      }

      if (selectedCategories.length > 0 && benefit.category && !selectedCategories.includes(benefit.category.slug)) {
        return false;
      }

      return true;
    });
  }, [submitted, benefits, selectedRegion, age, household, selectedCategories]);

  function toggleCategory(slug: string) {
    setSelectedCategories((prev) => (prev.includes(slug) ? prev.filter((s) => s !== slug) : [...prev, slug]));
  }

  return (
    <div>
      <form
        onSubmit={(e) => {
          e.preventDefault();
          setSubmitted(true);
        }}
        className="space-y-5 rounded-2xl bg-white p-6 shadow-card ring-1 ring-slate-100"
      >
        <div>
          <label htmlFor="finder-region" className="mb-1.5 block text-sm font-semibold text-slate-700">
            {dict.finder.regionLabel}
          </label>
          <select
            id="finder-region"
            value={regionSlug}
            onChange={(e) => setRegionSlug(e.target.value)}
            className="w-full rounded-xl border border-slate-200 px-3 py-2.5 text-sm text-slate-700 focus:border-brand-400 focus:outline-none focus:ring-2 focus:ring-brand-100"
          >
            <option value="">{dict.finder.allRegions}</option>
            {sidoRegions.map((sido) => (
              <optgroup key={sido.id} label={sido.name}>
                <option value={sido.slug}>
                  {sido.name}
                  {dict.finder.regionAllSuffix}
                </option>
                {sigunguRegions
                  .filter((s) => s.parent_id === sido.id)
                  .map((s) => (
                    <option key={s.id} value={s.slug}>
                      {sido.name} {s.name}
                    </option>
                  ))}
              </optgroup>
            ))}
          </select>
        </div>

        <div>
          <label htmlFor="finder-age" className="mb-1.5 block text-sm font-semibold text-slate-700">
            {dict.finder.ageLabel}
          </label>
          <input
            id="finder-age"
            type="number"
            inputMode="numeric"
            min={0}
            max={110}
            value={age}
            onChange={(e) => setAge(e.target.value)}
            placeholder={dict.finder.agePlaceholder}
            className="w-full rounded-xl border border-slate-200 px-3 py-2.5 text-sm text-slate-700 focus:border-brand-400 focus:outline-none focus:ring-2 focus:ring-brand-100"
          />
        </div>

        <div>
          <p className="mb-1.5 text-sm font-semibold text-slate-700">{dict.finder.householdLabel}</p>
          <div className="flex flex-wrap gap-2">
            {HOUSEHOLD_OPTIONS.map((opt) => (
              <button
                type="button"
                key={opt}
                onClick={() => setHousehold(opt)}
                aria-pressed={household === opt}
                className={`rounded-full px-3.5 py-1.5 text-sm font-medium transition ${
                  household === opt
                    ? "bg-slate-900 text-white"
                    : "bg-white text-slate-600 ring-1 ring-inset ring-slate-200 hover:bg-slate-50"
                }`}
              >
                {householdLabels[opt]}
              </button>
            ))}
          </div>
        </div>

        <div>
          <p className="mb-1.5 text-sm font-semibold text-slate-700">{dict.finder.categoryLabel}</p>
          <div className="flex flex-wrap gap-2">
            {categories.map((category) => {
              const active = selectedCategories.includes(category.slug);
              return (
                <button
                  type="button"
                  key={category.id}
                  onClick={() => toggleCategory(category.slug)}
                  aria-pressed={active}
                  className={`rounded-full px-3.5 py-1.5 text-sm font-medium transition ${
                    active
                      ? "bg-brand-600 text-white"
                      : "bg-white text-slate-600 ring-1 ring-inset ring-slate-200 hover:bg-slate-50"
                  }`}
                >
                  {category.name}
                </button>
              );
            })}
          </div>
        </div>

        <button
          type="submit"
          className="w-full rounded-xl bg-brand-600 py-3 text-sm font-semibold text-white transition hover:bg-brand-700"
        >
          {dict.finder.submitButton}
        </button>
      </form>

      {submitted && (
        <div className="mt-8">
          <p className="mb-4 text-sm font-semibold text-slate-700">
            {dict.finder.resultsCountPrefix}
            {results.length}
            {dict.finder.resultsCountSuffix}
          </p>

          {results.length === 0 ? (
            <p className="rounded-2xl border border-dashed border-slate-300 bg-white p-10 text-center text-sm text-slate-500">
              {dict.finder.noResults}
            </p>
          ) : (
            <div className="grid gap-4 sm:grid-cols-2">
              {results.map((benefit) => (
                <BenefitCard key={benefit.id} benefit={benefit} dict={dict} locale={locale} />
              ))}
            </div>
          )}

          <p className="mt-6 rounded-xl bg-amber-50 p-4 text-xs leading-relaxed text-amber-800">
            {dict.finder.disclaimer}
          </p>
        </div>
      )}
    </div>
  );
}
