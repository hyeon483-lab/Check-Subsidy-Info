"use client";

import Link from "next/link";
import { useEffect } from "react";

export default function ErrorPage({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  useEffect(() => {
    console.error(error);
  }, [error]);

  return (
    <div className="mx-auto max-w-3xl px-4 py-24 text-center">
      <h1 className="mb-3 text-2xl font-bold tracking-tight text-slate-900">일시적인 오류가 발생했습니다</h1>
      <p className="mb-6 text-slate-500">페이지를 불러오는 중 문제가 생겼습니다. 잠시 후 다시 시도해주세요.</p>
      <div className="flex items-center justify-center gap-3">
        <button
          type="button"
          onClick={reset}
          className="inline-flex items-center gap-1.5 rounded-full bg-brand-600 px-4 py-2 text-sm font-medium text-white transition hover:bg-brand-700"
        >
          다시 시도
        </button>
        <Link
          href="/"
          className="inline-flex items-center gap-1.5 rounded-full bg-white px-4 py-2 text-sm font-medium text-slate-600 ring-1 ring-inset ring-slate-200 transition hover:bg-slate-50"
        >
          홈으로 돌아가기
        </Link>
      </div>
    </div>
  );
}
