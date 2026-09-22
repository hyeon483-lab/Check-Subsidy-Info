"use client";

import { useEffect } from "react";
import { addRecentlyViewed } from "@/lib/recentlyViewed";

export default function RecordRecentlyViewed({
  slug,
  title,
  categoryName,
  regionName,
}: {
  slug: string;
  title: string;
  categoryName?: string;
  regionName?: string;
}) {
  useEffect(() => {
    addRecentlyViewed({ slug, title, categoryName, regionName });
  }, [slug, title, categoryName, regionName]);

  return null;
}
