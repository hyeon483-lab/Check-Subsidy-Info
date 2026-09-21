import Link from "next/link";

export default function Footer() {
  return (
    <footer className="mt-16 border-t border-gray-200 bg-white">
      <div className="mx-auto max-w-5xl px-4 py-8 text-sm text-gray-500">
        <p className="mb-3">
          본 사이트는 정부·지자체 지원 제도를 보기 쉽게 정리해 안내하는 민간 서비스이며,
          정부 또는 지자체의 공식 사이트가 아닙니다. 실제 신청은 반드시 각 제도의 공식 안내 페이지에서
          최신 정보를 확인한 뒤 진행하세요.
        </p>
        <div className="flex flex-wrap gap-4">
          <Link href="/about" className="hover:text-brand-600">
            사이트 소개
          </Link>
          <Link href="/privacy" className="hover:text-brand-600">
            개인정보처리방침
          </Link>
          <Link href="/terms" className="hover:text-brand-600">
            이용약관
          </Link>
          <Link href="/contact" className="hover:text-brand-600">
            문의하기
          </Link>
        </div>
        <p className="mt-4">&copy; {new Date().getFullYear()} 내 지원금 찾기</p>
      </div>
    </footer>
  );
}
