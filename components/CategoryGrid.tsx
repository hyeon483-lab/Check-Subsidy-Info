import Link from "next/link";
import { Category } from "@/lib/types";
import { getCategoryStyle } from "@/lib/categoryStyle";
import type { Dictionary } from "@/lib/i18n/dictionaryType";
import type { Locale } from "@/lib/i18n/config";
import { localizedHref } from "@/lib/i18n/href";

export default function CategoryGrid({
  categories,
  dict,
  locale,
}: {
  categories: (Category & { count: number })[];
  dict: Dictionary;
  locale: Locale;
}) {
  return (
    <section>
      <h2 className="mb-4 text-lg font-bold text-slate-900">{dict.home.categoriesHeading}</h2>
      <div className="grid grid-cols-2 gap-4 sm:grid-cols-4">
        {categories.map((category) => {
          const style = getCategoryStyle(category.slug);
          const Icon = style.icon;
          return (
            <Link
              key={category.id}
              href={localizedHref(`/category/${category.slug}`, locale)}
              className="group flex flex-col items-center gap-2.5 rounded-2xl bg-white p-5 text-center shadow-card ring-1 ring-slate-100 transition hover:-translate-y-0.5 hover:shadow-card-hover"
            >
              <span className={`flex h-11 w-11 items-center justify-center rounded-xl ${style.iconWrap}`}>
                <Icon className="h-5 w-5" />
              </span>
              <span className="font-semibold text-slate-900 transition group-hover:text-brand-700">
                {category.name}
              </span>
              <span className="text-xs font-medium text-slate-400">
                {category.count}
                {dict.common.caseCountSuffix}
              </span>
            </Link>
          );
        })}
      </div>
    </section>
  );
}
