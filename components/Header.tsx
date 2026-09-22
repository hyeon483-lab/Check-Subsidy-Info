import Link from "next/link";
import { CalculatorIcon, SearchIcon } from "./icons";

export default function Header() {
  return (
    <header className="sticky top-0 z-40 border-b border-slate-200/80 bg-white/85 backdrop-blur">
      <div className="mx-auto flex max-w-5xl items-center justify-between gap-3 px-4 py-3.5 sm:px-6">
        <Link href="/" className="flex shrink-0 items-center gap-2">
          <span className="flex h-8 w-8 items-center justify-center rounded-lg bg-brand-600 text-sm font-bold text-white">
            내
          </span>
          <span className="hidden text-[15px] font-bold tracking-tight text-slate-900 sm:inline">
            내 지원금 찾기
          </span>
        </Link>

        <form action="/search" method="GET" role="search" className="hidden max-w-xs flex-1 sm:block">
          <div className="relative">
            <SearchIcon className="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-400" />
            <input
              type="search"
              name="q"
              placeholder="지원금 검색"
              className="w-full rounded-full border border-slate-200 bg-slate-50 py-1.5 pl-9 pr-3 text-sm text-slate-700 placeholder:text-slate-400 focus:border-brand-400 focus:bg-white focus:outline-none focus:ring-2 focus:ring-brand-100"
            />
          </div>
        </form>

        <nav className="flex items-center gap-1 text-sm font-medium text-slate-500">
          <Link
            href="/search"
            aria-label="검색"
            className="rounded-full p-2 transition hover:bg-slate-100 hover:text-slate-900 sm:hidden"
          >
            <SearchIcon className="h-5 w-5" />
          </Link>
          <Link
            href="/calculator"
            className="inline-flex items-center gap-1.5 rounded-full px-3 py-1.5 transition hover:bg-slate-100 hover:text-slate-900"
          >
            <CalculatorIcon className="h-4 w-4" />
            <span className="hidden sm:inline">계산기</span>
          </Link>
          <Link
            href="/about"
            className="rounded-full px-3 py-1.5 transition hover:bg-slate-100 hover:text-slate-900"
          >
            소개
          </Link>
          <Link
            href="/contact"
            className="rounded-full px-3 py-1.5 transition hover:bg-slate-100 hover:text-slate-900"
          >
            문의
          </Link>
        </nav>
      </div>
    </header>
  );
}
