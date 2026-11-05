#!/usr/bin/env bash
# Copy the public root into _site. README and workflows stay out of Pages.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
out="$root/_site"

rm -rf "$out"
mkdir -p "$out/css" "$out/fonts"
cp "$root/index.html" "$out/index.html"
cp "$root/css/home.css" "$out/css/home.css"
cp "$root/favicon.svg" "$out/favicon.svg"
cp "$root/fonts/"*.woff2 "$out/fonts/"
cp "$root/fonts/OFL.txt" "$out/fonts/OFL.txt"
: > "$out/.nojekyll"

test -f "$out/index.html"
test -f "$out/css/home.css"
test -f "$out/fonts/inter-latin-wght-normal.woff2"
echo "assemble-site: $out"
