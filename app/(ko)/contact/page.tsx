import type { Metadata } from "next";
import { contactMetadata, ContactPageContent } from "@/lib/pageContent/contact";

export function generateMetadata(): Metadata {
  return contactMetadata("ko");
}

export default function Page() {
  return ContactPageContent({ locale: "ko" });
}
