export default function HomeIntro() {
  return (
    <section className="mb-16 rounded-2xl bg-white p-6 shadow-card ring-1 ring-slate-100 sm:p-8">
      <h2 className="mb-4 text-lg font-bold text-slate-900">내 지원금 찾기는 이런 서비스입니다</h2>
      <div className="space-y-4 text-[15px] leading-relaxed text-slate-600">
        <p>
          전국 17개 시·도와 일부 시·군·구가 운영하는 결혼, 출산·육아, 아동·청소년, 청년, 주거, 어르신 지원 제도는
          지자체마다 이름과 조건이 제각각이라 정작 내가 받을 수 있는 지원금을 놓치기 쉽습니다.
          내 지원금 찾기는 각 지자체의 공식 공고와 공공데이터를 바탕으로 자격 조건, 지원 금액,
          신청 방법을 쉬운 말로 정리해 한곳에서 비교하고 확인할 수 있도록 만든 정보 서비스입니다.
        </p>
        <p>
          지역과 카테고리로 필터링해 둘러보거나, 검색으로 원하는 제도를 바로 찾을 수 있고,
          거주 지역·나이·가구 형태를 입력하면 조건에 맞는 지원금만 골라주는{" "}
          <a href="/finder" className="font-medium text-brand-700 hover:underline">
            맞춤 지원금 찾기
          </a>{" "}
          기능도 무료로 제공합니다. 신청 전 확인할 서류와 체크리스트, 자주 묻는 질문까지 각
          지원금 페이지에 함께 정리되어 있어 처음 신청하는 분도 어렵지 않게 준비할 수 있습니다.
        </p>
        <p>
          다만 내 지원금 찾기는 정부나 지자체가 운영하는 공식 사이트가 아닙니다. 지원 제도는
          예산 소진이나 조례 개정으로 수시로 바뀔 수 있으니, 실제 신청 전에는 반드시 각 페이지에
          안내된 담당 기관의 공식 링크에서 최신 기준을 다시 확인해주세요.
        </p>
      </div>
    </section>
  );
}
