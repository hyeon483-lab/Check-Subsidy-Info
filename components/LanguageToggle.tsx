"use client";

import { usePathname, useRouter, useSearchParams } from "next/navigation";
import { locales, localeLabels, type Locale } from "@/lib/i18n/config";
import { localeFromPathname, localizedHref, stripLocalePrefix } from "@/lib/i18n/href";
import { GlobeIcon } from "./icons";

// The active locale is derived from the live pathname (usePathname is reactive)
// rather than passed in as a prop: the root layout that renders this component
// is a persisted layout Next.js doesn't re-fetch on client-side navigation
// between locale-prefixed routes, so a server-passed locale prop would go
// stale after switching languages once.
export default function LanguageToggle() {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const activeLocale = localeFromPathname(pathname);

  function handleChange(locale: Locale) {
    if (locale === activeLocale) return;
    const bare = stripLocalePrefix(pathname);
    const qs = searchParams.toString();
    const target = localizedHref(bare, locale) + (qs ? `?${qs}` : "");
    router.push(target);
  }

  return (
    <div className="relative flex shrink-0 items-center">
      <GlobeIcon className="pointer-events-none absolute left-2.5 h-3.5 w-3.5 text-slate-400" />
      <select
        aria-label="Language / 언어 선택"
        value={activeLocale}
        onChange={(e) => handleChange(e.target.value as Locale)}
        className="appearance-none rounded-full border border-slate-200 bg-white py-1.5 pl-8 pr-6 text-xs font-medium text-slate-600 transition hover:bg-slate-50 focus:border-brand-400 focus:outline-none focus:ring-2 focus:ring-brand-100"
      >
        {locales.map((locale) => (
          <option key={locale} value={locale}>
            {localeLabels[locale]}
          </option>
        ))}
      </select>
    </div>
  );
}
