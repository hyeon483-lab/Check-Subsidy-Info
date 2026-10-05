import type { Metadata } from "next";
import { categoryMetadata, CategoryPageContent } from "@/lib/pageContent/category";

export const dynamic = "force-dynamic";

export async function generateMetadata({
  params,
  searchParams,
}: {
  params: Promise<{ categorySlug: string }>;
  searchParams: Promise<{ page?: string }>;
}): Promise<Metadata> {
  const { categorySlug } = await params;
  const { page } = await searchParams;
  return categoryMetadata("ko", categorySlug, page);
}

export default async function Page({
  params,
  searchParams,
}: {
  params: Promise<{ categorySlug: string }>;
  searchParams: Promise<{ page?: string }>;
}) {
  const { categorySlug } = await params;
  const { page } = await searchParams;
  return CategoryPageContent({ locale: "ko", categorySlug, page });
}
