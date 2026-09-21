import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "사이트 소개",
  description: "내 지원금 찾기 서비스 소개 페이지입니다.",
};

export default function AboutPage() {
  return (
    <div className="mx-auto max-w-3xl px-4 py-10 text-gray-700">
      <h1 className="mb-6 text-2xl font-bold text-gray-900">사이트 소개</h1>
      <div className="space-y-4 leading-relaxed">
        <p>
          &lsquo;내 지원금 찾기&rsquo;는 전국 지자체가 운영하는 결혼, 출산·육아, 청년, 주거 관련 지원 제도를
          한곳에서 비교하고 확인할 수 있도록 정리하는 정보 서비스입니다.
        </p>
        <p>
          지자체마다 제도의 이름과 조건이 조금씩 달라 필요한 지원을 놓치는 경우가 많습니다. 저희는 공공데이터를
          바탕으로 자격 조건, 지원 내용, 신청 방법을 쉬운 말로 요약하고, 신청 전에 확인해야 할 체크리스트를
          함께 제공합니다.
        </p>
        <p>
          다만 이 사이트는 정부 또는 지자체가 운영하는 공식 사이트가 아닙니다. 게재된 정보는 참고용이며, 실제
          신청 전에는 반드시 각 제도의 공식 안내 페이지에서 최신 기준을 확인해야 합니다. 정보가 실제와 다르거나
          최신화가 필요한 경우 문의 페이지를 통해 알려주시면 빠르게 반영하겠습니다.
        </p>
      </div>
    </div>
  );
}
