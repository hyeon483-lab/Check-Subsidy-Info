import type { Locale } from "./config";
import { defaultLocale, locales } from "./config";

/** Prefixes an internal path with the locale segment (e.g. "/en/category/marriage"), except for the default locale which keeps its existing unprefixed URLs. */
export function localizedHref(path: string, locale: Locale): string {
  if (locale === defaultLocale) return path;
  if (path === "/") return `/${locale}`;
  return `/${locale}${path}`;
}

/** Strips a leading locale segment from a pathname (e.g. "/en/category/marriage" -> "/category/marriage"). */
export function stripLocalePrefix(pathname: string): string {
  const segments = pathname.split("/");
  const maybeLocale = segments[1];
  if ((locales as readonly string[]).includes(maybeLocale) && maybeLocale !== defaultLocale) {
    const rest = "/" + segments.slice(2).join("/");
    return rest;
  }
  return pathname;
}
