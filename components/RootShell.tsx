import Script from "next/script";
import Header from "./Header";
import Footer from "./Footer";
import { siteUrl } from "@/lib/site";
import { localeHtmlLang, type Locale } from "@/lib/i18n/config";
import { getDictionary } from "@/lib/i18n/dictionaries";
import { websiteJsonLd } from "@/lib/i18n/rootMetadata";

const adsenseClientId = process.env.NEXT_PUBLIC_ADSENSE_CLIENT_ID;
const gaMeasurementId = process.env.NEXT_PUBLIC_GA_MEASUREMENT_ID;

/**
 * Shared <html>/<body> shell for both root layouts (app/(ko) and app/[locale]).
 * Next.js allows "multiple root layouts" (one per top-level route group/segment,
 * each defining its own <html>/<body>) as long as there's no single shared
 * app/layout.tsx above them — that's what lets each tree receive its own
 * locale (via a hardcoded value or a real route param) without a headers()
 * lookup, which is what makes these routes cacheable again.
 */
export default function RootShell({ locale, children }: { locale: Locale; children: React.ReactNode }) {
  const dict = getDictionary(locale);
  const siteName = dict.common.siteName;
  const jsonLd = websiteJsonLd(locale);

  return (
    <html lang={localeHtmlLang[locale]}>
      {/* eslint-disable-next-line @next/next/no-head-element -- this *is* the root layout's <head>; the rule only knows to allowlist files literally named layout.tsx, not a shared component rendered from one. */}
      <head>
        <link rel="alternate" type="application/rss+xml" title={`${siteName} RSS`} href={`${siteUrl}/rss.xml`} />
        <link rel="preconnect" href="https://cdn.jsdelivr.net" crossOrigin="anonymous" />
        <link
          rel="stylesheet"
          href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable-dynamic-subset.css"
        />
        {/* next/script defers injection to the client; JSON-LD must be in the
            initial HTML for crawlers that don't execute JS, so use a plain tag. */}
        <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }} />
        {adsenseClientId && (
          <Script
            async
            src={`https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=${adsenseClientId}`}
            crossOrigin="anonymous"
            strategy="afterInteractive"
          />
        )}
        {gaMeasurementId && (
          <>
            <Script
              async
              src={`https://www.googletagmanager.com/gtag/js?id=${gaMeasurementId}`}
              strategy="afterInteractive"
            />
            <Script id="ga4-init" strategy="afterInteractive">
              {`window.dataLayer = window.dataLayer || [];
                function gtag(){dataLayer.push(arguments);}
                gtag('js', new Date());
                gtag('config', '${gaMeasurementId}');`}
            </Script>
          </>
        )}
      </head>
      <body className="flex min-h-screen flex-col font-sans antialiased">
        <Header locale={locale} />
        <main className="flex-1">{children}</main>
        <Footer locale={locale} />
      </body>
    </html>
  );
}
