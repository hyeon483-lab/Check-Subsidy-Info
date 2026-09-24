import type { Metadata } from "next";
import { medianIncomeAt, medianIncomeByYear, medianIncomePercents, type MedianIncomeYearData } from "@/lib/medianIncome";
import { getLocale } from "@/lib/i18n/getLocale";
import { getDictionary } from "@/lib/i18n/dictionaries";
import type { Dictionary } from "@/lib/i18n/dictionaryType";

const latestYear = medianIncomeByYear[0].year;
const secondYear = medianIncomeByYear[1]?.year;

export async function generateMetadata(): Promise<Metadata> {
  const dict = getDictionary(await getLocale());
  return {
    title: dict.medianIncome.metaTitle,
    description: `${latestYear}${dict.medianIncome.metaDescriptionTemplate.replace("{year2}", String(secondYear))}`,
    alternates: { canonical: "/median-income" },
  };
}

function formatWon(amount: number, locale: string) {
  return `${amount.toLocaleString(locale === "ko" ? "ko-KR" : "en-US")}원`;
}

function MedianIncomeTable({ data, dict, locale }: { data: MedianIncomeYearData; dict: Dictionary; locale: string }) {
  const householdSizes = Object.keys(data.base).map(Number);

  return (
    <section className="mb-10">
      <h2 className="mb-4 text-lg font-bold text-slate-900">
        {data.year}
        {dict.medianIncome.tableHeading}
      </h2>
      <div className="mb-3 overflow-x-auto rounded-2xl bg-white shadow-card ring-1 ring-slate-100">
        <table className="w-full min-w-[860px] border-collapse text-sm">
          <thead>
            <tr className="border-b border-slate-100 bg-slate-50 text-left text-xs font-semibold uppercase tracking-wide text-slate-500">
              <th className="sticky left-0 z-10 w-24 min-w-[6rem] whitespace-nowrap bg-slate-50 px-4 py-3">
                {dict.medianIncome.householdSizeHeader}
              </th>
              {medianIncomePercents.map((percent) => (
                <th key={percent} className="whitespace-nowrap px-4 py-3 text-right">
                  {percent}%
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {householdSizes.map((size, index) => (
              <tr
                key={size}
                className={`border-b border-slate-50 last:border-0 ${index % 2 === 1 ? "bg-slate-50/40" : ""}`}
              >
                <td
                  className={`sticky left-0 z-10 w-24 min-w-[6rem] whitespace-nowrap px-4 py-3 font-medium text-slate-900 ${
                    index % 2 === 1 ? "bg-slate-50" : "bg-white"
                  }`}
                >
                  {size}
                  {dict.medianIncome.householdUnit}
                </td>
                {medianIncomePercents.map((percent) => (
                  <td
                    key={percent}
                    className={`whitespace-nowrap px-4 py-3 text-right tabular-nums text-slate-600 ${
                      percent === 100 ? "font-semibold text-brand-700" : ""
                    }`}
                  >
                    {formatWon(medianIncomeAt(data, size, percent), locale)}
                  </td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
      <p className="text-xs text-slate-400">
        {dict.medianIncome.sourcePrefix} {data.year}
        {dict.medianIncome.sourceYearSuffix}{" "}
        <a
          href={data.sourceUrl}
          target="_blank"
          rel="noopener noreferrer nofollow"
          className="font-medium text-brand-600 hover:underline"
        >
          {dict.medianIncome.sourceLinkText}
        </a>
      </p>
    </section>
  );
}

export default async function MedianIncomePage() {
  const locale = await getLocale();
  const dict = getDictionary(locale);

  return (
    <div className="mx-auto max-w-5xl px-4 py-14 sm:px-6">
      <h1 className="mb-3 text-2xl font-bold tracking-tight text-slate-900 sm:text-3xl">{dict.medianIncome.heading}</h1>
      <p className="mb-8 max-w-2xl text-[15px] leading-relaxed text-slate-500">
        {dict.medianIncome.description.replace(/\{year2\}/g, String(secondYear))}
      </p>

      {medianIncomeByYear.map((data) => (
        <MedianIncomeTable key={data.year} data={data} dict={dict} locale={locale} />
      ))}

      <div className="mb-2 rounded-2xl bg-white p-5 text-sm leading-relaxed text-slate-500 shadow-card ring-1 ring-slate-100 sm:p-6">
        <p className="mb-2">
          <strong className="font-semibold text-slate-700">{dict.medianIncome.note9PlusLabel}</strong>
          {dict.medianIncome.note9PlusBody}
        </p>
        <p>{dict.medianIncome.noteDisclaimer}</p>
      </div>
    </div>
  );
}
