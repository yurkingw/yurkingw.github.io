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
need "$html" "Coming soon"
need "$html" 'href="/briefings/"'
need "$html" "is-soon"
need "$html" 'aria-disabled="true"'
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
need "$css" "--radius-sm: 4px;"
need "$css" "--radius-md: 6px;"
need "$css" "--shadow: none;"
need "$css" "--bg: #ffffff;"
need "$css" "--bg: #0d0d0d;"
need "$css" "--hover-tint: rgba(0, 0, 0, 0.03);"
need "$css" "--hover-tint: rgba(255, 255, 255, 0.04);"
need "$css" "--t1-size: 32px;"
need "$css" "--t1-size: 40px;"
need "$css" "height: 24px;"
need "$css" "height: 44px;"
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
