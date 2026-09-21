import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "이용약관",
  description: "내 지원금 찾기의 이용약관입니다.",
};

export default function TermsPage() {
  return (
    <div className="mx-auto max-w-3xl px-4 py-10 text-gray-700">
      <h1 className="mb-6 text-2xl font-bold text-gray-900">이용약관</h1>
      <div className="space-y-6 leading-relaxed">
        <section>
          <h2 className="mb-2 text-lg font-semibold text-gray-900">1. 서비스의 성격</h2>
          <p>
            본 사이트는 정부·지자체가 공개한 공공데이터를 바탕으로 지원 제도 정보를 정리해 제공하는 민간
            정보 서비스이며, 정부 또는 지자체가 운영하는 공식 사이트가 아닙니다.
          </p>
        </section>
        <section>
          <h2 className="mb-2 text-lg font-semibold text-gray-900">2. 정보의 정확성</h2>
          <p>
            게재된 지원금 정보는 참고용이며, 제도 개편이나 예산 소진 등으로 실제 내용과 차이가 있을 수
            있습니다. 신청 전에는 반드시 각 제도의 공식 안내 페이지 또는 담당 기관을 통해 최신 정보를
            확인해야 하며, 본 사이트 정보만을 근거로 발생한 불이익에 대해 책임지지 않습니다.
          </p>
        </section>
        <section>
          <h2 className="mb-2 text-lg font-semibold text-gray-900">3. 외부 링크</h2>
          <p>
            본 사이트는 각 지원 제도의 공식 신청 페이지로 연결되는 외부 링크를 제공할 수 있으며, 외부
            사이트의 내용에 대해서는 책임지지 않습니다.
          </p>
        </section>
        <section>
          <h2 className="mb-2 text-lg font-semibold text-gray-900">4. 약관의 변경</h2>
          <p>본 약관은 서비스 운영상 필요에 따라 사전 고지 후 변경될 수 있습니다.</p>
        </section>
        <p className="text-sm text-gray-400">최종 수정일: 2026년 9월</p>
      </div>
    </div>
  );
}
