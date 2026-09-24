import type { Benefit, Category, Region } from "../types";
import type { Locale } from "./config";
import { regionNames } from "./regionNames";
import { categoryNames } from "./categoryNames";
import { householdTypeTranslations, incomeConditionTranslations } from "./conditionTranslations";
import en from "./benefitTranslations/en";
import ja from "./benefitTranslations/ja";
import zh from "./benefitTranslations/zh";
import vi from "./benefitTranslations/vi";
import th from "./benefitTranslations/th";
import type { BenefitTranslationMap } from "./types";

const benefitTranslationsByLocale: Partial<Record<Locale, BenefitTranslationMap>> = { en, ja, zh, vi, th };

export function localizeRegion(region: Region, locale: Locale): Region {
  if (locale === "ko") return region;
  const name = regionNames[locale]?.[region.slug];
  return name ? { ...region, name } : region;
}

export function localizeCategory(category: Category, locale: Locale): Category {
  if (locale === "ko") return category;
  const translated = categoryNames[locale]?.[category.slug];
  if (!translated) return category;
  return { ...category, name: translated.name, description: translated.description };
}

export function localizeBenefit(benefit: Benefit, locale: Locale): Benefit {
  const localized: Benefit = {
    ...benefit,
    region: benefit.region ? localizeRegion(benefit.region, locale) : benefit.region,
    category: benefit.category ? localizeCategory(benefit.category, locale) : benefit.category,
  };

  if (locale === "ko") return localized;

  localized.income_condition = benefit.income_condition
    ? (incomeConditionTranslations[locale]?.[benefit.income_condition] ?? benefit.income_condition)
    : benefit.income_condition;
  localized.household_type = benefit.household_type
    ? (householdTypeTranslations[locale]?.[benefit.household_type] ?? benefit.household_type)
    : benefit.household_type;

  const translation = benefitTranslationsByLocale[locale]?.[benefit.slug];
  if (!translation) return localized;

  return {
    ...localized,
    title: translation.title,
    summary: translation.summary,
    eligibility: translation.eligibility,
    support_content: translation.support_content,
    application_method: translation.application_method,
    required_documents: translation.required_documents,
    checklist: translation.checklist,
    faq: translation.faq,
  };
}

export function localizeBenefits(benefits: Benefit[], locale: Locale): Benefit[] {
  return benefits.map((b) => localizeBenefit(b, locale));
}

export function localizeRegions(regions: Region[], locale: Locale): Region[] {
  return regions.map((r) => localizeRegion(r, locale));
}

export function localizeCategories(categories: Category[], locale: Locale): Category[] {
  return categories.map((c) => localizeCategory(c, locale));
}
