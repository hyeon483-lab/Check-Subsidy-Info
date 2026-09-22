"use client";

import { useEffect, useState } from "react";
import { ArrowUpIcon } from "./icons";

export default function ScrollTopButton() {
  const [visible, setVisible] = useState(false);

  useEffect(() => {
    function onScroll() {
      setVisible(window.scrollY > 480);
    }
    onScroll();
    window.addEventListener("scroll", onScroll, { passive: true });
    return () => window.removeEventListener("scroll", onScroll);
  }, []);

  if (!visible) return null;

  return (
    <button
      type="button"
      onClick={() => window.scrollTo({ top: 0, behavior: "smooth" })}
      aria-label="맨 위로 이동"
      className="fixed bottom-6 right-4 z-30 flex h-11 w-11 items-center justify-center rounded-full bg-slate-900 text-white shadow-lg transition hover:bg-slate-700 sm:right-8"
    >
      <ArrowUpIcon className="h-5 w-5" />
    </button>
  );
}
