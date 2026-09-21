import Link from "next/link";

export default function Header() {
  return (
    <header className="sticky top-0 z-40 border-b border-slate-200/80 bg-white/85 backdrop-blur">
      <div className="mx-auto flex max-w-5xl items-center justify-between px-4 py-3.5 sm:px-6">
        <Link href="/" className="flex items-center gap-2">
          <span className="flex h-8 w-8 items-center justify-center rounded-lg bg-brand-600 text-sm font-bold text-white">
            내
          </span>
          <span className="text-[15px] font-bold tracking-tight text-slate-900">
            내 지원금 찾기
          </span>
        </Link>
        <nav className="flex items-center gap-1 text-sm font-medium text-slate-500">
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
