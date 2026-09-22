import Link from "next/link";
import { InfoIcon } from "./icons";

export default function Footer() {
  return (
    <footer className="mt-20 border-t border-slate-200 bg-slate-900 text-slate-400">
      <div className="mx-auto max-w-5xl px-4 py-12 sm:px-6">
        <div className="mb-8 flex items-start gap-3 rounded-xl bg-slate-800/60 p-4 text-sm leading-relaxed text-slate-300">
          <InfoIcon className="mt-0.5 h-5 w-5 shrink-0 text-slate-400" />
          <p>
            본 사이트는 정부·지자체 지원 제도를 보기 쉽게 정리해 안내하는 민간 서비스이며, 정부 또는 지자체의
            공식 사이트가 아닙니다. 실제 신청은 반드시 각 제도의 공식 안내 페이지에서 최신 정보를 확인한 뒤
            진행하세요.
          </p>
        </div>

        <div className="flex flex-col gap-6 sm:flex-row sm:items-center sm:justify-between">
          <div className="flex items-center gap-2">
            <span className="flex h-7 w-7 items-center justify-center rounded-md bg-white/10 text-xs font-bold text-white">
              내
            </span>
            <span className="text-sm font-semibold text-white">내 지원금 찾기</span>
          </div>
          <div className="flex flex-wrap gap-x-6 gap-y-2 text-sm">
            <Link href="/finder" className="transition hover:text-white">
              맞춤 지원금 찾기
            </Link>
            <Link href="/search" className="transition hover:text-white">
              검색
            </Link>
            <Link href="/about" className="transition hover:text-white">
              사이트 소개
            </Link>
            <Link href="/privacy" className="transition hover:text-white">
              개인정보처리방침
            </Link>
            <Link href="/terms" className="transition hover:text-white">
              이용약관
            </Link>
            <Link href="/contact" className="transition hover:text-white">
              문의하기
            </Link>
          </div>
        </div>

        <p className="mt-8 text-xs text-slate-500">&copy; {new Date().getFullYear()} 내 지원금 찾기. All rights reserved.</p>
      </div>
    </footer>
  );
}
