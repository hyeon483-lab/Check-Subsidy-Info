import type { Metadata } from "next";
import { finderMetadata, FinderPageContent } from "@/lib/pageContent/finder";

export const revalidate = 1800;

export function generateMetadata(): Metadata {
  return finderMetadata("ko");
}

export default function Page() {
  return FinderPageContent({ locale: "ko" });
}
