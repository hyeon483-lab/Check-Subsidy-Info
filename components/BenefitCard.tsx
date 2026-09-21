import Link from "next/link";
import { Benefit } from "@/lib/types";
import { getCategoryStyle } from "@/lib/categoryStyle";
import { ArrowRightIcon } from "./icons";

export default function BenefitCard({ benefit }: { benefit: Benefit }) {
  const style = getCategoryStyle(benefit.category?.slug);
  const Icon = style.icon;

  return (
    <Link
      href={`/benefits/${benefit.slug}`}
      className="group flex flex-col rounded-2xl bg-white p-5 shadow-card ring-1 ring-slate-100 transition hover:-translate-y-0.5 hover:shadow-card-hover"
    >
      <div className="mb-3 flex items-center justify-between">
        <span className={`flex h-10 w-10 items-center justify-center rounded-xl ${style.iconWrap}`}>
          <Icon className="h-5 w-5" />
        </span>
        {benefit.region && (
          <span className="rounded-full bg-slate-50 px-2.5 py-1 text-xs font-medium text-slate-500 ring-1 ring-inset ring-slate-100">
            {benefit.region.name}
          </span>
        )}
      </div>

      <h3 className="mb-1.5 font-semibold leading-snug text-slate-900 transition group-hover:text-brand-700">
        {benefit.title}
      </h3>
      <p className="mb-4 line-clamp-2 flex-1 text-sm leading-relaxed text-slate-500">{benefit.summary}</p>

      <div className="flex items-center justify-between border-t border-slate-100 pt-3">
        <span className={`rounded-full px-2.5 py-1 text-xs font-medium ${style.chip}`}>
          {benefit.category?.name}
        </span>
        <span className="inline-flex items-center gap-1 text-xs font-medium text-slate-400 transition group-hover:text-brand-600">
          자세히 보기
          <ArrowRightIcon className="h-3.5 w-3.5 transition group-hover:translate-x-0.5" />
        </span>
      </div>
    </Link>
  );
}
