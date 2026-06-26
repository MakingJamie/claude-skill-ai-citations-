#!/usr/bin/env bash
#
# verify-foundations.sh — confirm the AI-citation foundations resolve and parse.
#
# Usage:
#   ./verify-foundations.sh https://example.com      # check a live/preview origin (uses curl)
#   ./verify-foundations.sh ./dist                   # check a built output directory
#   ./verify-foundations.sh ./public                 # check a source static directory
#
# Checks robots.txt, llms.txt, and sitemap.xml for presence, sane content, and an
# AI-crawler / Sitemap policy. Exits non-zero if any REQUIRED check fails.
# No hardcoded paths; safe to run from anywhere. Requires bash + (curl for URL mode).
#
# Caveat: in URL mode this trusts the HTTP response. Hosts that serve a soft-404
# (HTTP 200 + homepage HTML for a missing file) may report an artifact as "found"
# and then fail the content sub-checks — read the sub-checks, not just "found".

set -u

TARGET="${1:-}"
if [ -z "$TARGET" ]; then
  echo "usage: $0 <base-url | directory>" >&2
  exit 2
fi

# Detect mode once, and fail loudly (not silently) if URL mode needs curl and it's absent.
if printf '%s' "$TARGET" | grep -qiE '^https?://'; then
  URL_MODE=1
  if ! command -v curl >/dev/null 2>&1; then
    echo "error: URL mode needs 'curl', which is not installed." >&2
    echo "       install curl, or pass a local build directory instead (e.g. ./dist)." >&2
    exit 2
  fi
else
  URL_MODE=0
fi

PASS=0; FAIL=0; WARN=0
ok()   { printf '  \033[32mPASS\033[0m %s\n' "$1"; PASS=$((PASS+1)); }
bad()  { printf '  \033[31mFAIL\033[0m %s\n' "$1"; FAIL=$((FAIL+1)); }
warn() { printf '  \033[33mWARN\033[0m %s\n' "$1"; WARN=$((WARN+1)); }

# Resolve where an artifact lives, WITHOUT fetching it. Echoes the URL or file path
# (so the caller can show it), or nothing + non-zero if a local file isn't found.
# Kept separate from fetching so the path survives command substitution (a global set
# inside $(...) would be lost in the subshell).
resolve_src() {
  local name="$1"
  if [ "$URL_MODE" -eq 1 ]; then
    printf '%s' "${TARGET%/}/$name"
  else
    local d="${TARGET%/}" f
    for f in "$d/$name" "$d/public/$name" "$d/static/$name" "$d/dist/$name"; do
      [ -f "$f" ] && { printf '%s' "$f"; return 0; }
    done
    return 1
  fi
}

# Fetch the content at a resolved src (URL via curl, or a local file).
fetch_src() {
  local src="$1"
  [ -z "$src" ] && return 1
  if [ "$URL_MODE" -eq 1 ]; then
    curl -fsSL --max-time 20 "$src" 2>/dev/null
  else
    cat "$src" 2>/dev/null
  fi
}

echo "Verifying AI-citation foundations for: $TARGET"

# --- robots.txt (required) ---
echo "robots.txt"
SRC="$(resolve_src robots.txt)"
ROBOTS="$(fetch_src "$SRC")"
if [ -n "$ROBOTS" ]; then
  ok "robots.txt found ($SRC)"
  printf '%s' "$ROBOTS" | grep -qiE '^[[:space:]]*User-agent:' \
    && ok "has at least one User-agent group" || bad "no User-agent group"
  printf '%s' "$ROBOTS" | grep -qiE '^[[:space:]]*Sitemap:' \
    && ok "declares a Sitemap:" || warn "no Sitemap: directive"
  if printf '%s' "$ROBOTS" | grep -qiE 'OAI-SearchBot|PerplexityBot|Claude-User|Claude-SearchBot|ChatGPT-User'; then
    ok "names AI retrieval bots (citation channel addressed)"
  else
    warn "no named AI retrieval bots — relying on User-agent: * only"
  fi
  # Catch the classic mistake: a global Disallow: / with no AI exceptions.
  # Use tolower() for case-insensitivity — portable across BSD (macOS) and GNU awk
  # (BEGIN{IGNORECASE=1} is GNU-only and silently no-ops on BSD awk).
  if printf '%s' "$ROBOTS" | awk 'tolower($0) ~ /^[[:space:]]*user-agent:[[:space:]]*\*/{s=1;next} tolower($0) ~ /^[[:space:]]*user-agent:/{s=0} s && tolower($0) ~ /^[[:space:]]*disallow:[[:space:]]*\/[[:space:]]*$/{print}' | grep -q .; then
    warn "User-agent: * has 'Disallow: /' — confirm AI retrieval bots have explicit Allow blocks"
  fi
else
  bad "robots.txt missing"
fi

# --- llms.txt (recommended) ---
echo "llms.txt"
SRC="$(resolve_src llms.txt)"
LLMS="$(fetch_src "$SRC")"
if [ -n "$LLMS" ]; then
  ok "llms.txt found ($SRC)"
  printf '%s' "$LLMS" | head -n1 | grep -qE '^# .+' \
    && ok "starts with a single H1 title" || bad "first line is not an H1 (# Title)"
  printf '%s' "$LLMS" | grep -qE '^>' \
    && ok "has a blockquote summary" || warn "no blockquote summary"
  printf '%s' "$LLMS" | grep -qE '^- \[.+\]\(https?://.+\)' \
    && ok "contains Markdown links with descriptions" || warn "no Markdown link list found"
  printf '%s' "$LLMS" | grep -qiE '\{\{.+\}\}' \
    && bad "unfilled {{PLACEHOLDER}} left in llms.txt" || ok "no leftover placeholders"
else
  warn "llms.txt missing (recommended, low-cost signal)"
fi

# --- sitemap.xml (recommended) ---
echo "sitemap.xml"
SRC="$(resolve_src sitemap.xml)"
SITEMAP="$(fetch_src "$SRC")"
if [ -z "$SITEMAP" ]; then
  SRC="$(resolve_src sitemap-index.xml)"
  SITEMAP="$(fetch_src "$SRC")"
fi
if [ -n "$SITEMAP" ]; then
  ok "sitemap found ($SRC)"
  printf '%s' "$SITEMAP" | grep -qiE '<(urlset|sitemapindex)' \
    && ok "valid sitemap root element" || bad "no <urlset>/<sitemapindex> element"
  printf '%s' "$SITEMAP" | grep -qiE '<lastmod>' \
    && ok "includes <lastmod> freshness signals" || warn "no <lastmod> entries"
else
  warn "sitemap.xml missing (recommended for discovery)"
fi

echo "----------------------------------------"
printf 'Result: %s pass, %s warn, %s fail\n' "$PASS" "$WARN" "$FAIL"
[ "$FAIL" -eq 0 ] && exit 0 || exit 1
