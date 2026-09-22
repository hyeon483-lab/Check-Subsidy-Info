import Link from "next/link";

export default function Pagination({
  currentPage,
  totalPages,
  basePath,
  searchParams = {},
}: {
  currentPage: number;
  totalPages: number;
  basePath: string;
  searchParams?: Record<string, string | undefined>;
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

  const pages = Array.from({ length: totalPages }, (_, i) => i + 1);

  return (
    <nav aria-label="페이지 네비게이션" className="mt-8 flex flex-wrap items-center justify-center gap-1.5">
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
        이전
      </Link>
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
        다음
      </Link>
    </nav>
  );
}
