import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "문의하기",
  description: "정보 오류 제보, 제휴, 광고 문의를 남겨주세요.",
  alternates: { canonical: "/contact" },
};

export default function ContactPage() {
  return (
    <div className="mx-auto max-w-3xl px-4 py-14 sm:px-6">
      <h1 className="mb-6 text-2xl font-bold tracking-tight text-slate-900 sm:text-3xl">문의하기</h1>
      <div className="space-y-4 rounded-2xl bg-white p-6 text-[15px] leading-relaxed text-slate-600 shadow-card ring-1 ring-slate-100 sm:p-8">
        <p>
          지원금 정보 오류 제보, 새로운 지역·제도 추가 요청, 제휴 및 광고 문의는 아래 이메일로 보내주세요.
        </p>
        <p className="rounded-xl bg-brand-50 px-4 py-3 font-medium text-brand-700 ring-1 ring-inset ring-brand-100">
          chriskevin0707@gmail.com
        </p>
      </div>
    </div>
  );
}
