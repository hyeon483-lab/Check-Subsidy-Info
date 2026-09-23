import Link from "next/link";
import { FilterIcon, SearchIcon, TableIcon } from "./icons";

const tools = [
  {
    href: "/search",
    icon: SearchIcon,
    title: "지원금 검색",
    description: "제도명, 지역, 키워드로 원하는 지원금을 바로 찾아보세요.",
    color: "bg-blue-50 text-blue-600",
  },
  {
    href: "/finder",
    icon: FilterIcon,
    title: "맞춤 지원금 찾기",
    description: "지역·나이·가구 형태를 입력하면 조건에 맞는 지원금을 골라드려요.",
    color: "bg-brand-50 text-brand-600",
  },
  {
    href: "/median-income",
    icon: TableIcon,
    title: "기준 중위소득표",
    description: "가구원수·비율별 기준 중위소득 금액을 한 번에 확인하세요.",
    color: "bg-emerald-50 text-emerald-600",
  },
];

export default function ToolsShowcase() {
  return (
    <section>
      <h2 className="mb-4 text-lg font-bold text-slate-900">무료 도구</h2>
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {tools.map((tool) => {
          const Icon = tool.icon;
          return (
            <Link
              key={tool.href}
              href={tool.href}
              className="group flex items-start gap-4 rounded-2xl bg-white p-5 shadow-card ring-1 ring-slate-100 transition hover:-translate-y-0.5 hover:shadow-card-hover"
            >
              <span className={`flex h-12 w-12 shrink-0 items-center justify-center rounded-xl ${tool.color}`}>
                <Icon className="h-6 w-6" />
              </span>
              <div>
                <h3 className="mb-1 font-semibold text-slate-900 transition group-hover:text-brand-700">
                  {tool.title}
                </h3>
                <p className="text-sm leading-relaxed text-slate-500">{tool.description}</p>
              </div>
            </Link>
          );
        })}
      </div>
    </section>
  );
}
