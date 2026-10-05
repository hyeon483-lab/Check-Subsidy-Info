import type { Metadata } from "next";
import RootShell from "@/components/RootShell";
import { rootMetadata } from "@/lib/i18n/rootMetadata";
import "../globals.css";

export function generateMetadata(): Metadata {
  return rootMetadata("ko");
}

export default function KoRootLayout({ children }: { children: React.ReactNode }) {
  return <RootShell locale="ko">{children}</RootShell>;
}
