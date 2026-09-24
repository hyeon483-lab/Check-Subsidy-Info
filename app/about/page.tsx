import type { Metadata } from "next";
import { getLocale } from "@/lib/i18n/getLocale";
import { getDictionary } from "@/lib/i18n/dictionaries";
import { localizedHref } from "@/lib/i18n/href";
import { localeAlternates } from "@/lib/i18n/metadata";

export async function generateMetadata(): Promise<Metadata> {
  const locale = await getLocale();
  const dict = getDictionary(locale);
  return {
    title: dict.aboutPage.metaTitle,
    description: dict.aboutPage.metaDescription,
    alternates: { canonical: localizedHref("/about", locale), languages: localeAlternates("/about") },
  };
}

export default async function AboutPage() {
  const dict = getDictionary(await getLocale());
  return (
    <div className="mx-auto max-w-3xl px-4 py-14 sm:px-6">
      <h1 className="mb-6 text-2xl font-bold tracking-tight text-slate-900 sm:text-3xl">{dict.aboutPage.heading}</h1>
      <div className="space-y-4 rounded-2xl bg-white p-6 text-[15px] leading-relaxed text-slate-600 shadow-card ring-1 ring-slate-100 sm:p-8">
        <p>{dict.aboutPage.paragraph1}</p>
        <p>{dict.aboutPage.paragraph2}</p>
        <p>{dict.aboutPage.paragraph3}</p>
      </div>
    </div>
  );
}
