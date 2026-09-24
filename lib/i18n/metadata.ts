import { siteUrl } from "@/lib/site";
import { locales, defaultLocale, localeHtmlLang } from "./config";
import { localizedHref } from "./href";

/** Builds the hreflang alternate-language map for a given unprefixed path, for use in generateMetadata's alternates.languages. */
export function localeAlternates(path: string): Record<string, string> {
  const languages: Record<string, string> = {};
  for (const locale of locales) {
    languages[localeHtmlLang[locale]] = `${siteUrl}${localizedHref(path, locale)}`;
  }
  languages["x-default"] = `${siteUrl}${localizedHref(path, defaultLocale)}`;
  return languages;
}
