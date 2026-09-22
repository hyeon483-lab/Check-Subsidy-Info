import { BuildingIcon, ExternalLinkIcon, HeartIcon, YouthIcon } from "./icons";

const links = [
  {
    href: "https://www.bokjiro.go.kr",
    icon: HeartIcon,
    title: "복지로",
    description: "복지 서비스 통합 검색 및 온라인 신청",
  },
  {
    href: "https://www.gov.kr",
    icon: BuildingIcon,
    title: "정부24",
    description: "정부 민원·서비스 통합 포털",
  },
  {
    href: "https://www.youthcenter.go.kr",
    icon: YouthIcon,
    title: "온통청년",
    description: "청년정책 통합 정보 플랫폼",
  },
];

export default function OfficialLinks() {
  return (
    <section>
      <h2 className="mb-1 text-lg font-bold text-slate-900">공식 사이트 바로가기</h2>
      <p className="mb-4 text-sm text-slate-500">정부 지원금 확인을 위한 공식 포털 사이트입니다.</p>
      <div className="grid gap-4 sm:grid-cols-3">
        {links.map((link) => {
          const Icon = link.icon;
          return (
            <a
              key={link.href}
              href={link.href}
              target="_blank"
              rel="noopener noreferrer nofollow"
              className="group flex items-start gap-3 rounded-2xl bg-white p-5 shadow-card ring-1 ring-slate-100 transition hover:-translate-y-0.5 hover:shadow-card-hover"
            >
              <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-slate-100 text-slate-500">
                <Icon className="h-5 w-5" />
              </span>
              <div className="flex-1">
                <div className="mb-1 flex items-center gap-1 font-semibold text-slate-900 transition group-hover:text-brand-700">
                  {link.title}
                  <ExternalLinkIcon className="h-3.5 w-3.5 text-slate-300 transition group-hover:text-brand-600" />
                </div>
                <p className="text-sm leading-relaxed text-slate-500">{link.description}</p>
              </div>
            </a>
          );
        })}
      </div>
    </section>
  );
}
