import { renderBenefitOgImage, size, contentType, alt } from "@/lib/pageContent/benefitOgImage";

export const runtime = "nodejs";
export const revalidate = 86400;
export { size, contentType, alt };

export default async function Image({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  return renderBenefitOgImage(slug);
}
