import Link from "next/link";
import { FilterIcon, SearchIcon, TableIcon } from "./icons";
import type { Dictionary } from "@/lib/i18n/dictionaryType";
import type { Locale } from "@/lib/i18n/config";
import { localizedHref } from "@/lib/i18n/href";

export default function ToolsShowcase({ dict, locale }: { dict: Dictionary; locale: Locale }) {
  const tools = [
    {
      href: "/search",
      icon: SearchIcon,
      title: dict.tools.searchTitle,
      description: dict.tools.searchDescription,
      color: "bg-blue-50 text-blue-600",
    },
    {
      href: "/finder",
      icon: FilterIcon,
      title: dict.tools.finderTitle,
      description: dict.tools.finderDescription,
      color: "bg-brand-50 text-brand-600",
    },
    {
      href: "/median-income",
      icon: TableIcon,
      title: dict.tools.medianIncomeTitle,
      description: dict.tools.medianIncomeDescription,
      color: "bg-emerald-50 text-emerald-600",
    },
  ];

  return (
    <section>
      <h2 className="mb-4 text-lg font-bold text-slate-900">{dict.home.toolsHeading}</h2>
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {tools.map((tool) => {
          const Icon = tool.icon;
          return (
            <Link
              key={tool.href}
              href={localizedHref(tool.href, locale)}
              className="group flex items-start gap-4 rounded-2xl bg-white p-5 shadow-card ring-1 ring-slate-100 transition hover:-translate-y-0.5 hover:shadow-card-hover"
            >
              <span className={`flex h-12 w-12 shrink-0 items-center justify-center rounded-xl ${tool.color}`}>
                <Icon className="h-6 w-6" />
              </span>
              <div>
                <h3 className="mb-1 font-semibold text-slate-900 transition group-hover:text-brand-700">
                  {tool.title}
                </h3>
                <p className="text-sm leading-relaxed text-slate-500">{tool.description}</p>
              </div>
            </Link>
          );
        })}
      </div>
    </section>
  );
}
