import { ImageResponse } from "next/og";
import { readFile } from "node:fs/promises";
import { join } from "node:path";
import { getBenefitBySlug } from "@/lib/data";

export const runtime = "nodejs";
export const dynamic = "force-dynamic";
export const size = { width: 1200, height: 630 };
export const contentType = "image/png";

function truncate(text: string, max: number) {
  return text.length > max ? `${text.slice(0, max)}…` : text;
}

export default async function Image({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const benefit = await getBenefitBySlug(slug);

  const title = truncate(benefit?.title ?? "내 지원금 찾기", 40);
  const titleFontSize = title.length > 20 ? 44 : 56;
  const regionName = benefit?.region?.name;
  const categoryName = benefit?.category?.name;

  const [regular, bold] = await Promise.all([
    readFile(join(process.cwd(), "assets/fonts/NotoSansKR-Regular.ttf")),
    readFile(join(process.cwd(), "assets/fonts/NotoSansKR-Bold.ttf")),
  ]);

  return new ImageResponse(
    (
      <div
        style={{
          width: "100%",
          height: "100%",
          display: "flex",
          flexDirection: "column",
          justifyContent: "space-between",
          padding: 64,
          backgroundColor: "#ffffff",
          backgroundImage: "linear-gradient(135deg, #eff6ff 0%, #ffffff 55%)",
          fontFamily: "Noto Sans KR",
        }}
      >
        <div style={{ display: "flex", alignItems: "center", gap: 12 }}>
          <div
            style={{
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              width: 48,
              height: 48,
              borderRadius: 14,
              backgroundColor: "#2563eb",
              color: "#ffffff",
              fontSize: 22,
              fontWeight: 700,
            }}
          >
            내
          </div>
          <div style={{ display: "flex", fontSize: 26, fontWeight: 700, color: "#0f172a" }}>내 지원금 찾기</div>
        </div>

        <div style={{ display: "flex", flexDirection: "column", gap: 22 }}>
          {(regionName || categoryName) && (
            <div style={{ display: "flex", gap: 10 }}>
              {regionName && (
                <div
                  style={{
                    display: "flex",
                    padding: "8px 20px",
                    borderRadius: 999,
                    backgroundColor: "#eff6ff",
                    color: "#1d4ed8",
                    fontSize: 22,
                    fontWeight: 700,
                  }}
                >
                  {regionName}
                </div>
              )}
              {categoryName && (
                <div
                  style={{
                    display: "flex",
                    padding: "8px 20px",
                    borderRadius: 999,
                    backgroundColor: "#fdf2f8",
                    color: "#be185d",
                    fontSize: 22,
                    fontWeight: 700,
                  }}
                >
                  {categoryName}
                </div>
              )}
            </div>
          )}
          <div
            style={{
              display: "flex",
              fontSize: titleFontSize,
              fontWeight: 700,
              color: "#0f172a",
              lineHeight: 1.35,
              maxWidth: 1000,
            }}
          >
            {title}
          </div>
        </div>

        <div style={{ display: "flex", fontSize: 22, color: "#64748b" }}>지역별·생애주기별 정부·지자체 지원금 모음</div>
      </div>
    ),
    {
      ...size,
      fonts: [
        { name: "Noto Sans KR", data: regular, weight: 400, style: "normal" },
        { name: "Noto Sans KR", data: bold, weight: 700, style: "normal" },
      ],
    }
  );
}
