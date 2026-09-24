import Link from "next/link";
import { InfoIcon, LogoMark } from "./icons";
import { getCategories } from "@/lib/data";
import { getLocale } from "@/lib/i18n/getLocale";
import { getDictionary } from "@/lib/i18n/dictionaries";
import { localizeCategories } from "@/lib/i18n/localize";

export default async function Footer() {
  const locale = await getLocale();
  const dict = getDictionary(locale);
  const categories = localizeCategories(await getCategories(), locale);

  return (
    <footer className="mt-20 border-t border-slate-200 bg-slate-900 text-slate-400">
      <div className="mx-auto max-w-5xl px-4 py-12 sm:px-6">
        <div className="mb-10 flex items-start gap-3 rounded-xl bg-slate-800/60 p-4 text-sm leading-relaxed text-slate-300">
          <InfoIcon className="mt-0.5 h-5 w-5 shrink-0 text-slate-400" />
          <p>{dict.footer.disclaimer}</p>
        </div>

        <div className="grid grid-cols-2 gap-8 sm:grid-cols-4">
          <div>
            <div className="mb-3 flex items-center gap-2">
              <span className="flex h-7 w-7 items-center justify-center rounded-md bg-brand-600">
                <LogoMark className="h-4 w-4" />
              </span>
              <span className="text-sm font-semibold text-white">{dict.common.siteName}</span>
            </div>
            <p className="text-xs leading-relaxed text-slate-500">{dict.footer.tagline}</p>
          </div>

          <div>
            <p className="mb-3 text-xs font-semibold uppercase tracking-wide text-slate-500">{dict.footer.categoriesHeading}</p>
            <ul className="space-y-2 text-sm">
              {categories.map((category) => (
                <li key={category.id}>
                  <Link href={`/category/${category.slug}`} className="transition hover:text-white">
                    {category.name}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          <div>
            <p className="mb-3 text-xs font-semibold uppercase tracking-wide text-slate-500">{dict.footer.toolsHeading}</p>
            <ul className="space-y-2 text-sm">
              <li>
                <Link href="/search" className="transition hover:text-white">
                  {dict.footer.toolSearch}
                </Link>
              </li>
              <li>
                <Link href="/finder" className="transition hover:text-white">
                  {dict.footer.toolFinder}
                </Link>
              </li>
              <li>
                <Link href="/median-income" className="transition hover:text-white">
                  {dict.footer.toolMedianIncome}
                </Link>
              </li>
            </ul>
          </div>

          <div>
            <p className="mb-3 text-xs font-semibold uppercase tracking-wide text-slate-500">{dict.footer.siteHeading}</p>
            <ul className="space-y-2 text-sm">
              <li>
                <Link href="/about" className="transition hover:text-white">
                  {dict.footer.linkAbout}
                </Link>
              </li>
              <li>
                <Link href="/privacy" className="transition hover:text-white">
                  {dict.footer.linkPrivacy}
                </Link>
              </li>
              <li>
                <Link href="/terms" className="transition hover:text-white">
                  {dict.footer.linkTerms}
                </Link>
              </li>
              <li>
                <Link href="/contact" className="transition hover:text-white">
                  {dict.footer.linkContact}
                </Link>
              </li>
            </ul>
          </div>
        </div>

        <p className="mt-10 text-xs text-slate-500">&copy; {new Date().getFullYear()} {dict.footer.copyrightSuffix}</p>
      </div>
    </footer>
  );
}
