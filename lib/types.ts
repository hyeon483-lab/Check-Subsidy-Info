export type RegionLevel = "sido" | "sigungu";

export interface Region {
  id: string;
  slug: string;
  name: string;
  level: RegionLevel;
  parent_id: string | null;
}

export interface Category {
  id: string;
  slug: string;
  name: string;
  description: string | null;
  sort_order: number;
}

export interface FaqItem {
  question: string;
  answer: string;
}

export interface Benefit {
  id: string;
  slug: string;
  title: string;
  summary: string;
  region_id: string;
  category_id: string;

  eligibility: string;
  support_content: string;
  application_method: string;
  required_documents: string[];
  checklist: string[];
  faq: FaqItem[];

  agency_name: string;
  agency_url: string | null;

  income_condition: string | null;
  age_min: number | null;
  age_max: number | null;
  household_type: string | null;

  application_start_date: string | null;
  application_end_date: string | null;
  is_ongoing: boolean;

  source_name: string;
  source_updated_at: string | null;
  is_published: boolean;

  fiscal_year: number;
  program_slug: string;
  is_current: boolean;

  // joined convenience fields (populated by the data layer)
  region?: Region;
  category?: Category;
}

export interface BenefitFilters {
  regionSlug?: string;
  categorySlug?: string;
}
