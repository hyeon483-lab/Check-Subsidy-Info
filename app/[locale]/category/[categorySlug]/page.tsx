import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { isLocale, defaultLocale } from "@/lib/i18n/config";
import { categoryMetadata, CategoryPageContent } from "@/lib/pageContent/category";

export const dynamic = "force-dynamic";

export async function generateMetadata({
  params,
  searchParams,
}: {
  params: Promise<{ locale: string; categorySlug: string }>;
  searchParams: Promise<{ page?: string }>;
}): Promise<Metadata> {
  const { locale, categorySlug } = await params;
  if (!isLocale(locale) || locale === defaultLocale) return {};
  const { page } = await searchParams;
  return categoryMetadata(locale, categorySlug, page);
}

export default async function Page({
  params,
  searchParams,
}: {
  params: Promise<{ locale: string; categorySlug: string }>;
  searchParams: Promise<{ page?: string }>;
}) {
  const { locale, categorySlug } = await params;
  if (!isLocale(locale) || locale === defaultLocale) notFound();
  const { page } = await searchParams;
  return CategoryPageContent({ locale, categorySlug, page });
}
