import type { MetadataRoute } from "next";
import { siteUrl } from "@/lib/site";
import { locales, defaultLocale } from "@/lib/i18n/config";
import { localizedHref } from "@/lib/i18n/href";

export default function robots(): MetadataRoute.Robots {
  return {
    rules: {
      userAgent: "*",
      allow: "/",
      disallow: locales.filter((l) => l !== defaultLocale).map((l) => localizedHref("/search", l)).concat("/search"),
    },
    sitemap: `${siteUrl}/sitemap.xml`,
  };
}
