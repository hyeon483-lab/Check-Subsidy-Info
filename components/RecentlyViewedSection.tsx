"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { getRecentlyViewed, RecentlyViewedItem } from "@/lib/recentlyViewed";

export default function RecentlyViewedSection() {
  const [items, setItems] = useState<RecentlyViewedItem[]>([]);

  useEffect(() => {
    setItems(getRecentlyViewed());
  }, []);

  if (items.length === 0) return null;

  return (
    <section className="mb-12">
      <h2 className="mb-4 text-lg font-bold text-slate-900">최근 본 지원금</h2>
      <div className="flex gap-3 overflow-x-auto pb-1">
        {items.map((item) => (
          <Link
            key={item.slug}
            href={`/benefits/${item.slug}`}
            className="w-56 shrink-0 rounded-2xl bg-white p-4 shadow-card ring-1 ring-slate-100 transition hover:-translate-y-0.5 hover:shadow-card-hover"
          >
            {(item.regionName || item.categoryName) && (
              <p className="mb-1 text-xs font-medium text-slate-400">
                {[item.regionName, item.categoryName].filter(Boolean).join(" · ")}
              </p>
            )}
            <p className="line-clamp-2 text-sm font-semibold text-slate-900">{item.title}</p>
          </Link>
        ))}
      </div>
    </section>
  );
}
