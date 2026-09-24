import type { Metadata } from "next";
import { getLocale } from "@/lib/i18n/getLocale";
import { getDictionary } from "@/lib/i18n/dictionaries";
import { localizedHref } from "@/lib/i18n/href";
import { localeAlternates } from "@/lib/i18n/metadata";

export async function generateMetadata(): Promise<Metadata> {
  const locale = await getLocale();
  const dict = getDictionary(locale);
  return {
    title: dict.contactPage.metaTitle,
    description: dict.contactPage.metaDescription,
    alternates: { canonical: localizedHref("/contact", locale), languages: localeAlternates("/contact") },
  };
}

export default async function ContactPage() {
  const dict = getDictionary(await getLocale());
  return (
    <div className="mx-auto max-w-3xl px-4 py-14 sm:px-6">
      <h1 className="mb-6 text-2xl font-bold tracking-tight text-slate-900 sm:text-3xl">{dict.contactPage.heading}</h1>
      <div className="space-y-4 rounded-2xl bg-white p-6 text-[15px] leading-relaxed text-slate-600 shadow-card ring-1 ring-slate-100 sm:p-8">
        <p>{dict.contactPage.body}</p>
        <p className="rounded-xl bg-brand-50 px-4 py-3 font-medium text-brand-700 ring-1 ring-inset ring-brand-100">
          chriskevin0707@gmail.com
        </p>
      </div>
    </div>
  );
}
