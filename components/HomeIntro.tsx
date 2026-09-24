import type { Dictionary } from "@/lib/i18n/dictionaryType";
import type { Locale } from "@/lib/i18n/config";
import { localizedHref } from "@/lib/i18n/href";

export default function HomeIntro({ dict, locale }: { dict: Dictionary; locale: Locale }) {
  return (
    <section className="mb-16 rounded-2xl bg-white p-6 shadow-card ring-1 ring-slate-100 sm:p-8">
      <h2 className="mb-4 text-lg font-bold text-slate-900">{dict.home.introHeading}</h2>
      <div className="space-y-4 text-[15px] leading-relaxed text-slate-600">
        <p>{dict.home.introParagraph1}</p>
        <p>
          {dict.home.introParagraph2Pre}
          <a href={localizedHref("/finder", locale)} className="font-medium text-brand-700 hover:underline">
            {dict.home.introLinkText}
          </a>
          {dict.home.introParagraph2Post}
        </p>
        <p>{dict.home.introParagraph3}</p>
      </div>
    </section>
  );
}
