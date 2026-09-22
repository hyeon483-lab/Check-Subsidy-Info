import type { MetadataRoute } from "next";
import { getAllBenefitsMeta, getCategories, getRegions } from "@/lib/data";
import { siteUrl } from "@/lib/site";

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const [regions, categories, benefitsMeta] = await Promise.all([
    getRegions(),
    getCategories(),
    getAllBenefitsMeta(),
  ]);

  const staticRoutes: MetadataRoute.Sitemap = [
    { url: siteUrl, changeFrequency: "daily", priority: 1 },
    { url: `${siteUrl}/finder`, changeFrequency: "monthly", priority: 0.5 },
    { url: `${siteUrl}/about`, changeFrequency: "monthly", priority: 0.3 },
    { url: `${siteUrl}/privacy`, changeFrequency: "yearly", priority: 0.1 },
    { url: `${siteUrl}/terms`, changeFrequency: "yearly", priority: 0.1 },
    { url: `${siteUrl}/contact`, changeFrequency: "yearly", priority: 0.1 },
  ];

  const regionRoutes: MetadataRoute.Sitemap = regions.map((r) => ({
    url: `${siteUrl}/region/${r.slug}`,
    changeFrequency: "weekly",
    priority: 0.6,
  }));

  const categoryRoutes: MetadataRoute.Sitemap = categories.map((c) => ({
    url: `${siteUrl}/category/${c.slug}`,
    changeFrequency: "weekly",
    priority: 0.6,
  }));

  const benefitRoutes: MetadataRoute.Sitemap = benefitsMeta.map((b) => ({
    url: `${siteUrl}/benefits/${b.slug}`,
    lastModified: b.updatedAt ?? undefined,
    changeFrequency: "weekly",
    priority: 0.8,
  }));

  return [...staticRoutes, ...regionRoutes, ...categoryRoutes, ...benefitRoutes];
}
