import { BenefitGridSkeleton, FilterBarSkeleton } from "@/components/skeletons";
import { getLocale } from "@/lib/i18n/getLocale";
import { getDictionary } from "@/lib/i18n/dictionaries";

export default async function HomeLoading() {
  const dict = getDictionary(await getLocale());
  return (
    <div>
      <section className="border-b border-slate-200 bg-gradient-to-b from-brand-50/70 via-white to-white">
        <div className="mx-auto max-w-5xl px-4 pb-10 pt-14 text-center sm:px-6 sm:pt-20">
          <span className="mb-4 inline-block rounded-full bg-white px-3 py-1 text-xs font-semibold text-brand-700 ring-1 ring-inset ring-brand-100">
            {dict.home.eyebrow}
          </span>
          <h1 className="mx-auto mb-3 max-w-2xl text-3xl font-bold leading-tight tracking-tight text-slate-900 sm:text-4xl">
            {dict.home.heroTitleLine1}
            <br />
            {dict.home.heroTitleLine2}
          </h1>
          <p className="mx-auto max-w-xl text-[15px] leading-relaxed text-slate-500">{dict.home.heroDescription}</p>
        </div>
      </section>

      <div className="mx-auto max-w-5xl px-4 py-10 sm:px-6">
        <div className="mb-8 rounded-2xl bg-white p-5 shadow-card ring-1 ring-slate-100 sm:-mt-6">
          <FilterBarSkeleton />
        </div>
        <BenefitGridSkeleton />
      </div>
    </div>
  );
}
