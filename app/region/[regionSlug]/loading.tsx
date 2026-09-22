import { BenefitGridSkeleton, FilterBarSkeleton, PageHeroSkeleton } from "@/components/skeletons";

export default function RegionLoading() {
  return (
    <div>
      <PageHeroSkeleton />
      <div className="mx-auto max-w-5xl px-4 py-10 sm:px-6">
        <div className="mb-8 rounded-2xl bg-white p-5 shadow-card ring-1 ring-slate-100">
          <FilterBarSkeleton />
        </div>
        <BenefitGridSkeleton />
      </div>
    </div>
  );
}
