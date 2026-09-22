import { ListIcon } from "./icons";

export interface TocItem {
  id: string;
  label: string;
}

export default function TableOfContents({ items }: { items: TocItem[] }) {
  if (items.length === 0) return null;

  return (
    <nav aria-label="목차" className="mb-5 rounded-2xl bg-white p-5 shadow-card ring-1 ring-slate-100">
      <p className="mb-3 flex items-center gap-1.5 text-xs font-semibold uppercase tracking-wide text-slate-400">
        <ListIcon className="h-3.5 w-3.5" />
        목차
      </p>
      <ol className="space-y-2">
        {items.map((item, index) => (
          <li key={item.id}>
            <a
              href={`#${item.id}`}
              className="flex items-center gap-2 text-sm text-slate-600 transition hover:text-brand-700"
            >
              <span className="flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-slate-100 text-[11px] font-semibold text-slate-500">
                {index + 1}
              </span>
              {item.label}
            </a>
          </li>
        ))}
      </ol>
    </nav>
  );
}
