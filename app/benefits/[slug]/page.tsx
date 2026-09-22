import Link from "next/link";
import { notFound } from "next/navigation";
import type { Metadata } from "next";
import { getBenefitBySlug, getBenefitHistory } from "@/lib/data";
import { getCategoryStyle } from "@/lib/categoryStyle";
import { BuildingIcon, CheckIcon, DocumentIcon, RegionIcon } from "@/components/icons";
import { siteUrl } from "@/lib/site";
import TableOfContents from "@/components/TableOfContents";
import ScrollTopButton from "@/components/ScrollTopButton";
import AdSlot from "@/components/AdSlot";

// Supabase의 데이터가 DB에 반영되는 즉시(재배포 없이) 사이트에 나타나도록
// 빌드 시점에 굳히는 정적 생성 대신 매 요청마다 새로 렌더링합니다.
export const dynamic = "force-dynamic";

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }): Promise<Metadata> {
  const { slug } = await params;
  const benefit = await getBenefitBySlug(slug);
  if (!benefit) return {};
  const url = `${siteUrl}/benefits/${benefit.slug}`;
  return {
    title: benefit.title,
    description: benefit.summary,
    alternates: { canonical: url },
    openGraph: {
      type: "article",
      title: benefit.title,
      description: benefit.summary,
      url,
      modifiedTime: benefit.source_updated_at ?? undefined,
    },
    twitter: {
      card: "summary",
      title: benefit.title,
      description: benefit.summary,
    },
  };
}

function formatCondition(benefit: NonNullable<Awaited<ReturnType<typeof getBenefitBySlug>>>) {
  const parts: string[] = [];
  const hasMin = benefit.age_min !== null && benefit.age_min !== undefined;
  const hasMax = benefit.age_max !== null && benefit.age_max !== undefined;
  if (hasMin || hasMax) {
    if (hasMin && hasMax && benefit.age_min !== benefit.age_max) {
      parts.push(`만 ${benefit.age_min}~${benefit.age_max}세`);
    } else {
      parts.push(`만 ${hasMin ? benefit.age_min : benefit.age_max}세`);
    }
  }
  if (benefit.household_type) parts.push(benefit.household_type);
  if (benefit.income_condition) parts.push(benefit.income_condition);
  return parts;
}

export default async function BenefitDetailPage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const benefit = await getBenefitBySlug(slug);
  if (!benefit) notFound();

  const conditionTags = formatCondition(benefit);
  const style = getCategoryStyle(benefit.category?.slug);
  const Icon = style.icon;
  const history = await getBenefitHistory(benefit.program_slug);
  const currentVersion = history.find((h) => h.is_current);
  const pageUrl = `${siteUrl}/benefits/${benefit.slug}`;

  const tocItems = [
    { id: "eligibility", label: "지원 대상" },
    { id: "support-content", label: "지원 내용" },
    { id: "application-method", label: "신청 방법" },
    ...(benefit.checklist.length > 0 ? [{ id: "checklist", label: "신청 전 체크리스트" }] : []),
    ...(benefit.faq.length > 0 ? [{ id: "faq", label: "자주 묻는 질문" }] : []),
  ];

  const breadcrumbJsonLd = {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    itemListElement: [
      { "@type": "ListItem", position: 1, name: "홈", item: siteUrl },
      ...(benefit.region
        ? [{ "@type": "ListItem", position: 2, name: benefit.region.name, item: `${siteUrl}/region/${benefit.region.slug}` }]
        : []),
      ...(benefit.category
        ? [
            {
              "@type": "ListItem",
              position: benefit.region ? 3 : 2,
              name: benefit.category.name,
              item: `${siteUrl}/category/${benefit.category.slug}`,
            },
          ]
        : []),
      {
        "@type": "ListItem",
        position: (benefit.region ? 1 : 0) + (benefit.category ? 1 : 0) + 2,
        name: benefit.title,
        item: pageUrl,
      },
    ],
  };

  const serviceJsonLd = {
    "@context": "https://schema.org",
    "@type": "GovernmentService",
    name: benefit.title,
    description: benefit.summary,
    url: pageUrl,
    serviceType: benefit.category?.name,
    areaServed: benefit.region
      ? { "@type": "AdministrativeArea", name: benefit.region.name }
      : undefined,
    provider: {
      "@type": "GovernmentOrganization",
      name: benefit.agency_name,
      url: benefit.agency_url ?? undefined,
    },
  };

  const faqJsonLd =
    benefit.faq.length > 0
      ? {
          "@context": "https://schema.org",
          "@type": "FAQPage",
          mainEntity: benefit.faq.map((item) => ({
            "@type": "Question",
            name: item.question,
            acceptedAnswer: { "@type": "Answer", text: item.answer },
          })),
        }
      : null;

  return (
    <div>
      {/* next/script defers injection to the client; JSON-LD must be in the
          initial HTML for crawlers that don't execute JS, so use plain tags. */}
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(breadcrumbJsonLd) }} />
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(serviceJsonLd) }} />
      {faqJsonLd && (
        <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(faqJsonLd) }} />
      )}
      {!benefit.is_current && currentVersion && (
        <div className="bg-amber-50">
          <div className="mx-auto flex max-w-3xl flex-wrap items-center justify-between gap-2 px-4 py-3 text-sm text-amber-800 sm:px-6">
            <span>이 페이지는 {benefit.fiscal_year}년도 종료된 정보입니다. 신청에는 사용할 수 없습니다.</span>
            <Link href={`/benefits/${currentVersion.slug}`} className="shrink-0 font-semibold underline">
              최신({currentVersion.fiscal_year}년) 정보 보기 →
            </Link>
          </div>
        </div>
      )}

      <section className="border-b border-slate-200 bg-gradient-to-b from-brand-50/70 via-white to-white">
        <div className="mx-auto max-w-3xl px-4 pb-10 pt-10 sm:px-6">
          <nav className="mb-6 flex items-center gap-2 text-sm text-slate-500">
            {benefit.region && (
              <Link href={`/region/${benefit.region.slug}`} className="inline-flex items-center gap-1 hover:text-brand-700">
                <RegionIcon className="h-3.5 w-3.5" />
                {benefit.region.name}
              </Link>
            )}
            {benefit.category && (
              <>
                <span className="text-slate-300">/</span>
                <Link href={`/category/${benefit.category.slug}`} className="hover:text-brand-700">
                  {benefit.category.name}
                </Link>
              </>
            )}
          </nav>

          <div className="mb-4 flex items-center gap-3">
            <span className={`flex h-12 w-12 shrink-0 items-center justify-center rounded-xl ${style.iconWrap}`}>
              <Icon className="h-6 w-6" />
            </span>
            <h1 className="text-2xl font-bold leading-snug tracking-tight text-slate-900 sm:text-3xl">
              {benefit.title}
            </h1>
          </div>
          <p className="mb-5 text-[15px] leading-relaxed text-slate-500">{benefit.summary}</p>

          {conditionTags.length > 0 && (
            <div className="mb-4 flex flex-wrap gap-2">
              {conditionTags.map((tag) => (
                <span
                  key={tag}
                  className="rounded-full bg-white px-3 py-1 text-xs font-medium text-slate-600 ring-1 ring-inset ring-slate-200"
                >
                  {tag}
                </span>
              ))}
            </div>
          )}

          {history.length > 1 && (
            <div className="flex flex-wrap items-center gap-2">
              <span className="text-xs font-semibold uppercase tracking-wide text-slate-400">연도별 보기</span>
              {history.map((h) => {
                const active = h.slug === benefit.slug;
                return (
                  <Link
                    key={h.slug}
                    href={`/benefits/${h.slug}`}
                    className={`rounded-full px-2.5 py-1 text-xs font-medium transition ${
                      active
                        ? "bg-slate-900 text-white"
                        : "bg-white text-slate-500 ring-1 ring-inset ring-slate-200 hover:bg-slate-50"
                    }`}
                  >
                    {h.fiscal_year}년
                  </Link>
                );
              })}
            </div>
          )}
        </div>
      </section>

      <div className="mx-auto max-w-3xl px-4 py-10 sm:px-6">
        <TableOfContents items={tocItems} />

        <section id="eligibility" className="mb-5 scroll-mt-24 rounded-2xl bg-white p-6 shadow-card ring-1 ring-slate-100">
          <h2 className="mb-2.5 text-base font-bold text-slate-900">지원 대상</h2>
          <p className="whitespace-pre-line text-[15px] leading-relaxed text-slate-600">{benefit.eligibility}</p>
        </section>

        <section id="support-content" className="mb-5 scroll-mt-24 rounded-2xl bg-white p-6 shadow-card ring-1 ring-slate-100">
          <h2 className="mb-2.5 text-base font-bold text-slate-900">지원 내용</h2>
          <p className="whitespace-pre-line text-[15px] leading-relaxed text-slate-600">{benefit.support_content}</p>
        </section>

        <section id="application-method" className="mb-5 scroll-mt-24 rounded-2xl bg-white p-6 shadow-card ring-1 ring-slate-100">
          <h2 className="mb-2.5 text-base font-bold text-slate-900">신청 방법</h2>
          <p className="whitespace-pre-line text-[15px] leading-relaxed text-slate-600">{benefit.application_method}</p>
          {benefit.required_documents.length > 0 && (
            <div className="mt-4 border-t border-slate-100 pt-4">
              <h3 className="mb-2 flex items-center gap-1.5 text-sm font-semibold text-slate-700">
                <DocumentIcon className="h-4 w-4 text-slate-400" />
                필요 서류
              </h3>
              <ul className="space-y-1.5">
                {benefit.required_documents.map((doc) => (
                  <li key={doc} className="flex items-start gap-2 text-sm text-slate-600">
                    <span className="mt-2 h-1 w-1 shrink-0 rounded-full bg-slate-300" />
                    {doc}
                  </li>
                ))}
              </ul>
            </div>
          )}
        </section>

        {benefit.checklist.length > 0 && (
          <section id="checklist" className="mb-5 scroll-mt-24 rounded-2xl bg-brand-50/60 p-6 ring-1 ring-inset ring-brand-100">
            <h2 className="mb-3 text-base font-bold text-brand-900">신청 전 체크리스트</h2>
            <ul className="space-y-2.5">
              {benefit.checklist.map((item) => (
                <li key={item} className="flex items-start gap-2 text-[15px] text-slate-700">
                  <CheckIcon className="mt-0.5 h-4 w-4 shrink-0 text-brand-600" />
                  {item}
                </li>
              ))}
            </ul>
          </section>
        )}

        {benefit.faq.length > 0 && (
          <section id="faq" className="mb-5 scroll-mt-24">
            <h2 className="mb-3 text-base font-bold text-slate-900">자주 묻는 질문</h2>
            <div className="space-y-2.5">
              {benefit.faq.map((item) => (
                <div key={item.question} className="rounded-2xl bg-white p-4 shadow-card ring-1 ring-slate-100">
                  <p className="mb-1 text-sm font-semibold text-slate-900">Q. {item.question}</p>
                  <p className="text-sm leading-relaxed text-slate-600">A. {item.answer}</p>
                </div>
              ))}
            </div>
          </section>
        )}

        <AdSlot slot={process.env.NEXT_PUBLIC_ADSENSE_SLOT_ARTICLE} className="mb-5" />

        <section className="rounded-2xl border border-slate-200 bg-white p-6">
          <div className="mb-1 flex items-center gap-2 text-sm text-slate-600">
            <BuildingIcon className="h-4 w-4 text-slate-400" />
            담당 기관: {benefit.agency_name}
          </div>
          {benefit.agency_url && (
            <a
              href={benefit.agency_url}
              target="_blank"
              rel="noopener noreferrer nofollow"
              className="mt-3 inline-flex items-center gap-1.5 rounded-full bg-brand-600 px-4 py-2 text-sm font-medium text-white transition hover:bg-brand-700"
            >
              공식 페이지에서 확인하기
            </a>
          )}
          <p className="mt-4 text-xs leading-relaxed text-slate-400">
            출처: {benefit.source_name}
            {benefit.source_updated_at ? ` · ${benefit.source_updated_at} 기준` : ""}. 정확한 최신 기준은 반드시
            공식 안내를 다시 확인하세요.
          </p>
        </section>
      </div>

      <ScrollTopButton />
    </div>
  );
}
