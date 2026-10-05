import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { isLocale, defaultLocale } from "@/lib/i18n/config";
import { benefitDetailMetadata, BenefitDetailPageContent } from "@/lib/pageContent/benefitDetail";

export const revalidate = 1800;

// Empty array on purpose: this just marks the route as static-generation-eligible
// (dynamicParams defaults to true) so Next.js caches each slug after its first
// render instead of treating the route as always-dynamic. Without this, revalidate
// above has no effect and every request re-renders from scratch.
export async function generateStaticParams() {
  return [];
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string; slug: string }>;
}): Promise<Metadata> {
  const { locale, slug } = await params;
  if (!isLocale(locale) || locale === defaultLocale) return {};
  return benefitDetailMetadata(locale, slug);
}

export default async function Page({ params }: { params: Promise<{ locale: string; slug: string }> }) {
  const { locale, slug } = await params;
  if (!isLocale(locale) || locale === defaultLocale) notFound();
  return BenefitDetailPageContent({ locale, slug });
}
