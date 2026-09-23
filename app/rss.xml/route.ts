import { getBenefits } from "@/lib/data";
import { siteUrl } from "@/lib/site";

// Supabase 데이터가 바뀌면 재배포 없이 즉시 반영되도록 매 요청마다 새로 생성합니다.
export const dynamic = "force-dynamic";

const siteName = "내 지원금 찾기";
const feedDescription = "결혼, 출산·육아, 아동·청소년, 청년, 주거, 어르신, 다문화 등 지역별 정부·지자체 지원금 최신 정보";

function escapeXml(text: string): string {
  return text
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&apos;");
}

export async function GET() {
  const benefits = await getBenefits({});

  const sorted = [...benefits].sort((a, b) => {
    const aTime = a.source_updated_at ? new Date(a.source_updated_at).getTime() : 0;
    const bTime = b.source_updated_at ? new Date(b.source_updated_at).getTime() : 0;
    return bTime - aTime;
  });

  const items = sorted
    .slice(0, 50)
    .map((benefit) => {
      const link = `${siteUrl}/benefits/${benefit.slug}`;
      const pubDate = new Date(benefit.source_updated_at ?? Date.now()).toUTCString();
      const category = benefit.category?.name;
      return `    <item>
      <title>${escapeXml(benefit.title)}</title>
      <link>${link}</link>
      <guid isPermaLink="true">${link}</guid>
      <description>${escapeXml(benefit.summary)}</description>
      ${category ? `<category>${escapeXml(category)}</category>` : ""}
      <pubDate>${pubDate}</pubDate>
    </item>`;
    })
    .join("\n");

  const xml = `<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
  <channel>
    <title>${siteName} - 최신 지원금 정보</title>
    <link>${siteUrl}</link>
    <description>${feedDescription}</description>
    <language>ko-KR</language>
    <lastBuildDate>${new Date().toUTCString()}</lastBuildDate>
${items}
  </channel>
</rss>`;

  return new Response(xml, {
    headers: {
      "Content-Type": "application/rss+xml; charset=utf-8",
    },
  });
}
