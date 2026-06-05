#!/usr/bin/env bash
#
# build-adapters.sh — regenerate every tool adapter from the single source of
# truth (adapters/_core.md). Run this after editing _core.md so all adapters
# stay in sync. CI fails if the committed adapters don't match this output.
#
# Usage:
#   ./scripts/build-adapters.sh          # write the adapter files
#   ./scripts/build-adapters.sh --check  # exit non-zero if anything is stale

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CORE="$ROOT/adapters/_core.md"
[ -f "$CORE" ] || { echo "Missing $CORE"; exit 1; }
BODY="$(cat "$CORE")"

CHECK=0
[ "${1:-}" = "--check" ] && CHECK=1

# emit <frontmatter-or-header> + body to <path>
emit() {
  local path="$1" header="$2"
  local content
  content="$(printf '%s\n%s\n' "$header" "$BODY")"
  if [ "$CHECK" -eq 1 ]; then
    if ! diff -q <(printf '%s' "$content") "$path" >/dev/null 2>&1; then
      echo "STALE: ${path#$ROOT/}"
      return 1
    fi
    echo "ok:    ${path#$ROOT/}"
  else
    mkdir -p "$(dirname "$path")"
    printf '%s' "$content" > "$path"
    echo "wrote: ${path#$ROOT/}"
  fi
}

CURSOR_FM='---
description: Optimize and rewrite prompts using proven prompt engineering techniques. Invoke when the user wants to improve, optimize, or rewrite a prompt, or pastes a prompt draft asking to make it better.
globs:
alwaysApply: false
---'

WINDSURF_FM='---
trigger: model_decision
description: Use when the user wants to improve, optimize, or rewrite a prompt, or pastes a prompt draft asking to make it better.
---'

COPILOT_FM="---
mode: 'agent'
description: 'Optimize and rewrite a prompt using proven prompt engineering techniques.'
---"

CODEX_HD='# AGENTS.md — Prompt Engineering

> Drop this file at the root of a repo (or merge its content into an existing AGENTS.md).
> Codex and other AGENTS.md-aware tools load it automatically. To use the skill, ask:
> "improve this prompt", "optimize this prompt", or paste a draft and ask to make it better.
'

GEMINI_HD='# Prompt Engineering — Gemini context

> Loaded by the Gemini CLI extension (see gemini-extension.json). To use it,
> ask: "improve this prompt", "optimize this prompt", or paste a draft and ask
> to make it better.
'

rc=0
emit "$ROOT/adapters/cursor/.cursor/rules/prompt-engineering.mdc"            "$CURSOR_FM"   || rc=1
emit "$ROOT/adapters/windsurf/.windsurf/rules/prompt-engineering.md"         "$WINDSURF_FM" || rc=1
emit "$ROOT/adapters/copilot/.github/prompts/prompt-engineering.prompt.md"   "$COPILOT_FM"  || rc=1
emit "$ROOT/adapters/codex/AGENTS.md"                                        "$CODEX_HD"    || rc=1
emit "$ROOT/GEMINI.md"                                                       "$GEMINI_HD"   || rc=1

if [ "$CHECK" -eq 1 ] && [ "$rc" -ne 0 ]; then
  echo ""
  echo "Adapters are out of sync with adapters/_core.md."
  echo "Run ./scripts/build-adapters.sh and commit the result."
  exit 1
fi

[ "$CHECK" -eq 1 ] && echo "All adapters in sync." || echo "Done. Adapters regenerated from adapters/_core.md."
