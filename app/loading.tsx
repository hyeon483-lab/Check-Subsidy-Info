import { BenefitGridSkeleton, FilterBarSkeleton } from "@/components/skeletons";

export default function HomeLoading() {
  return (
    <div>
      <section className="border-b border-slate-200 bg-gradient-to-b from-brand-50/70 via-white to-white">
        <div className="mx-auto max-w-5xl px-4 pb-10 pt-14 text-center sm:px-6 sm:pt-20">
          <span className="mb-4 inline-block rounded-full bg-white px-3 py-1 text-xs font-semibold text-brand-700 ring-1 ring-inset ring-brand-100">
            지역별 · 생애주기별 지원금 정보
          </span>
          <h1 className="mx-auto mb-3 max-w-2xl text-3xl font-bold leading-tight tracking-tight text-slate-900 sm:text-4xl">
            우리 동네 지원금,
            <br />
            한눈에 찾아보세요
          </h1>
          <p className="mx-auto max-w-xl text-[15px] leading-relaxed text-slate-500">
            결혼, 출산·육아, 아동·청소년, 청년, 주거, 어르신, 다문화 등 생애 이벤트에 맞는 정부·지자체 지원금과 혜택을 지역별로 정리했습니다.
          </p>
        </div>
      </section>

      <div className="mx-auto max-w-5xl px-4 py-10 sm:px-6">
        <div className="mb-8 rounded-2xl bg-white p-5 shadow-card ring-1 ring-slate-100 sm:-mt-6">
          <FilterBarSkeleton />
        </div>
        <BenefitGridSkeleton />
      </div>
    </div>
  );
}
