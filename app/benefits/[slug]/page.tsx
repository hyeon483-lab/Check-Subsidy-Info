import Link from "next/link";
import { notFound } from "next/navigation";
import type { Metadata } from "next";
import { getAllBenefitSlugs, getBenefitBySlug } from "@/lib/data";

export const revalidate = 3600;

export async function generateStaticParams() {
  const slugs = await getAllBenefitSlugs();
  return slugs.map((slug) => ({ slug }));
}

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }): Promise<Metadata> {
  const { slug } = await params;
  const benefit = await getBenefitBySlug(slug);
  if (!benefit) return {};
  return {
    title: benefit.title,
    description: benefit.summary,
  };
}

function formatCondition(benefit: NonNullable<Awaited<ReturnType<typeof getBenefitBySlug>>>) {
  const parts: string[] = [];
  if (benefit.age_min || benefit.age_max) {
    if (benefit.age_min && benefit.age_max && benefit.age_min !== benefit.age_max) {
      parts.push(`만 ${benefit.age_min}~${benefit.age_max}세`);
    } else {
      parts.push(`만 ${benefit.age_min ?? benefit.age_max}세`);
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

  return (
    <div className="mx-auto max-w-3xl px-4 py-10">
      <nav className="mb-6 flex gap-2 text-sm text-gray-500">
        {benefit.region && (
          <Link href={`/region/${benefit.region.slug}`} className="hover:text-brand-600">
            {benefit.region.name}
          </Link>
        )}
        {benefit.category && (
          <>
            <span>/</span>
            <Link href={`/category/${benefit.category.slug}`} className="hover:text-brand-600">
              {benefit.category.name}
            </Link>
          </>
        )}
      </nav>

      <h1 className="mb-3 text-2xl font-bold text-gray-900 md:text-3xl">{benefit.title}</h1>
      <p className="mb-6 text-gray-600">{benefit.summary}</p>

      {conditionTags.length > 0 && (
        <div className="mb-8 flex flex-wrap gap-2">
          {conditionTags.map((tag) => (
            <span key={tag} className="rounded-full bg-gray-100 px-3 py-1 text-xs text-gray-700">
              {tag}
            </span>
          ))}
        </div>
      )}

      <section className="mb-8 rounded-lg border border-gray-200 bg-white p-6">
        <h2 className="mb-2 text-lg font-semibold text-gray-900">지원 대상</h2>
        <p className="whitespace-pre-line text-gray-700">{benefit.eligibility}</p>
      </section>

      <section className="mb-8 rounded-lg border border-gray-200 bg-white p-6">
        <h2 className="mb-2 text-lg font-semibold text-gray-900">지원 내용</h2>
        <p className="whitespace-pre-line text-gray-700">{benefit.support_content}</p>
      </section>

      <section className="mb-8 rounded-lg border border-gray-200 bg-white p-6">
        <h2 className="mb-2 text-lg font-semibold text-gray-900">신청 방법</h2>
        <p className="whitespace-pre-line text-gray-700">{benefit.application_method}</p>
        {benefit.required_documents.length > 0 && (
          <>
            <h3 className="mb-1 mt-4 font-medium text-gray-900">필요 서류</h3>
            <ul className="list-inside list-disc text-gray-700">
              {benefit.required_documents.map((doc) => (
                <li key={doc}>{doc}</li>
              ))}
            </ul>
          </>
        )}
      </section>

      {benefit.checklist.length > 0 && (
        <section className="mb-8 rounded-lg border border-brand-100 bg-brand-50 p-6">
          <h2 className="mb-2 text-lg font-semibold text-brand-700">신청 전 체크리스트</h2>
          <ul className="list-inside list-disc text-gray-700">
            {benefit.checklist.map((item) => (
              <li key={item}>{item}</li>
            ))}
          </ul>
        </section>
      )}

      {benefit.faq.length > 0 && (
        <section className="mb-8">
          <h2 className="mb-3 text-lg font-semibold text-gray-900">자주 묻는 질문</h2>
          <div className="space-y-3">
            {benefit.faq.map((item) => (
              <div key={item.question} className="rounded-lg border border-gray-200 bg-white p-4">
                <p className="mb-1 font-medium text-gray-900">Q. {item.question}</p>
                <p className="text-gray-700">A. {item.answer}</p>
              </div>
            ))}
          </div>
        </section>
      )}

      <section className="mb-8 rounded-lg border border-gray-200 bg-white p-6 text-sm text-gray-600">
        <p>담당 기관: {benefit.agency_name}</p>
        {benefit.agency_url && (
          <p className="mt-1">
            공식 안내:{" "}
            <a
              href={benefit.agency_url}
              target="_blank"
              rel="noopener noreferrer nofollow"
              className="text-brand-600 underline"
            >
              공식 페이지 바로가기
            </a>
          </p>
        )}
        <p className="mt-3 text-xs text-gray-400">
          출처: {benefit.source_name}
          {benefit.source_updated_at ? ` · ${benefit.source_updated_at} 기준` : ""}. 정확한 최신 기준은 반드시
          공식 안내를 다시 확인하세요.
        </p>
      </section>
    </div>
  );
}
