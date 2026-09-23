import { BirthIcon, ChildYouthIcon, GlobeIcon, HousingIcon, MarriageIcon, SeniorIcon, YouthIcon } from "@/components/icons";

export interface CategoryStyle {
  icon: typeof MarriageIcon;
  chip: string;
  iconWrap: string;
}

const styles: Record<string, CategoryStyle> = {
  marriage: {
    icon: MarriageIcon,
    chip: "bg-rose-50 text-rose-700 ring-1 ring-inset ring-rose-100",
    iconWrap: "bg-rose-50 text-rose-600",
  },
  birth: {
    icon: BirthIcon,
    chip: "bg-amber-50 text-amber-700 ring-1 ring-inset ring-amber-100",
    iconWrap: "bg-amber-50 text-amber-600",
  },
  "child-youth": {
    icon: ChildYouthIcon,
    chip: "bg-sky-50 text-sky-700 ring-1 ring-inset ring-sky-100",
    iconWrap: "bg-sky-50 text-sky-600",
  },
  youth: {
    icon: YouthIcon,
    chip: "bg-indigo-50 text-indigo-700 ring-1 ring-inset ring-indigo-100",
    iconWrap: "bg-indigo-50 text-indigo-600",
  },
  housing: {
    icon: HousingIcon,
    chip: "bg-emerald-50 text-emerald-700 ring-1 ring-inset ring-emerald-100",
    iconWrap: "bg-emerald-50 text-emerald-600",
  },
  senior: {
    icon: SeniorIcon,
    chip: "bg-violet-50 text-violet-700 ring-1 ring-inset ring-violet-100",
    iconWrap: "bg-violet-50 text-violet-600",
  },
  multicultural: {
    icon: GlobeIcon,
    chip: "bg-teal-50 text-teal-700 ring-1 ring-inset ring-teal-100",
    iconWrap: "bg-teal-50 text-teal-600",
  },
};

const fallback: CategoryStyle = {
  icon: HousingIcon,
  chip: "bg-slate-100 text-slate-700 ring-1 ring-inset ring-slate-200",
  iconWrap: "bg-slate-100 text-slate-600",
};

export function getCategoryStyle(slug: string | undefined): CategoryStyle {
  if (!slug) return fallback;
  return styles[slug] ?? fallback;
}
