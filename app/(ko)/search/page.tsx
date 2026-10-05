import type { Metadata } from "next";
import { searchMetadata, SearchPageContent } from "@/lib/pageContent/search";

export const dynamic = "force-dynamic";

export async function generateMetadata({
  searchParams,
}: {
  searchParams: Promise<{ q?: string }>;
}): Promise<Metadata> {
  const { q } = await searchParams;
  return searchMetadata("ko", q);
}

export default async function Page({
  searchParams,
}: {
  searchParams: Promise<{ q?: string; page?: string }>;
}) {
  const { q, page } = await searchParams;
  return SearchPageContent({ locale: "ko", q, page });
}
