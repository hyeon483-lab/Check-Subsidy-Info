/**
 * 연도별 기준 중위소득(보건복지부 고시). 지원금마다 그 지원금이 만들어진
 * 회계연도 기준을 그대로 쓰는 경우가 있어(예: 2025년에 공고된 사업이 아직
 * 2025년 기준을 쓰는 경우), 최근 2개 연도를 함께 제공합니다.
 * 8인 초과 가구는 1인 증가 시마다 perPersonIncrement만큼 더합니다.
 */
export interface MedianIncomeYearData {
  year: number;
  base: Record<number, number>;
  perPersonIncrement: number;
  sourceUrl: string;
}

export const medianIncomePercents = [32, 40, 47, 50, 60, 72, 85, 100, 120, 150, 180, 200];

export const medianIncomeByYear: MedianIncomeYearData[] = [
  {
    year: 2026,
    base: {
      1: 2564238,
      2: 4199292,
      3: 5359036,
      4: 6494738,
      5: 7556719,
      6: 8555952,
      7: 9515150,
      8: 10474348,
    },
    perPersonIncrement: 959198,
    sourceUrl: "https://www.mohw.go.kr/board.es?mid=a10503010100&bid=0027&act=view&list_no=1487098",
  },
  {
    year: 2025,
    base: {
      1: 2392013,
      2: 3932658,
      3: 5025353,
      4: 6097773,
      5: 7108192,
      6: 8064805,
      7: 8988428,
      8: 9912051,
    },
    perPersonIncrement: 923623,
    sourceUrl: "https://www.mohw.go.kr/board.es?mid=a10503000000&bid=0027&list_no=1482430&act=view",
  },
];

export function medianIncomeAt(data: MedianIncomeYearData, householdSize: number, percent: number): number {
  const base =
    householdSize <= 8
      ? data.base[householdSize]
      : data.base[8] + (householdSize - 8) * data.perPersonIncrement;
  return Math.round((base * percent) / 100);
}
