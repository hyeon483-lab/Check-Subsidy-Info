import type { Metadata } from "next";
import { homeMetadata, HomePageContent, type HomeSearchParams } from "@/lib/pageContent/home";

export const dynamic = "force-dynamic";

export async function generateMetadata({
  searchParams,
}: {
  searchParams: Promise<HomeSearchParams>;
}): Promise<Metadata> {
  return homeMetadata("ko", await searchParams);
}

export default async function Page({ searchParams }: { searchParams: Promise<HomeSearchParams> }) {
  return HomePageContent({ locale: "ko", searchParams: await searchParams });
}
