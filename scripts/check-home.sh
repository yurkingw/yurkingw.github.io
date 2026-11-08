#!/usr/bin/env bash
# Structural check for the editorial foyer. Exact public copy slots.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
html="$root/index.html"
css="$root/css/home.css"
fail=0

need() {
  local file="$1"
  local text="$2"
  if ! grep -q -F -- "$text" "$file"; then
    echo "MISSING in ${file#"$root"/}: $text"
    fail=1
  fi
}

forbid() {
  local file="$1"
  local text="$2"
  if grep -q -F -- "$text" "$file"; then
    echo "FORBIDDEN in ${file#"$root"/}: $text"
    fail=1
  fi
}

need "$html" "<title>Veiled Empyrean</title>"
need "$html" ">Veiled Empyrean</a>"
need "$html" "<h1>Veiled Empyrean</h1>"
forbid "$html" "yurKing"
need "$html" "Reading, notes, and quiet tools."
need "$html" "Good Reads"
need "$html" "One X post, one page."
need "$html" 'href="/x-good-reads/"'
need "$html" "Briefings"
need "$html" "Short intelligence notes."
need "$html" 'class="entry" href="/briefings/"'
need "$html" 'href="/briefings/"'

forbid "$html" "Coming soon"
forbid "$html" "is-soon"
forbid "$html" "aria-disabled"
need "$html" "Independent pages. Sources stay with their authors."
need "$html" 'localStorage.getItem("ygh-theme")'
need "$html" 'var storageKey = "ygh-theme";'
need "$html" 'role="group"'
need "$html" 'aria-label="Color theme"'
need "$html" 'data-theme-set="system"'
need "$html" 'data-theme-set="day"'
need "$html" 'data-theme-set="night"'
need "$html" ">Auto</button>"
need "$html" ">Day</button>"
need "$html" ">Night</button>"
need "$html" 'aria-hidden="true">·</span>'
need "$html" 'class="foyer-card"'

forbid "$html" "xgr-theme"
forbid "$html" "Get started"
forbid "$html" "Learn more"
forbid "$html" "OpenAI"

entries="$(grep -c '<a class="entry' "$html" || true)"
if [[ "$entries" -ne 2 ]]; then
  echo "Expected 2 entry rows, found $entries"
  fail=1
fi

need "$css" "--s-1: 4px;"
need "$css" "--s-8: 64px;"
need "$css" "--measure-home: 36rem;"
need "$css" "--radius-sm: 10px;"
need "$css" "--radius-md: 16px;"
need "$css" "--radius-lg: 22px;"
need "$css" "--radius-pill: 999px;"
need "$css" "--bg: #ebe9e6;"
need "$css" "--bg: #0a0b0c;"
need "$css" "--surface: #ffffff;"
need "$css" "--surface: #141516;"
need "$css" "--surface-raised: #ffffff;"
need "$css" "--surface-raised: #1a1b1d;"
need "$css" "--surface-soft: #f0f0f1;"
need "$css" "--surface-soft: #1c1c1e;"
need "$css" "--ink: #0a0a0a;"
need "$css" "--ink: #f2f2f2;"
need "$css" "--muted: #6b6b6b;"
need "$css" "--muted: #9a9a9a;"
need "$css" "--line: #e2e0dc;"
need "$css" "--line: #2a2c2e;"
need "$css" "--line-strong: #c4c2be;"
need "$css" "--line-strong: #3a3c40;"
need "$css" "--accent: #2f5f9e;"
need "$css" "--accent: #b54a4a;"
need "$css" "--accent-contrast: #ffffff;"
need "$css" "--cta: #0a0a0a;"
need "$css" "--cta: #f2f2f2;"
need "$css" "--cta-contrast: #ffffff;"
need "$css" "--cta-contrast: #0a0a0a;"
need "$css" "--shadow-card: 0 1px 2px rgba(0, 0, 0, 0.04), 0 12px 32px rgba(0, 0, 0, 0.08);"
need "$css" "--shadow-card: 0 0 0 1px rgba(255, 255, 255, 0.08), 0 16px 40px rgba(0, 0, 0, 0.45);"
need "$css" "--shadow-soft: 0 4px 16px rgba(0, 0, 0, 0.06);"
need "$css" "--shadow-soft: 0 0 0 1px rgba(255, 255, 255, 0.06);"
need "$css" "--hover-tint: rgba(0, 0, 0, 0.03);"
need "$css" "--hover-tint: rgba(255, 255, 255, 0.04);"
need "$css" "--pad-x: var(--s-5);"
need "$css" "--pad-x: var(--s-4);"
need "$css" "--inset-row: var(--s-4);"
need "$css" "--inset-card: 24px;"
need "$css" "--inset-card: 16px;"
need "$css" "padding-inline: var(--inset-row);"
need "$css" "padding-block: var(--s-5);"
need "$css" "padding: var(--inset-card);"
need "$css" "border-radius: var(--radius-lg);"
need "$css" "box-shadow: var(--shadow-card);"
need "$css" "background: var(--surface);"
need "$css" "background: var(--cta);"
need "$css" "color: var(--cta-contrast);"
need "$css" "background-color: var(--bg);"
need "$css" "translateY(6px)"
need "$css" "180ms ease-out"
need "$css" "--t1-size: 30px;"
need "$css" "--t1-size: 36px;"
need "$css" "--t1-weight: 650;"
need "$css" "--t1-lh: 1.2;"
need "$css" "--t1-track: -0.03em;"
need "$css" "--t2-size: 20px;"
need "$css" "--t2-size: 22px;"
need "$css" "--t2-weight: 600;"
need "$css" "--t2-lh: 1.3;"
need "$css" "--t2-track: -0.02em;"
need "$css" "--t3-size: 15px;"
need "$css" "--t3-size: 16px;"
need "$css" "--t3-weight: 400;"
need "$css" "--t3-lh: 1.65;"
need "$css" "--t3-track: 0;"
need "$css" "--t4-size: 14px;"
need "$css" "--t4-weight: 450;"
need "$css" "--t5-size: 13px;"
need "$css" "--t5-weight: 560;"
need "$css" "--t6-size: 11px;"
need "$css" "--t6-weight: 500;"
need "$css" "--t6-lh: 1.35;"
need "$css" "--t6-track: 0.04em;"
need "$css" "border-radius: var(--radius-pill);"
need "$css" "background: var(--accent);"
need "$css" "color: var(--accent-contrast);"
need "$css" "background: var(--surface-soft);"
need "$css" "height: 44px;"
forbid "$css" "--accent: #0a0a0a;"
forbid "$css" "--accent: #f5f5f5;"
forbid "$css" "border-radius: 0;"
forbid "$css" "--pad-x: var(--s-3);"
forbid "$css" "padding-inline: 0;"
forbid "$css" "--t1-size: 32px;"
forbid "$css" "--t1-size: 40px;"
forbid "$css" "--t3-size: 17px;"
forbid "$css" "--t3-size: 18px;"
forbid "$css" "--t4-size: 15px;"
forbid "$css" "--t5-size: 14px;"
forbid "$css" "--t5-weight: 520;"
forbid "$css" "--t6-size: 12px;"
need "$css" "prefers-reduced-motion: no-preference"
need "$css" "prefers-reduced-motion: reduce"
need "$css" "animation: none"
need "$css" "150ms ease"

forbid "$css" "--shadow-card: none"
forbid "$css" "--shadow: none"
forbid "$css" "--bg: #f7f7f8"
forbid "$css" "--bg: #ffffff"
forbid "$css" "--bg: #fff;"
forbid "$css" "particles"
forbid "$css" "meteors"
forbid "$css" "purple"
forbid "$css" "OpenAI"
forbid "$css" "xgr-theme"

# Night elevation must exist for explicit Night and for system dark.
count_exact() {
  local text="$1"
  local n
  n="$(grep -c -F -- "$text" "$css" || true)"
  if [[ "$n" -lt 2 ]]; then
    echo "NEED >=2 in css/home.css: $text (found $n)"
    fail=1
  fi
}

count_exact "--bg: #0a0b0c;"
count_exact "--surface: #141516;"
count_exact "--surface-soft: #1c1c1e;"
count_exact "--accent: #b54a4a;"
count_exact "--cta: #f2f2f2;"
count_exact "--cta-contrast: #0a0a0a;"
count_exact "--shadow-card: 0 0 0 1px rgba(255, 255, 255, 0.08), 0 16px 40px rgba(0, 0, 0, 0.45);"

if [[ "$fail" -ne 0 ]]; then
  echo "check-home: failed"
  exit 1
fi

echo "check-home: ok"
