import type { Metadata } from "next";
import { medianIncomeMetadata, MedianIncomePageContent } from "@/lib/pageContent/medianIncome";

export function generateMetadata(): Metadata {
  return medianIncomeMetadata("ko");
}

export default function Page() {
  return MedianIncomePageContent({ locale: "ko" });
}
