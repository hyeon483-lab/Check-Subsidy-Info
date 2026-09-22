export interface StatItem {
  label: string;
  value: string;
}

export default function StatsBar({ stats }: { stats: StatItem[] }) {
  return (
    <div className="grid grid-cols-2 gap-4 sm:grid-cols-4">
      {stats.map((stat) => (
        <div key={stat.label} className="rounded-2xl bg-white p-5 text-center shadow-card ring-1 ring-slate-100">
          <p className="text-2xl font-bold text-brand-600 sm:text-3xl">{stat.value}</p>
          <p className="mt-1 text-xs font-medium text-slate-500 sm:text-sm">{stat.label}</p>
        </div>
      ))}
    </div>
  );
}
