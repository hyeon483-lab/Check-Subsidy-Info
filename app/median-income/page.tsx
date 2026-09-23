import type { Metadata } from "next";
import {
  medianIncomeAt,
  medianIncomeBase,
  medianIncomePercents,
  medianIncomePerPersonIncrement,
  medianIncomeYear,
} from "@/lib/medianIncome";

export const metadata: Metadata = {
  title: "기준 중위소득표",
  description: `${medianIncomeYear}년 기준 중위소득을 가구원수·비율별로 한눈에 확인하세요.`,
  alternates: { canonical: "/median-income" },
};

const householdSizes = Object.keys(medianIncomeBase).map(Number);

function formatWon(amount: number) {
  return `${amount.toLocaleString("ko-KR")}원`;
}

export default function MedianIncomePage() {
  return (
    <div className="mx-auto max-w-5xl px-4 py-14 sm:px-6">
      <h1 className="mb-3 text-2xl font-bold tracking-tight text-slate-900 sm:text-3xl">
        {medianIncomeYear}년 기준 중위소득표
      </h1>
      <p className="mb-8 max-w-2xl text-[15px] leading-relaxed text-slate-500">
        지원금마다 &ldquo;기준 중위소득 OO% 이하&rdquo;처럼 소득 조건이 다르게 표시되는데, 이 표에서 가구원수와
        비율에 해당하는 실제 월 소득 금액(원)을 바로 확인할 수 있습니다.
      </p>

      <div className="mb-8 overflow-x-auto rounded-2xl bg-white shadow-card ring-1 ring-slate-100">
        <table className="w-full min-w-[860px] border-collapse text-sm">
          <thead>
            <tr className="border-b border-slate-100 bg-slate-50 text-left text-xs font-semibold uppercase tracking-wide text-slate-500">
              <th className="sticky left-0 z-10 w-24 min-w-[6rem] whitespace-nowrap bg-slate-50 px-4 py-3">
                가구원수
              </th>
              {medianIncomePercents.map((percent) => (
                <th key={percent} className="whitespace-nowrap px-4 py-3 text-right">
                  {percent}%
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {householdSizes.map((size, index) => (
              <tr
                key={size}
                className={`border-b border-slate-50 last:border-0 ${index % 2 === 1 ? "bg-slate-50/40" : ""}`}
              >
                <td
                  className={`sticky left-0 z-10 w-24 min-w-[6rem] whitespace-nowrap px-4 py-3 font-medium text-slate-900 ${
                    index % 2 === 1 ? "bg-slate-50" : "bg-white"
                  }`}
                >
                  {size}인 가구
                </td>
                {medianIncomePercents.map((percent) => (
                  <td
                    key={percent}
                    className={`whitespace-nowrap px-4 py-3 text-right tabular-nums text-slate-600 ${
                      percent === 100 ? "font-semibold text-brand-700" : ""
                    }`}
                  >
                    {formatWon(medianIncomeAt(size, percent))}
                  </td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <div className="mb-10 rounded-2xl bg-white p-5 text-sm leading-relaxed text-slate-500 shadow-card ring-1 ring-slate-100 sm:p-6">
        <p className="mb-2">
          <strong className="font-semibold text-slate-700">9인 이상 가구</strong>는 8인 가구 기준액에 1인 늘어날
          때마다 {formatWon(medianIncomePerPersonIncrement)}씩 더해 계산합니다. 예를 들어 9인 가구 100% 기준액은{" "}
          {formatWon(medianIncomeBase[8] + medianIncomePerPersonIncrement)}입니다.
        </p>
        <p>
          이 표는 보건복지부가 고시한 {medianIncomeYear}년 기준 중위소득(100%)을 바탕으로 각 비율을 계산한
          참고용 자료입니다. 실제 지원금 심사에 쓰이는 소득인정액은 소득·재산을 환산해 별도로 산정하므로 이
          표와 차이가 날 수 있습니다. 정확한 판정은 복지로 모의계산이나 신청하려는 지원금의 담당 기관에
          문의해 확인하세요.
        </p>
      </div>

      <p className="text-xs text-slate-400">출처: 보건복지부 {medianIncomeYear}년도 기준 중위소득 고시</p>
    </div>
  );
}
