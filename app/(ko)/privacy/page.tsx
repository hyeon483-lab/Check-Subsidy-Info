import type { Metadata } from "next";
import { privacyMetadata, PrivacyPageContent } from "@/lib/pageContent/privacy";

export function generateMetadata(): Metadata {
  return privacyMetadata("ko");
}

export default function Page() {
  return PrivacyPageContent({ locale: "ko" });
}
