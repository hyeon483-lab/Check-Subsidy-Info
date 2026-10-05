import type { Metadata } from "next";
import { notFound } from "next/navigation";
import RootShell from "@/components/RootShell";
import { rootMetadata } from "@/lib/i18n/rootMetadata";
import { locales, defaultLocale, isLocale } from "@/lib/i18n/config";
import "../globals.css";

const nonDefaultLocales = locales.filter((l) => l !== defaultLocale);

export function generateStaticParams() {
  return nonDefaultLocales.map((locale) => ({ locale }));
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  if (!isLocale(locale) || locale === defaultLocale) return {};
  return rootMetadata(locale);
}

export default async function LocaleRootLayout({
  children,
  params,
}: {
  children: React.ReactNode;
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  if (!isLocale(locale) || locale === defaultLocale) notFound();
  return <RootShell locale={locale}>{children}</RootShell>;
}
