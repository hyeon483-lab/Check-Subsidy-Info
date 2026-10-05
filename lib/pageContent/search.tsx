import type { Metadata } from "next";
import { getBenefits } from "@/lib/data";
import { Benefit } from "@/lib/types";
import { paginate } from "@/lib/paginate";
import BenefitCard from "@/components/BenefitCard";
import SearchBox from "@/components/SearchBox";
import Pagination from "@/components/Pagination";
import { siteUrl } from "@/lib/site";
import { getDictionary } from "@/lib/i18n/dictionaries";
import { localizeBenefits } from "@/lib/i18n/localize";
import { localizedHref } from "@/lib/i18n/href";
import type { Locale } from "@/lib/i18n/config";

export function searchMetadata(locale: Locale, q: string | undefined): Metadata {
  const dict = getDictionary(locale);
  const query = (q ?? "").trim();
  const title = query ? `"${query}" ${dict.search.metaSearchResultsSuffix}` : dict.search.metaDefaultTitle;
  return {
    title,
    alternates: { canonical: `${siteUrl}${localizedHref("/search", locale)}` },
    robots: { index: false, follow: true },
  };
}

function matchesQuery(benefit: Benefit, query: string) {
  const haystack = [
    benefit.title,
    benefit.summary,
    benefit.eligibility,
    benefit.region?.name,
    benefit.category?.name,
    benefit.agency_name,
  ]
    .filter(Boolean)
    .join(" ")
    .toLowerCase();

  return query
    .toLowerCase()
    .split(/\s+/)
    .filter(Boolean)
    .every((term) => haystack.includes(term));
}

export async function SearchPageContent({
  locale,
  q,
  page,
}: {
  locale: Locale;
  q: string | undefined;
  page: string | undefined;
}) {
  const dict = getDictionary(locale);
  const query = (q ?? "").trim();
  const allBenefits = query ? await getBenefits({}) : [];
  const results = query ? allBenefits.filter((b) => matchesQuery(b, query)) : [];
  const { items, currentPage, totalPages } = paginate(results, Number(page) || 1);

  return (
    <div>
      <section className="border-b border-slate-200 bg-gradient-to-b from-brand-50/70 via-white to-white">
        <div className="mx-auto max-w-3xl px-4 pb-10 pt-12 sm:px-6 sm:pt-16">
          <h1 className="mb-4 text-2xl font-bold tracking-tight text-slate-900 sm:text-3xl">{dict.search.heading}</h1>
          <SearchBox defaultValue={query} dict={dict} locale={locale} />
        </div>
      </section>

      <div className="mx-auto max-w-5xl px-4 py-10 sm:px-6">
        {!query ? (
          <p className="rounded-2xl border border-dashed border-slate-300 bg-white p-10 text-center text-sm text-slate-500">
            {dict.search.emptyPrompt}
          </p>
        ) : results.length === 0 ? (
          <p className="rounded-2xl border border-dashed border-slate-300 bg-white p-10 text-center text-sm text-slate-500">
            {dict.search.noResultsTemplate.replace("{query}", query)}
          </p>
        ) : (
          <>
            <p className="mb-4 text-sm text-slate-500">
              {(() => {
                const [before, after] = dict.search.resultsTemplate
                  .replace("{query}", query)
                  .split("{count}");
                return (
                  <>
                    {before}
                    <span className="font-semibold text-slate-700">{results.length}</span>
                    {after}
                  </>
                );
              })()}
            </p>
            <div className="grid gap-4 sm:grid-cols-2">
              {localizeBenefits(items, locale).map((benefit) => (
                <BenefitCard key={benefit.id} benefit={benefit} dict={dict} locale={locale} />
              ))}
            </div>
            <Pagination
              currentPage={currentPage}
              totalPages={totalPages}
              basePath={localizedHref("/search", locale)}
              searchParams={{ q: query }}
              dict={dict}
            />
          </>
        )}
      </div>
    </div>
  );
}
