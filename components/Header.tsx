import Link from "next/link";

export default function Header() {
  return (
    <header className="border-b border-gray-200 bg-white">
      <div className="mx-auto flex max-w-5xl items-center justify-between px-4 py-4">
        <Link href="/" className="text-lg font-bold text-brand-700">
          내 지원금 찾기
        </Link>
        <nav className="flex gap-4 text-sm text-gray-600">
          <Link href="/about" className="hover:text-brand-600">
            소개
          </Link>
          <Link href="/contact" className="hover:text-brand-600">
            문의
          </Link>
        </nav>
      </div>
    </header>
  );
}
