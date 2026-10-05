import type { Metadata } from "next";
import { termsMetadata, TermsPageContent } from "@/lib/pageContent/terms";

export function generateMetadata(): Metadata {
  return termsMetadata("ko");
}

export default function Page() {
  return TermsPageContent({ locale: "ko" });
}
