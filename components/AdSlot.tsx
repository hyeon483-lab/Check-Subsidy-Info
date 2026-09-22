"use client";

import { useEffect, useRef } from "react";

/**
 * AdSense 승인 전(클라이언트 ID/슬롯 ID 미설정)에는 아무것도 렌더링하지
 * 않습니다. 승인 후 NEXT_PUBLIC_ADSENSE_CLIENT_ID와 슬롯 ID를 환경변수로
 * 채우기만 하면 재배포 없이(Vercel 환경변수는 재배포가 필요하지만, 코드
 * 수정 없이) 광고가 노출되도록 미리 배선해 둔 컴포넌트입니다.
 */
export default function AdSlot({
  slot,
  format = "auto",
  className = "",
}: {
  slot: string | undefined;
  format?: string;
  className?: string;
}) {
  const clientId = process.env.NEXT_PUBLIC_ADSENSE_CLIENT_ID;
  const insRef = useRef<HTMLModElement>(null);

  useEffect(() => {
    if (!clientId || !slot) return;
    try {
      const w = window as typeof window & { adsbygoogle?: unknown[] };
      (w.adsbygoogle = w.adsbygoogle || []).push({});
    } catch {
      // 광고 차단기 등으로 adsbygoogle 스크립트가 없을 수 있어 조용히 무시합니다.
    }
  }, [clientId, slot]);

  if (!clientId || !slot) return null;

  return (
    <ins
      ref={insRef}
      className={`adsbygoogle block ${className}`}
      style={{ display: "block" }}
      data-ad-client={clientId}
      data-ad-slot={slot}
      data-ad-format={format}
      data-full-width-responsive="true"
    />
  );
}
