import { getSupabaseClient } from "./supabase";
import { seedBenefits, seedCategories, seedRegions } from "./seedData";
import { Benefit, BenefitFilters, Category, Region } from "./types";

function attachRelations(benefit: Benefit, regions: Region[], categories: Category[]): Benefit {
  return {
    ...benefit,
    region: regions.find((r) => r.id === benefit.region_id),
    category: categories.find((c) => c.id === benefit.category_id),
  };
}

/**
 * 시·도를 선택하면 그 하위 시·군·구 전용 제도까지, 시·군·구를 선택하면
 * 그 지역이 속한 시·도 전역 제도까지 함께 보여주기 위한 region_id 목록입니다.
 * 어느 지역을 선택하든 "전국" 단위 제도는 항상 함께 노출됩니다.
 */
function matchingRegionIds(regionSlug: string, regions: Region[]): string[] {
  const selected = regions.find((r) => r.slug === regionSlug);
  if (!selected) return [];

  const nationwide = regions.find((r) => r.slug === "nationwide");
  const ids =
    selected.level === "sido"
      ? [selected.id, ...regions.filter((r) => r.parent_id === selected.id).map((r) => r.id)]
      : selected.parent_id
        ? [selected.id, selected.parent_id]
        : [selected.id];

  if (nationwide && !ids.includes(nationwide.id)) ids.push(nationwide.id);
  return ids;
}

export async function getRegions(): Promise<Region[]> {
  const supabase = getSupabaseClient();
  if (!supabase) return seedRegions;

  const { data, error } = await supabase.from("regions").select("*").order("name");
  if (error || !data) return seedRegions;
  return data as Region[];
}

export async function getCategories(): Promise<Category[]> {
  const supabase = getSupabaseClient();
  if (!supabase) return seedCategories;

  const { data, error } = await supabase.from("categories").select("*").order("sort_order");
  if (error || !data) return seedCategories;
  return data as Category[];
}

export async function getRegionBySlug(slug: string): Promise<Region | undefined> {
  const regions = await getRegions();
  return regions.find((r) => r.slug === slug);
}

export async function getCategoryBySlug(slug: string): Promise<Category | undefined> {
  const categories = await getCategories();
  return categories.find((c) => c.slug === slug);
}

export async function getBenefits(filters: BenefitFilters = {}): Promise<Benefit[]> {
  const [regions, categories] = await Promise.all([getRegions(), getCategories()]);
  const supabase = getSupabaseClient();

  if (!supabase) {
    let results = seedBenefits.filter((b) => b.is_published && b.is_current);
    if (filters.regionSlug) {
      const ids = matchingRegionIds(filters.regionSlug, regions);
      results = results.filter((b) => ids.includes(b.region_id));
    }
    if (filters.categorySlug) {
      const category = categories.find((c) => c.slug === filters.categorySlug);
      results = results.filter((b) => b.category_id === category?.id);
    }
    return results.map((b) => attachRelations(b, regions, categories));
  }

  let query = supabase.from("benefits").select("*").eq("is_published", true).eq("is_current", true);

  if (filters.regionSlug) {
    const ids = matchingRegionIds(filters.regionSlug, regions);
    if (ids.length > 0) query = query.in("region_id", ids);
  }
  if (filters.categorySlug) {
    const category = categories.find((c) => c.slug === filters.categorySlug);
    if (category) query = query.eq("category_id", category.id);
  }

  const { data, error } = await query.order("created_at", { ascending: false });
  if (error || !data) return [];
  return (data as Benefit[]).map((b) => attachRelations(b, regions, categories));
}

/** 같은 제도의 연도별 버전을 최신순으로 반환합니다 (히스토리 표시용). */
export async function getBenefitHistory(programSlug: string): Promise<Benefit[]> {
  const [regions, categories] = await Promise.all([getRegions(), getCategories()]);
  const supabase = getSupabaseClient();

  if (!supabase) {
    return seedBenefits
      .filter((b) => b.is_published && b.program_slug === programSlug)
      .sort((a, b) => b.fiscal_year - a.fiscal_year)
      .map((b) => attachRelations(b, regions, categories));
  }

  const { data, error } = await supabase
    .from("benefits")
    .select("*")
    .eq("is_published", true)
    .eq("program_slug", programSlug)
    .order("fiscal_year", { ascending: false });

  if (error || !data) return [];
  return (data as Benefit[]).map((b) => attachRelations(b, regions, categories));
}

export async function getBenefitBySlug(slug: string): Promise<Benefit | undefined> {
  const supabase = getSupabaseClient();
  const [regions, categories] = await Promise.all([getRegions(), getCategories()]);

  if (!supabase) {
    const benefit = seedBenefits.find((b) => b.slug === slug && b.is_published);
    return benefit ? attachRelations(benefit, regions, categories) : undefined;
  }

  const { data, error } = await supabase
    .from("benefits")
    .select("*")
    .eq("slug", slug)
    .eq("is_published", true)
    .maybeSingle();

  if (error || !data) return undefined;
  return attachRelations(data as Benefit, regions, categories);
}

/**
 * 지원금 상세 페이지 하단의 "관련 지원금" 추천용입니다. 같은 지역의 다른
 * 제도를 우선 채우고, 부족하면 같은 카테고리의 다른 지역 제도로 채웁니다.
 */
export async function getRelatedBenefits(benefit: Benefit, limit = 4): Promise<Benefit[]> {
  const [byRegion, byCategory] = await Promise.all([
    benefit.region ? getBenefits({ regionSlug: benefit.region.slug }) : Promise.resolve([]),
    benefit.category ? getBenefits({ categorySlug: benefit.category.slug }) : Promise.resolve([]),
  ]);

  const seen = new Set([benefit.slug]);
  const related: Benefit[] = [];

  for (const b of [...byRegion, ...byCategory]) {
    if (related.length >= limit) break;
    if (seen.has(b.slug)) continue;
    seen.add(b.slug);
    related.push(b);
  }

  return related;
}

/** sitemap/generateStaticParams용: 현재 연도뿐 아니라 히스토리 페이지까지 전부 포함합니다. */
export async function getAllBenefitSlugs(): Promise<string[]> {
  const meta = await getAllBenefitsMeta();
  return meta.map((b) => b.slug);
}

/** sitemap의 lastModified용: slug와 최근 갱신일을 함께 반환합니다. */
export async function getAllBenefitsMeta(): Promise<{ slug: string; updatedAt: string | null }[]> {
  const supabase = getSupabaseClient();

  if (!supabase) {
    return seedBenefits
      .filter((b) => b.is_published)
      .map((b) => ({ slug: b.slug, updatedAt: b.source_updated_at }));
  }

  const { data, error } = await supabase
    .from("benefits")
    .select("slug, source_updated_at")
    .eq("is_published", true);
  if (error || !data) return [];
  return (data as { slug: string; source_updated_at: string | null }[]).map((b) => ({
    slug: b.slug,
    updatedAt: b.source_updated_at,
  }));
}
