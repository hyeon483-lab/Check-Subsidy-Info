import Link from "next/link";

export default function NotFound() {
  return (
    <div className="mx-auto max-w-3xl px-4 py-20 text-center">
      <h1 className="mb-3 text-2xl font-bold text-gray-900">페이지를 찾을 수 없습니다</h1>
      <p className="mb-6 text-gray-600">요청하신 지원금 정보가 존재하지 않거나 삭제되었습니다.</p>
      <Link href="/" className="text-brand-600 underline">
        홈으로 돌아가기
      </Link>
    </div>
  );
}
