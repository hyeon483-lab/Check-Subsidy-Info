import type { Metadata } from "next";
import { siteUrl } from "@/lib/site";
import { getDictionary } from "./dictionaries";
import { localeHtmlLang, type Locale } from "./config";

const openGraphLocaleMap: Record<Locale, string> = {
  ko: "ko_KR",
  en: "en_US",
  ja: "ja_JP",
  zh: "zh_CN",
  vi: "vi_VN",
  th: "th_TH",
};

/** Site-wide metadata shared by both root layouts ((ko) and [locale]), parameterized by locale. */
export function rootMetadata(locale: Locale): Metadata {
  const dict = getDictionary(locale);
  const siteName = dict.common.siteName;
  const title = dict.home.metaTitle;
  const description = dict.home.metaDescription;

  return {
    metadataBase: new URL(siteUrl),
    title: {
      default: title,
      template: `%s | ${siteName}`,
    },
    description,
    openGraph: {
      type: "website",
      locale: openGraphLocaleMap[locale],
      siteName,
      title,
      description,
      url: siteUrl,
    },
    twitter: {
      card: "summary_large_image",
      title,
      description,
    },
    alternates: {
      canonical: siteUrl,
    },
    verification: {
      google: "BQvPkZpqL9zX-337FYutBzWqyhFzooV81wrgc7jphug",
      other: {
        "naver-site-verification": "96b76c167d7750c2ddf961e8c06db7be595ac214",
      },
    },
  };
}

export function websiteJsonLd(locale: Locale) {
  const dict = getDictionary(locale);
  const siteName = dict.common.siteName;
  return {
    "@context": "https://schema.org",
    "@type": "WebSite",
    name: siteName,
    url: siteUrl,
    description: dict.home.metaDescription,
    inLanguage: localeHtmlLang[locale],
    publisher: {
      "@type": "Organization",
      name: siteName,
      url: siteUrl,
    },
  };
}
