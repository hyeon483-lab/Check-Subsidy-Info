import { ImageResponse } from "next/og";
import { readFile } from "node:fs/promises";
import { join } from "node:path";

export const runtime = "nodejs";
export const size = { width: 1200, height: 630 };
export const contentType = "image/png";
export const alt = "내 지원금 찾기 - 지역별 정부·지자체 지원금 모음";

export default async function Image() {
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
          alignItems: "center",
          justifyContent: "center",
          backgroundColor: "#f8fafc",
          backgroundImage: "linear-gradient(135deg, #eff6ff 0%, #f8fafc 60%)",
          fontFamily: "Noto Sans KR",
        }}
      >
        <div style={{ display: "flex", alignItems: "center", gap: 20, marginBottom: 36 }}>
          <div
            style={{
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              width: 84,
              height: 84,
              borderRadius: 24,
              backgroundColor: "#2563eb",
            }}
          >
            <svg width="46" height="46" viewBox="0 0 24 24">
              <path
                d="M12 21s7-7.373 7-12a7 7 0 1 0-14 0c0 4.627 7 12 7 12z"
                fill="white"
              />
              <circle cx="12" cy="9" r="2.6" fill="#2563eb" />
            </svg>
          </div>
          <div style={{ display: "flex", fontSize: 48, fontWeight: 700, color: "#0f172a" }}>내 지원금 찾기</div>
        </div>
        <div style={{ display: "flex", fontSize: 30, color: "#475569", textAlign: "center", maxWidth: 860 }}>
          결혼·출산·아동청소년·청년·주거·어르신·다문화 지원금을 지역별로 한눈에 찾아보세요
        </div>
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
