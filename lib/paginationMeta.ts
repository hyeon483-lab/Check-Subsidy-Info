import type { Metadata } from "next";
import { siteUrl } from "./site";

/**
 * 페이지네이션에서 "page" 파라미터는 콘텐츠 자체가 아니라 같은 목록의
 * 몇 번째 화면인지를 나타낼 뿐이라, 구글의 일반적인 권장 방식대로 항상
 * 1페이지(파라미터 없는 기본 URL)를 canonical로 두고, 2페이지 이상은
 * 색인에서 제외(noindex, follow)합니다. 링크는 계속 따라가므로 개별
 * 지원금 페이지 크롤링에는 영향이 없습니다. region/category처럼 콘텐츠
 * 자체가 달라지는 필터 파라미터는 canonical에 그대로 유지합니다.
 */
export function paginationMetadata(
  basePath: string,
  params: Record<string, string | undefined>,
  currentPage: number,
  languages?: Record<string, string>
): Pick<Metadata, "alternates" | "robots"> {
  const search = new URLSearchParams();
  for (const [key, value] of Object.entries(params)) {
    if (value) search.set(key, value);
  }
  const qs = search.toString();
  const url = `${siteUrl}${basePath}${qs ? `?${qs}` : ""}`;

  return {
    alternates: { canonical: url, languages },
    robots: currentPage > 1 ? { index: false, follow: true } : undefined,
  };
}
