import { HomeLoadingContent } from "@/lib/pageContent/homeLoading";
import { defaultLocale } from "@/lib/i18n/config";

export default function Loading() {
  return HomeLoadingContent({ locale: defaultLocale });
}
