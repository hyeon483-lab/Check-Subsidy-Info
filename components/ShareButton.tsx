"use client";

import { useState } from "react";
import { CheckIcon, ShareIcon } from "./icons";

export default function ShareButton({ title, url }: { title: string; url: string }) {
  const [copied, setCopied] = useState(false);

  async function handleShare() {
    if (typeof navigator !== "undefined" && typeof navigator.share === "function") {
      try {
        await navigator.share({ title, url });
      } catch {
        // 사용자가 공유 시트를 취소한 경우 등은 조용히 무시합니다.
      }
      return;
    }

    try {
      await navigator.clipboard.writeText(url);
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    } catch {
      // 클립보드 API를 쓸 수 없는 환경이면 조용히 무시합니다.
    }
  }

  return (
    <button
      type="button"
      onClick={handleShare}
      className="inline-flex items-center gap-1.5 rounded-full bg-white px-3.5 py-1.5 text-xs font-medium text-slate-600 ring-1 ring-inset ring-slate-200 transition hover:bg-slate-50"
    >
      {copied ? (
        <>
          <CheckIcon className="h-3.5 w-3.5 text-brand-600" />
          링크 복사됨
        </>
      ) : (
        <>
          <ShareIcon className="h-3.5 w-3.5" />
          공유하기
        </>
      )}
    </button>
  );
}
