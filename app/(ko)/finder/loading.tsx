export default function FinderLoading() {
  return (
    <div>
      <section className="border-b border-slate-200 bg-gradient-to-b from-brand-50/70 via-white to-white">
        <div className="mx-auto max-w-3xl px-4 pb-10 pt-12 text-center sm:px-6 sm:pt-16">
          <div className="mx-auto mb-3 h-11 w-11 animate-pulse rounded-xl bg-brand-50" />
          <div className="mx-auto mb-2 h-7 w-40 animate-pulse rounded bg-slate-200" />
          <div className="mx-auto h-4 w-72 animate-pulse rounded bg-slate-100" />
        </div>
      </section>
      <div className="mx-auto max-w-2xl px-4 py-10 sm:px-6">
        <div className="space-y-5 rounded-2xl bg-white p-6 shadow-card ring-1 ring-slate-100">
          {Array.from({ length: 4 }).map((_, i) => (
            <div key={i}>
              <div className="mb-1.5 h-4 w-20 animate-pulse rounded bg-slate-100" />
              <div className="h-10 w-full animate-pulse rounded-xl bg-slate-100" />
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
