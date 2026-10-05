import type { Metadata } from "next";
import { aboutMetadata, AboutPageContent } from "@/lib/pageContent/about";

export function generateMetadata(): Metadata {
  return aboutMetadata("ko");
}

export default function Page() {
  return AboutPageContent({ locale: "ko" });
}
