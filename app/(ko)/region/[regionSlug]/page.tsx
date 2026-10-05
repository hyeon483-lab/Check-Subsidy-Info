import type { Metadata } from "next";
import { regionMetadata, RegionPageContent } from "@/lib/pageContent/region";

export const dynamic = "force-dynamic";

export async function generateMetadata({
  params,
  searchParams,
}: {
  params: Promise<{ regionSlug: string }>;
  searchParams: Promise<{ page?: string }>;
}): Promise<Metadata> {
  const { regionSlug } = await params;
  const { page } = await searchParams;
  return regionMetadata("ko", regionSlug, page);
}

export default async function Page({
  params,
  searchParams,
}: {
  params: Promise<{ regionSlug: string }>;
  searchParams: Promise<{ page?: string }>;
}) {
  const { regionSlug } = await params;
  const { page } = await searchParams;
  return RegionPageContent({ locale: "ko", regionSlug, page });
}
