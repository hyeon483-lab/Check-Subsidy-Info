"use client";

import { useTransition } from "react";
import { useRouter } from "next/navigation";
import { locales, localeLabels, type Locale } from "@/lib/i18n/config";
import { setLocaleCookie } from "@/app/actions/locale";
import { GlobeIcon } from "./icons";

export default function LanguageToggle({ currentLocale }: { currentLocale: Locale }) {
  const router = useRouter();
  const [pending, startTransition] = useTransition();

  function handleChange(locale: Locale) {
    if (locale === currentLocale) return;
    startTransition(async () => {
      await setLocaleCookie(locale);
      router.refresh();
    });
  }

  return (
    <div className="relative flex shrink-0 items-center">
      <GlobeIcon className="pointer-events-none absolute left-2.5 h-3.5 w-3.5 text-slate-400" />
      <select
        aria-label="Language / 언어 선택"
        value={currentLocale}
        disabled={pending}
        onChange={(e) => handleChange(e.target.value as Locale)}
        className="appearance-none rounded-full border border-slate-200 bg-white py-1.5 pl-8 pr-6 text-xs font-medium text-slate-600 transition hover:bg-slate-50 focus:border-brand-400 focus:outline-none focus:ring-2 focus:ring-brand-100 disabled:opacity-60"
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
