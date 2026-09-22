export function BenefitCardSkeleton() {
  return (
    <div className="flex flex-col rounded-2xl bg-white p-5 shadow-card ring-1 ring-slate-100">
      <div className="mb-3 flex items-center justify-between">
        <div className="h-10 w-10 animate-pulse rounded-xl bg-slate-100" />
        <div className="h-5 w-14 animate-pulse rounded-full bg-slate-100" />
      </div>
      <div className="mb-2 h-4 w-4/5 animate-pulse rounded bg-slate-100" />
      <div className="mb-4 space-y-1.5">
        <div className="h-3 w-full animate-pulse rounded bg-slate-100" />
        <div className="h-3 w-2/3 animate-pulse rounded bg-slate-100" />
      </div>
      <div className="flex items-center justify-between border-t border-slate-100 pt-3">
        <div className="h-5 w-16 animate-pulse rounded-full bg-slate-100" />
        <div className="h-4 w-12 animate-pulse rounded bg-slate-100" />
      </div>
    </div>
  );
}

export function BenefitGridSkeleton({ count = 6 }: { count?: number }) {
  return (
    <div className="grid gap-4 sm:grid-cols-2">
      {Array.from({ length: count }).map((_, i) => (
        <BenefitCardSkeleton key={i} />
      ))}
    </div>
  );
}

export function FilterBarSkeleton() {
  return (
    <div className="space-y-4">
      <div>
        <div className="mb-2 h-3 w-10 animate-pulse rounded bg-slate-100" />
        <div className="flex flex-wrap gap-2">
          {Array.from({ length: 6 }).map((_, i) => (
            <div key={i} className="h-8 w-16 animate-pulse rounded-full bg-slate-100" />
          ))}
        </div>
      </div>
      <div>
        <div className="mb-2 h-3 w-14 animate-pulse rounded bg-slate-100" />
        <div className="flex flex-wrap gap-2">
          {Array.from({ length: 4 }).map((_, i) => (
            <div key={i} className="h-8 w-20 animate-pulse rounded-full bg-slate-100" />
          ))}
        </div>
      </div>
    </div>
  );
}

export function PageHeroSkeleton() {
  return (
    <section className="border-b border-slate-200 bg-gradient-to-b from-brand-50/70 via-white to-white">
      <div className="mx-auto max-w-5xl px-4 pb-10 pt-12 sm:px-6 sm:pt-16">
        <div className="mb-3 h-6 w-28 animate-pulse rounded-full bg-white ring-1 ring-inset ring-brand-100" />
        <div className="mb-2 h-8 w-64 animate-pulse rounded bg-slate-200" />
        <div className="h-4 w-80 animate-pulse rounded bg-slate-100" />
      </div>
    </section>
  );
}

export function BenefitDetailSkeleton() {
  return (
    <div>
      <section className="border-b border-slate-200 bg-gradient-to-b from-brand-50/70 via-white to-white">
        <div className="mx-auto max-w-3xl px-4 pb-10 pt-10 sm:px-6">
          <div className="mb-6 h-4 w-32 animate-pulse rounded bg-slate-100" />
          <div className="mb-4 flex items-center gap-3">
            <div className="h-12 w-12 animate-pulse rounded-xl bg-slate-100" />
            <div className="h-7 w-2/3 animate-pulse rounded bg-slate-200" />
          </div>
          <div className="mb-5 space-y-1.5">
            <div className="h-3.5 w-full animate-pulse rounded bg-slate-100" />
            <div className="h-3.5 w-3/4 animate-pulse rounded bg-slate-100" />
          </div>
          <div className="flex flex-wrap gap-2">
            {Array.from({ length: 3 }).map((_, i) => (
              <div key={i} className="h-6 w-20 animate-pulse rounded-full bg-white ring-1 ring-inset ring-slate-200" />
            ))}
          </div>
        </div>
      </section>

      <div className="mx-auto max-w-3xl px-4 py-10 sm:px-6">
        {Array.from({ length: 3 }).map((_, i) => (
          <div key={i} className="mb-5 rounded-2xl bg-white p-6 shadow-card ring-1 ring-slate-100">
            <div className="mb-3 h-4 w-24 animate-pulse rounded bg-slate-200" />
            <div className="space-y-2">
              <div className="h-3.5 w-full animate-pulse rounded bg-slate-100" />
              <div className="h-3.5 w-full animate-pulse rounded bg-slate-100" />
              <div className="h-3.5 w-2/3 animate-pulse rounded bg-slate-100" />
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
