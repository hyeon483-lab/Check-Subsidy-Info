import Link from "next/link";
import type { Dictionary } from "@/lib/i18n/dictionaryType";

export default function Pagination({
  currentPage,
  totalPages,
  basePath,
  searchParams = {},
  dict,
}: {
  currentPage: number;
  totalPages: number;
  basePath: string;
  searchParams?: Record<string, string | undefined>;
  dict: Dictionary;
}) {
  if (totalPages <= 1) return null;

  function buildHref(page: number) {
    const params = new URLSearchParams();
    for (const [key, value] of Object.entries(searchParams)) {
      if (value) params.set(key, value);
    }
    if (page > 1) params.set("page", String(page));
    const qs = params.toString();
    return qs ? `${basePath}?${qs}` : basePath;
  }

  const maxVisible = 10;
  const windowStart = Math.min(
    Math.max(1, currentPage - Math.floor(maxVisible / 2)),
    Math.max(1, totalPages - maxVisible + 1)
  );
  const windowEnd = Math.min(totalPages, windowStart + maxVisible - 1);
  const pages = Array.from({ length: windowEnd - windowStart + 1 }, (_, i) => windowStart + i);

  return (
    <nav aria-label={dict.pagination.ariaLabel} className="mt-8 flex flex-wrap items-center justify-center gap-1.5">
      <Link
        href={buildHref(Math.max(1, currentPage - 1))}
        aria-disabled={currentPage === 1}
        tabIndex={currentPage === 1 ? -1 : undefined}
        className={`rounded-full px-3 py-1.5 text-sm font-medium transition ${
          currentPage === 1
            ? "pointer-events-none text-slate-300"
            : "text-slate-500 hover:bg-slate-100 hover:text-slate-900"
        }`}
      >
        {dict.pagination.previous}
      </Link>
      {windowStart > 1 && (
        <span className="px-1 text-sm text-slate-300" aria-hidden="true">
          …
        </span>
      )}
      {pages.map((page) => (
        <Link
          key={page}
          href={buildHref(page)}
          aria-current={page === currentPage ? "page" : undefined}
          className={`flex h-8 w-8 items-center justify-center rounded-full text-sm font-medium transition ${
            page === currentPage
              ? "bg-brand-600 text-white shadow-sm"
              : "text-slate-600 hover:bg-slate-100"
          }`}
        >
          {page}
        </Link>
      ))}
      {windowEnd < totalPages && (
        <span className="px-1 text-sm text-slate-300" aria-hidden="true">
          …
        </span>
      )}
      <Link
        href={buildHref(Math.min(totalPages, currentPage + 1))}
        aria-disabled={currentPage === totalPages}
        tabIndex={currentPage === totalPages ? -1 : undefined}
        className={`rounded-full px-3 py-1.5 text-sm font-medium transition ${
          currentPage === totalPages
            ? "pointer-events-none text-slate-300"
            : "text-slate-500 hover:bg-slate-100 hover:text-slate-900"
        }`}
      >
        {dict.pagination.next}
      </Link>
    </nav>
  );
}
