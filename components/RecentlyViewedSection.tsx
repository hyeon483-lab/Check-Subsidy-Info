"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { getRecentlyViewed, RecentlyViewedItem } from "@/lib/recentlyViewed";
import type { Dictionary } from "@/lib/i18n/dictionaryType";
import type { Locale } from "@/lib/i18n/config";
import { localizedHref } from "@/lib/i18n/href";

export default function RecentlyViewedSection({ dict, locale }: { dict: Dictionary; locale: Locale }) {
  const [items, setItems] = useState<RecentlyViewedItem[]>([]);

  useEffect(() => {
    setItems(getRecentlyViewed());
  }, []);

  if (items.length === 0) return null;

  return (
    <section className="mb-12">
      <h2 className="mb-4 text-lg font-bold text-slate-900">{dict.recentlyViewed.heading}</h2>
      <div className="flex gap-3 overflow-x-auto pb-1">
        {items.map((item) => (
          <Link
            key={item.slug}
            href={localizedHref(`/benefits/${item.slug}`, locale)}
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
