import Link from "next/link";
import { Benefit } from "@/lib/types";

export default function BenefitCard({ benefit }: { benefit: Benefit }) {
  return (
    <Link
      href={`/benefits/${benefit.slug}`}
      className="block rounded-lg border border-gray-200 bg-white p-5 transition hover:border-brand-500 hover:shadow-sm"
    >
      <div className="mb-2 flex flex-wrap gap-2 text-xs">
        {benefit.region && (
          <span className="rounded-full bg-brand-50 px-2 py-0.5 text-brand-700">{benefit.region.name}</span>
        )}
        {benefit.category && (
          <span className="rounded-full bg-gray-100 px-2 py-0.5 text-gray-600">{benefit.category.name}</span>
        )}
      </div>
      <h3 className="mb-1 font-semibold text-gray-900">{benefit.title}</h3>
      <p className="line-clamp-2 text-sm text-gray-600">{benefit.summary}</p>
    </Link>
  );
}
