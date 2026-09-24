import { NextRequest, NextResponse } from "next/server";
import { locales, defaultLocale, type Locale } from "@/lib/i18n/config";

const LOCALE_HEADER = "x-locale";
const nonDefaultLocales = locales.filter((l) => l !== defaultLocale);

export function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;
  const segments = pathname.split("/");
  const maybeLocale = segments[1];

  let locale: Locale = defaultLocale;
  let targetPathname = pathname;

  if ((nonDefaultLocales as string[]).includes(maybeLocale)) {
    locale = maybeLocale as Locale;
    targetPathname = "/" + segments.slice(2).join("/");
  }

  const requestHeaders = new Headers(request.headers);
  requestHeaders.set(LOCALE_HEADER, locale);

  if (targetPathname !== pathname) {
    const url = request.nextUrl.clone();
    url.pathname = targetPathname;
    return NextResponse.rewrite(url, { request: { headers: requestHeaders } });
  }

  return NextResponse.next({ request: { headers: requestHeaders } });
}

export const config = {
  matcher: ["/((?!_next/static|_next/image|favicon.ico|icon.svg|robots.txt|sitemap.xml|rss.xml).*)"],
};
