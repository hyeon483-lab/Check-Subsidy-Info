import Link from "next/link";
import { getLocale } from "@/lib/i18n/getLocale";
import { getDictionary } from "@/lib/i18n/dictionaries";
import { localizedHref } from "@/lib/i18n/href";

export default async function NotFound() {
  const locale = await getLocale();
  const dict = getDictionary(locale);
  return (
    <div className="mx-auto max-w-3xl px-4 py-24 text-center">
      <h1 className="mb-3 text-2xl font-bold tracking-tight text-slate-900">{dict.notFound.heading}</h1>
      <p className="mb-6 text-slate-500">{dict.notFound.body}</p>
      <Link
        href={localizedHref("/", locale)}
        className="inline-flex items-center gap-1.5 rounded-full bg-brand-600 px-4 py-2 text-sm font-medium text-white transition hover:bg-brand-700"
      >
        {dict.notFound.homeLink}
      </Link>
    </div>
  );
}
