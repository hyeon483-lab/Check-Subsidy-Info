/**
 * 2026년 기준 중위소득 (보건복지부 고시, 2025년 대비 6.51% 인상).
 * 8인 초과 가구는 1인 증가 시마다 medianIncomePerPersonIncrement만큼 더합니다.
 */
export const medianIncomeYear = 2026;

export const medianIncomeBase: Record<number, number> = {
  1: 2564238,
  2: 4199292,
  3: 5359036,
  4: 6494738,
  5: 7556719,
  6: 8555952,
  7: 9515150,
  8: 10474348,
};

export const medianIncomePerPersonIncrement = 959198;

export const medianIncomePercents = [32, 40, 47, 50, 60, 72, 85, 100, 120, 150, 180, 200];

export function medianIncomeAt(householdSize: number, percent: number): number {
  const base =
    householdSize <= 8
      ? medianIncomeBase[householdSize]
      : medianIncomeBase[8] + (householdSize - 8) * medianIncomePerPersonIncrement;
  return Math.round((base * percent) / 100);
}
