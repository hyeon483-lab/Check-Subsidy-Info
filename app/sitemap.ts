import type { MetadataRoute } from "next";
import { getAllBenefitsMeta, getCategories, getRegions } from "@/lib/data";
import { siteUrl } from "@/lib/site";
import { locales, defaultLocale, localeHtmlLang, type Locale } from "@/lib/i18n/config";
import { localizedHref } from "@/lib/i18n/href";

interface RouteEntry {
  path: string;
  changeFrequency: MetadataRoute.Sitemap[number]["changeFrequency"];
  priority: number;
  lastModified?: string;
}

function buildEntries(route: RouteEntry): MetadataRoute.Sitemap {
  const languages: Record<string, string> = {};
  for (const locale of locales) {
    languages[localeHtmlLang[locale]] = `${siteUrl}${localizedHref(route.path, locale)}`;
  }
  languages["x-default"] = `${siteUrl}${localizedHref(route.path, defaultLocale)}`;

  return locales.map((locale: Locale) => ({
    url: `${siteUrl}${localizedHref(route.path, locale)}`,
    changeFrequency: route.changeFrequency,
    priority: route.priority,
    lastModified: route.lastModified,
    alternates: { languages },
  }));
}

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const [regions, categories, benefitsMeta] = await Promise.all([
    getRegions(),
    getCategories(),
    getAllBenefitsMeta(),
  ]);

  const staticRoutes: RouteEntry[] = [
    { path: "/", changeFrequency: "daily", priority: 1 },
    { path: "/finder", changeFrequency: "monthly", priority: 0.5 },
    { path: "/median-income", changeFrequency: "yearly", priority: 0.4 },
    { path: "/about", changeFrequency: "monthly", priority: 0.3 },
    { path: "/privacy", changeFrequency: "yearly", priority: 0.1 },
    { path: "/terms", changeFrequency: "yearly", priority: 0.1 },
    { path: "/contact", changeFrequency: "yearly", priority: 0.1 },
  ];

  const regionRoutes: RouteEntry[] = regions.map((r) => ({
    path: `/region/${r.slug}`,
    changeFrequency: "weekly",
    priority: 0.6,
  }));

  const categoryRoutes: RouteEntry[] = categories.map((c) => ({
    path: `/category/${c.slug}`,
    changeFrequency: "weekly",
    priority: 0.6,
  }));

  const benefitRoutes: RouteEntry[] = benefitsMeta.map((b) => ({
    path: `/benefits/${b.slug}`,
    lastModified: b.updatedAt ?? undefined,
    changeFrequency: "weekly",
    priority: 0.8,
  }));

  return [...staticRoutes, ...regionRoutes, ...categoryRoutes, ...benefitRoutes].flatMap(buildEntries);
}
