import { createClient, SupabaseClient } from "@supabase/supabase-js";

let cachedClient: SupabaseClient | null = null;

/**
 * Supabase 환경변수가 설정되지 않은 경우 null을 반환합니다.
 * 이 경우 상위 데이터 레이어(lib/data.ts)가 로컬 시드 데이터로 대체합니다.
 */
export function getSupabaseClient(): SupabaseClient | null {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL?.trim();
  const anonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY?.trim();

  if (!url || !anonKey) {
    return null;
  }

  if (!cachedClient) {
    try {
      cachedClient = createClient(url, anonKey, {
        auth: { persistSession: false },
      });
    } catch (error) {
      // 잘못된 URL 등 설정 오류로 클라이언트 생성이 실패해도 빌드/렌더링이
      // 깨지지 않도록 로컬 시드 데이터로 폴백합니다.
      console.error("Failed to create Supabase client, falling back to seed data:", error);
      return null;
    }
  }

  return cachedClient;
}

export function isSupabaseConfigured(): boolean {
  return Boolean(
    process.env.NEXT_PUBLIC_SUPABASE_URL?.trim() && process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY?.trim()
  );
}
