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
      const region = regions.find((r) => r.slug === filters.regionSlug);
      results = results.filter((b) => b.region_id === region?.id);
    }
    if (filters.categorySlug) {
      const category = categories.find((c) => c.slug === filters.categorySlug);
      results = results.filter((b) => b.category_id === category?.id);
    }
    return results.map((b) => attachRelations(b, regions, categories));
  }

  let query = supabase.from("benefits").select("*").eq("is_published", true).eq("is_current", true);

  if (filters.regionSlug) {
    const region = regions.find((r) => r.slug === filters.regionSlug);
    if (region) query = query.eq("region_id", region.id);
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

/** sitemap/generateStaticParams용: 현재 연도뿐 아니라 히스토리 페이지까지 전부 포함합니다. */
export async function getAllBenefitSlugs(): Promise<string[]> {
  const supabase = getSupabaseClient();

  if (!supabase) {
    return seedBenefits.filter((b) => b.is_published).map((b) => b.slug);
  }

  const { data, error } = await supabase.from("benefits").select("slug").eq("is_published", true);
  if (error || !data) return [];
  return (data as { slug: string }[]).map((b) => b.slug);
}
