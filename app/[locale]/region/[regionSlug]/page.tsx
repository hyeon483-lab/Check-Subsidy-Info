import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { isLocale, defaultLocale } from "@/lib/i18n/config";
import { regionMetadata, RegionPageContent } from "@/lib/pageContent/region";

export const dynamic = "force-dynamic";

export async function generateMetadata({
  params,
  searchParams,
}: {
  params: Promise<{ locale: string; regionSlug: string }>;
  searchParams: Promise<{ page?: string }>;
}): Promise<Metadata> {
  const { locale, regionSlug } = await params;
  if (!isLocale(locale) || locale === defaultLocale) return {};
  const { page } = await searchParams;
  return regionMetadata(locale, regionSlug, page);
}

export default async function Page({
  params,
  searchParams,
}: {
  params: Promise<{ locale: string; regionSlug: string }>;
  searchParams: Promise<{ page?: string }>;
}) {
  const { locale, regionSlug } = await params;
  if (!isLocale(locale) || locale === defaultLocale) notFound();
  const { page } = await searchParams;
  return RegionPageContent({ locale, regionSlug, page });
}
