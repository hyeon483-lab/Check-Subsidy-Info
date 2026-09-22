import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "개인정보처리방침",
  description: "내 지원금 찾기의 개인정보처리방침입니다.",
  alternates: { canonical: "/privacy" },
};

export default function PrivacyPage() {
  return (
    <div className="mx-auto max-w-3xl px-4 py-14 sm:px-6">
      <h1 className="mb-6 text-2xl font-bold tracking-tight text-slate-900 sm:text-3xl">개인정보처리방침</h1>
      <div className="space-y-6 rounded-2xl bg-white p-6 text-[15px] leading-relaxed text-slate-600 shadow-card ring-1 ring-slate-100 sm:p-8">
        <section>
          <h2 className="mb-2 text-base font-bold text-slate-900">1. 수집하는 개인정보 항목</h2>
          <p>
            본 사이트는 지원금 조건을 확인하는 과정에서 나이대, 거주 지역, 가구 형태 등을 선택형으로 입력받을 수
            있으며, 이러한 입력값은 서버로 전송되거나 저장되지 않고 이용자의 브라우저 안에서만 사용됩니다.
            문의하기를 통해 연락처를 남기는 경우에는 답변 목적으로만 해당 정보를 사용합니다.
          </p>
        </section>
        <section>
          <h2 className="mb-2 text-base font-bold text-slate-900">2. 쿠키 및 광고</h2>
          <p>
            본 사이트는 Google AdSense를 통해 광고를 게재하며, Google 등 제3자 광고 제공업체는 쿠키를 사용해
            이용자의 이전 방문 또는 다른 사이트 방문 이력을 기반으로 광고를 게재할 수 있습니다. 이용자는
            Google 광고 설정 페이지에서 맞춤 광고를 비활성화할 수 있습니다.
          </p>
        </section>
        <section>
          <h2 className="mb-2 text-base font-bold text-slate-900">3. 개인정보의 보유 및 이용 기간</h2>
          <p>
            문의를 통해 수집한 정보는 답변 완료 후 지체 없이 파기하며, 별도의 회원가입 및 개인정보 저장 기능은
            제공하지 않습니다.
          </p>
        </section>
        <section>
          <h2 className="mb-2 text-base font-bold text-slate-900">4. 문의처</h2>
          <p>개인정보 관련 문의는 문의하기 페이지를 통해 접수해 주세요.</p>
        </section>
        <p className="text-xs text-slate-400">최종 수정일: 2026년 9월</p>
      </div>
    </div>
  );
}
