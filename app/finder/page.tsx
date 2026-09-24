import type { Metadata } from "next";
import { getBenefits, getCategories, getRegions } from "@/lib/data";
import FinderClient from "@/components/FinderClient";
import { FilterIcon } from "@/components/icons";
import { siteUrl } from "@/lib/site";
import { getLocale } from "@/lib/i18n/getLocale";
import { getDictionary } from "@/lib/i18n/dictionaries";
import { localizeBenefits, localizeCategories, localizeRegions } from "@/lib/i18n/localize";
import { localizedHref } from "@/lib/i18n/href";
import { localeAlternates } from "@/lib/i18n/metadata";

// Supabase의 데이터가 DB에 반영되는 즉시(재배포 없이) 사이트에 나타나도록
// 빌드 시점에 굳히는 정적 생성 대신 매 요청마다 새로 렌더링합니다.
export const dynamic = "force-dynamic";

export async function generateMetadata(): Promise<Metadata> {
  const locale = await getLocale();
  const dict = getDictionary(locale);
  const title = dict.finder.metaTitle;
  const description = dict.finder.metaDescription;
  const url = `${siteUrl}${localizedHref("/finder", locale)}`;
  return {
    title,
    description,
    alternates: { canonical: url, languages: localeAlternates("/finder") },
    openGraph: { title, description, url },
  };
}

export default async function FinderPage() {
  const locale = await getLocale();
  const dict = getDictionary(locale);
  const [benefits, regions, categories] = await Promise.all([getBenefits({}), getRegions(), getCategories()]);

  return (
    <div>
      <section className="border-b border-slate-200 bg-gradient-to-b from-brand-50/70 via-white to-white">
        <div className="mx-auto max-w-3xl px-4 pb-10 pt-12 text-center sm:px-6 sm:pt-16">
          <span className="mb-3 inline-flex h-11 w-11 items-center justify-center rounded-xl bg-brand-50 text-brand-600">
            <FilterIcon className="h-5 w-5" />
          </span>
          <h1 className="mb-2 text-2xl font-bold tracking-tight text-slate-900 sm:text-3xl">{dict.finder.heading}</h1>
          <p className="text-[15px] text-slate-500">{dict.finder.description}</p>
        </div>
      </section>

      <div className="mx-auto max-w-2xl px-4 py-10 sm:px-6">
        <FinderClient
          benefits={localizeBenefits(benefits, locale)}
          regions={localizeRegions(regions, locale)}
          categories={localizeCategories(categories, locale)}
          dict={dict}
          locale={locale}
        />
      </div>
    </div>
  );
}
