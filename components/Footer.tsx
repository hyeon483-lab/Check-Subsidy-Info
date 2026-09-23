import Link from "next/link";
import { InfoIcon, LogoMark } from "./icons";
import { getCategories } from "@/lib/data";

export default async function Footer() {
  const categories = await getCategories();

  return (
    <footer className="mt-20 border-t border-slate-200 bg-slate-900 text-slate-400">
      <div className="mx-auto max-w-5xl px-4 py-12 sm:px-6">
        <div className="mb-10 flex items-start gap-3 rounded-xl bg-slate-800/60 p-4 text-sm leading-relaxed text-slate-300">
          <InfoIcon className="mt-0.5 h-5 w-5 shrink-0 text-slate-400" />
          <p>
            본 사이트는 정부·지자체 지원 제도를 보기 쉽게 정리해 안내하는 민간 서비스이며, 정부 또는 지자체의
            공식 사이트가 아닙니다. 실제 신청은 반드시 각 제도의 공식 안내 페이지에서 최신 정보를 확인한 뒤
            진행하세요.
          </p>
        </div>

        <div className="grid grid-cols-2 gap-8 sm:grid-cols-4">
          <div>
            <div className="mb-3 flex items-center gap-2">
              <span className="flex h-7 w-7 items-center justify-center rounded-md bg-brand-600">
                <LogoMark className="h-4 w-4" />
              </span>
              <span className="text-sm font-semibold text-white">내 지원금 찾기</span>
            </div>
            <p className="text-xs leading-relaxed text-slate-500">
              결혼, 출산, 청년, 주거, 어르신 등 생애 이벤트별 지원금을 지역별로 한눈에 확인하세요.
            </p>
          </div>

          <div>
            <p className="mb-3 text-xs font-semibold uppercase tracking-wide text-slate-500">카테고리</p>
            <ul className="space-y-2 text-sm">
              {categories.map((category) => (
                <li key={category.id}>
                  <Link href={`/category/${category.slug}`} className="transition hover:text-white">
                    {category.name}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          <div>
            <p className="mb-3 text-xs font-semibold uppercase tracking-wide text-slate-500">무료 도구</p>
            <ul className="space-y-2 text-sm">
              <li>
                <Link href="/search" className="transition hover:text-white">
                  지원금 검색
                </Link>
              </li>
              <li>
                <Link href="/finder" className="transition hover:text-white">
                  맞춤 지원금 찾기
                </Link>
              </li>
              <li>
                <Link href="/median-income" className="transition hover:text-white">
                  기준 중위소득표
                </Link>
              </li>
            </ul>
          </div>

          <div>
            <p className="mb-3 text-xs font-semibold uppercase tracking-wide text-slate-500">사이트</p>
            <ul className="space-y-2 text-sm">
              <li>
                <Link href="/about" className="transition hover:text-white">
                  사이트 소개
                </Link>
              </li>
              <li>
                <Link href="/privacy" className="transition hover:text-white">
                  개인정보처리방침
                </Link>
              </li>
              <li>
                <Link href="/terms" className="transition hover:text-white">
                  이용약관
                </Link>
              </li>
              <li>
                <Link href="/contact" className="transition hover:text-white">
                  문의하기
                </Link>
              </li>
            </ul>
          </div>
        </div>

        <p className="mt-10 text-xs text-slate-500">&copy; {new Date().getFullYear()} 내 지원금 찾기. All rights reserved.</p>
      </div>
    </footer>
  );
}
