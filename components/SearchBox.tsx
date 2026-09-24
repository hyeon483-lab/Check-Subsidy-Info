import { SearchIcon } from "./icons";
import type { Dictionary } from "@/lib/i18n/dictionaryType";
import type { Locale } from "@/lib/i18n/config";
import { localizedHref } from "@/lib/i18n/href";

export default function SearchBox({
  defaultValue,
  className = "",
  dict,
  locale,
}: {
  defaultValue?: string;
  className?: string;
  dict: Dictionary;
  locale: Locale;
}) {
  return (
    <form action={localizedHref("/search", locale)} method="GET" role="search" className={className}>
      <div className="relative">
        <SearchIcon className="pointer-events-none absolute left-3.5 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-400" />
        <input
          type="search"
          name="q"
          defaultValue={defaultValue}
          placeholder={dict.search.placeholder}
          className="w-full rounded-full border border-slate-200 bg-white py-2.5 pl-10 pr-4 text-sm text-slate-700 placeholder:text-slate-400 focus:border-brand-400 focus:outline-none focus:ring-2 focus:ring-brand-100"
        />
      </div>
    </form>
  );
}
