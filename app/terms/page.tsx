import type { Metadata } from "next";
import { getLocale } from "@/lib/i18n/getLocale";
import { getDictionary } from "@/lib/i18n/dictionaries";

export async function generateMetadata(): Promise<Metadata> {
  const dict = getDictionary(await getLocale());
  return {
    title: dict.termsPage.metaTitle,
    description: dict.termsPage.metaDescription,
    alternates: { canonical: "/terms" },
  };
}

export default async function TermsPage() {
  const dict = getDictionary(await getLocale());
  return (
    <div className="mx-auto max-w-3xl px-4 py-14 sm:px-6">
      <h1 className="mb-6 text-2xl font-bold tracking-tight text-slate-900 sm:text-3xl">{dict.termsPage.heading}</h1>
      <div className="space-y-6 rounded-2xl bg-white p-6 text-[15px] leading-relaxed text-slate-600 shadow-card ring-1 ring-slate-100 sm:p-8">
        <section>
          <h2 className="mb-2 text-base font-bold text-slate-900">{dict.termsPage.section1Heading}</h2>
          <p>{dict.termsPage.section1Body}</p>
        </section>
        <section>
          <h2 className="mb-2 text-base font-bold text-slate-900">{dict.termsPage.section2Heading}</h2>
          <p>{dict.termsPage.section2Body}</p>
        </section>
        <section>
          <h2 className="mb-2 text-base font-bold text-slate-900">{dict.termsPage.section3Heading}</h2>
          <p>{dict.termsPage.section3Body}</p>
        </section>
        <section>
          <h2 className="mb-2 text-base font-bold text-slate-900">{dict.termsPage.section4Heading}</h2>
          <p>{dict.termsPage.section4Body}</p>
        </section>
        <p className="text-xs text-slate-400">{dict.termsPage.lastUpdated}</p>
      </div>
    </div>
  );
}
