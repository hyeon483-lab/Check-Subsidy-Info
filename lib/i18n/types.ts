export interface BenefitTranslationEntry {
  title: string;
  summary: string;
  eligibility: string;
  support_content: string;
  application_method: string;
  required_documents: string[];
  checklist: string[];
  faq: { question: string; answer: string }[];
}

export type BenefitTranslationMap = Record<string, BenefitTranslationEntry>;
