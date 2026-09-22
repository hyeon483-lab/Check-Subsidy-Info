import Link from "next/link";
import { Category } from "@/lib/types";
import { getCategoryStyle } from "@/lib/categoryStyle";

export default function CategoryGrid({ categories }: { categories: (Category & { count: number })[] }) {
  return (
    <section>
      <h2 className="mb-4 text-lg font-bold text-slate-900">카테고리별로 둘러보기</h2>
      <div className="grid grid-cols-2 gap-4 sm:grid-cols-4">
        {categories.map((category) => {
          const style = getCategoryStyle(category.slug);
          const Icon = style.icon;
          return (
            <Link
              key={category.id}
              href={`/category/${category.slug}`}
              className="group flex flex-col items-center gap-2.5 rounded-2xl bg-white p-5 text-center shadow-card ring-1 ring-slate-100 transition hover:-translate-y-0.5 hover:shadow-card-hover"
            >
              <span className={`flex h-11 w-11 items-center justify-center rounded-xl ${style.iconWrap}`}>
                <Icon className="h-5 w-5" />
              </span>
              <span className="font-semibold text-slate-900 transition group-hover:text-brand-700">
                {category.name}
              </span>
              <span className="text-xs font-medium text-slate-400">{category.count}건</span>
            </Link>
          );
        })}
      </div>
    </section>
  );
}
