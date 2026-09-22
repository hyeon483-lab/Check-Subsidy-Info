import type { Metadata } from "next";
import { getBenefits, getCategories, getRegions } from "@/lib/data";
import CalculatorClient from "@/components/CalculatorClient";
import { CalculatorIcon } from "@/components/icons";
import { siteUrl } from "@/lib/site";

// Supabase의 데이터가 DB에 반영되는 즉시(재배포 없이) 사이트에 나타나도록
// 빌드 시점에 굳히는 정적 생성 대신 매 요청마다 새로 렌더링합니다.
export const dynamic = "force-dynamic";

const title = "지원금 계산기";
const description = "거주 지역, 나이, 가구 형태를 입력하면 조건에 맞는 지원금을 바로 찾아드립니다.";

export const metadata: Metadata = {
  title,
  description,
  alternates: { canonical: `${siteUrl}/calculator` },
  openGraph: { title, description, url: `${siteUrl}/calculator` },
};

export default async function CalculatorPage() {
  const [benefits, regions, categories] = await Promise.all([getBenefits({}), getRegions(), getCategories()]);

  return (
    <div>
      <section className="border-b border-slate-200 bg-gradient-to-b from-brand-50/70 via-white to-white">
        <div className="mx-auto max-w-3xl px-4 pb-10 pt-12 text-center sm:px-6 sm:pt-16">
          <span className="mb-3 inline-flex h-11 w-11 items-center justify-center rounded-xl bg-brand-50 text-brand-600">
            <CalculatorIcon className="h-5 w-5" />
          </span>
          <h1 className="mb-2 text-2xl font-bold tracking-tight text-slate-900 sm:text-3xl">지원금 계산기</h1>
          <p className="text-[15px] text-slate-500">
            거주 지역과 나이, 가구 형태를 입력하면 조건에 맞는 지원금을 바로 찾아드립니다.
          </p>
        </div>
      </section>

      <div className="mx-auto max-w-2xl px-4 py-10 sm:px-6">
        <CalculatorClient benefits={benefits} regions={regions} categories={categories} />
      </div>
    </div>
  );
}
