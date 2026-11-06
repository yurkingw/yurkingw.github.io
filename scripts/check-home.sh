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
need "$css" "--radius-sm: 8px;"
need "$css" "--radius-md: 12px;"
need "$css" "--radius-pill: 999px;"
need "$css" "--shadow: none;"
need "$css" "--bg: #f7f7f8;"
need "$css" "--bg: #0e0e0f;"
need "$css" "--surface: #ffffff;"
need "$css" "--surface: #161617;"
need "$css" "--surface-soft: #f0f0f1;"
need "$css" "--surface-soft: #1c1c1e;"
need "$css" "--accent: #2f5f9e;"
need "$css" "--accent: #b54a4a;"
need "$css" "--accent-contrast: #ffffff;"
need "$css" "--hover-tint: rgba(0, 0, 0, 0.03);"
need "$css" "--hover-tint: rgba(255, 255, 255, 0.04);"
need "$css" "--pad-x: var(--s-5);"
need "$css" "--pad-x: var(--s-4);"
need "$css" "--inset-row: var(--s-4);"
need "$css" "padding-inline: var(--inset-row);"
need "$css" "padding-block: var(--s-5);"
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
need "$css" "150ms ease"

forbid "$css" "purple"
forbid "$css" "gradient"
forbid "$css" "OpenAI"
forbid "$css" "xgr-theme"

if grep -n "box-shadow" "$css" | grep -v "box-shadow: none" >/dev/null; then
  echo "FORBIDDEN: box-shadow other than none"
  grep -n "box-shadow" "$css"
  fail=1
fi

if [[ "$fail" -ne 0 ]]; then
  echo "check-home: failed"
  exit 1
fi

echo "check-home: ok"
