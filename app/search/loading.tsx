import { BenefitGridSkeleton } from "@/components/skeletons";

export default function SearchLoading() {
  return (
    <div>
      <section className="border-b border-slate-200 bg-gradient-to-b from-brand-50/70 via-white to-white">
        <div className="mx-auto max-w-3xl px-4 pb-10 pt-12 sm:px-6 sm:pt-16">
          <div className="mb-4 h-8 w-40 animate-pulse rounded bg-slate-200" />
          <div className="h-10 w-full animate-pulse rounded-full bg-slate-100" />
        </div>
      </section>
      <div className="mx-auto max-w-5xl px-4 py-10 sm:px-6">
        <BenefitGridSkeleton />
      </div>
    </div>
  );
}
