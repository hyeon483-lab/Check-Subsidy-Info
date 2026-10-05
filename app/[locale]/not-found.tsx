import { NotFoundContent } from "@/lib/pageContent/notFound";
import { defaultLocale } from "@/lib/i18n/config";

export default function NotFound() {
  return NotFoundContent({ locale: defaultLocale });
}
