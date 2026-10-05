import type { Metadata } from "next";
import { benefitDetailMetadata, BenefitDetailPageContent } from "@/lib/pageContent/benefitDetail";

export const revalidate = 1800;

// Empty array on purpose: this just marks the route as static-generation-eligible
// (dynamicParams defaults to true) so Next.js caches each slug after its first
// render instead of treating the route as always-dynamic. Without this, revalidate
// above has no effect and every request re-renders from scratch.
export async function generateStaticParams() {
  return [];
}

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }): Promise<Metadata> {
  const { slug } = await params;
  return benefitDetailMetadata("ko", slug);
}

export default async function Page({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  return BenefitDetailPageContent({ locale: "ko", slug });
}
