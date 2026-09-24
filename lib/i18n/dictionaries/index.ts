import type { Locale } from "../config";
import type { Dictionary } from "../dictionaryType";
import ko from "./ko";
import en from "./en";
import ja from "./ja";
import zh from "./zh";
import vi from "./vi";
import th from "./th";

const dictionaries: Record<Locale, Dictionary> = { ko, en, ja, zh, vi, th };

export function getDictionary(locale: Locale): Dictionary {
  return dictionaries[locale];
}
