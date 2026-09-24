import { BuildingIcon, ExternalLinkIcon, HeartIcon, YouthIcon } from "./icons";
import type { Dictionary } from "@/lib/i18n/dictionaryType";

export default function OfficialLinks({ dict }: { dict: Dictionary }) {
  const links = [
    {
      href: "https://www.bokjiro.go.kr",
      icon: HeartIcon,
      title: dict.officialLinks.bokjiroTitle,
      description: dict.officialLinks.bokjiroDescription,
    },
    {
      href: "https://www.gov.kr",
      icon: BuildingIcon,
      title: dict.officialLinks.gov24Title,
      description: dict.officialLinks.gov24Description,
    },
    {
      href: "https://www.youthcenter.go.kr",
      icon: YouthIcon,
      title: dict.officialLinks.youthCenterTitle,
      description: dict.officialLinks.youthCenterDescription,
    },
  ];

  return (
    <section>
      <h2 className="mb-1 text-lg font-bold text-slate-900">{dict.home.officialLinksHeading}</h2>
      <p className="mb-4 text-sm text-slate-500">{dict.home.officialLinksDescription}</p>
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
