import { headers } from "next/headers";
import { defaultLocale, isLocale, type Locale } from "./config";

export const LOCALE_HEADER = "x-locale";

export async function getLocale(): Promise<Locale> {
  const store = await headers();
  const value = store.get(LOCALE_HEADER);
  return isLocale(value) ? value : defaultLocale;
}
