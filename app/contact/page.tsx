import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "문의하기",
  description: "정보 오류 제보, 제휴, 광고 문의를 남겨주세요.",
};

export default function ContactPage() {
  return (
    <div className="mx-auto max-w-3xl px-4 py-10 text-gray-700">
      <h1 className="mb-6 text-2xl font-bold text-gray-900">문의하기</h1>
      <div className="space-y-4 leading-relaxed">
        <p>
          지원금 정보 오류 제보, 새로운 지역·제도 추가 요청, 제휴 및 광고 문의는 아래 이메일로 보내주세요.
        </p>
        <p className="rounded-lg border border-gray-200 bg-white p-4 font-medium text-brand-700">
          contact@example.com
        </p>
        <p className="text-sm text-gray-500">
          * 실제 운영 시 이 이메일 주소를 도메인 연결 후의 운영 계정으로 교체하세요.
        </p>
      </div>
    </div>
  );
}
