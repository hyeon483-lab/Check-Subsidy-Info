import Link from "next/link";
import { FilterIcon, LogoMark, SearchIcon } from "./icons";
import { getLocale } from "@/lib/i18n/getLocale";
import { getDictionary } from "@/lib/i18n/dictionaries";
import { localizedHref } from "@/lib/i18n/href";
import LanguageToggle from "./LanguageToggle";

export default async function Header() {
  const locale = await getLocale();
  const dict = getDictionary(locale);

  return (
    <header className="sticky top-0 z-40 border-b border-slate-200/80 bg-white/85 backdrop-blur">
      <div className="mx-auto flex max-w-5xl items-center justify-between gap-3 px-4 py-3.5 sm:px-6">
        <Link href={localizedHref("/", locale)} className="flex shrink-0 items-center gap-2" aria-label={dict.common.siteName}>
          <span className="flex h-8 w-8 items-center justify-center rounded-[9px] bg-brand-600">
            <LogoMark className="h-[18px] w-[18px]" />
          </span>
          {/* 모바일은 공간이 좁아 아이콘만 보여주고, 이 텍스트 하나만 DOM에 둬서
              (반응형 대체 텍스트를 따로 두지 않음) 원문 추출 도구에서 중복 노출되지 않게 합니다. */}
          <span className="hidden text-[15px] font-bold tracking-tight text-slate-900 sm:inline">
            {dict.common.siteName}
          </span>
        </Link>

        <form action={localizedHref("/search", locale)} method="GET" role="search" className="hidden max-w-xs flex-1 sm:block">
          <div className="relative">
            <SearchIcon className="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-400" />
            <input
              type="search"
              name="q"
              placeholder={dict.header.searchPlaceholder}
              className="w-full rounded-full border border-slate-200 bg-slate-50 py-1.5 pl-9 pr-3 text-sm text-slate-700 placeholder:text-slate-400 focus:border-brand-400 focus:bg-white focus:outline-none focus:ring-2 focus:ring-brand-100"
            />
          </div>
        </form>

        <nav className="flex items-center gap-1 text-sm font-medium text-slate-500">
          <Link
            href={localizedHref("/search", locale)}
            aria-label={dict.header.searchAriaLabel}
            className="rounded-full p-2 transition hover:bg-slate-100 hover:text-slate-900 sm:hidden"
          >
            <SearchIcon className="h-5 w-5" />
          </Link>
          <Link
            href={localizedHref("/finder", locale)}
            className="inline-flex items-center gap-1.5 rounded-full px-3 py-1.5 transition hover:bg-slate-100 hover:text-slate-900"
          >
            <FilterIcon className="h-4 w-4" />
            <span className="hidden sm:inline">{dict.header.navFinder}</span>
          </Link>
          <Link
            href={localizedHref("/about", locale)}
            className="rounded-full px-3 py-1.5 transition hover:bg-slate-100 hover:text-slate-900"
          >
            {dict.header.navAbout}
          </Link>
          <Link
            href={localizedHref("/contact", locale)}
            className="rounded-full px-3 py-1.5 transition hover:bg-slate-100 hover:text-slate-900"
          >
            {dict.header.navContact}
          </Link>
          <LanguageToggle currentLocale={locale} />
        </nav>
      </div>
    </header>
  );
}
