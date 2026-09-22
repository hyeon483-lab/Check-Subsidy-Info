export interface RecentlyViewedItem {
  slug: string;
  title: string;
  categoryName?: string;
  regionName?: string;
  viewedAt: number;
}

const STORAGE_KEY = "recentlyViewedBenefits";
const MAX_ITEMS = 8;

export function getRecentlyViewed(): RecentlyViewedItem[] {
  if (typeof window === "undefined") return [];
  try {
    const raw = window.localStorage.getItem(STORAGE_KEY);
    if (!raw) return [];
    const parsed = JSON.parse(raw);
    return Array.isArray(parsed) ? parsed : [];
  } catch {
    return [];
  }
}

export function addRecentlyViewed(item: Omit<RecentlyViewedItem, "viewedAt">): void {
  if (typeof window === "undefined") return;
  try {
    const existing = getRecentlyViewed().filter((i) => i.slug !== item.slug);
    const updated = [{ ...item, viewedAt: Date.now() }, ...existing].slice(0, MAX_ITEMS);
    window.localStorage.setItem(STORAGE_KEY, JSON.stringify(updated));
  } catch {
    // 프라이빗 브라우징 등으로 localStorage를 쓸 수 없으면 조용히 무시합니다.
  }
}
