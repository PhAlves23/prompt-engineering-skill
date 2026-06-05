#!/usr/bin/env bash
#
# Installer for the "prompt-engineering" Claude Code skill.
#
# Usage (one-liner):
#   curl -fsSL https://raw.githubusercontent.com/PhAlves23/prompt-engineering-skill/main/install.sh | bash
#
# What it does: downloads this repo and copies the skill into
# ~/.claude/skills/prompt-engineering so Claude Code can use it.
# It does NOT touch any other skill or config.

set -euo pipefail

REPO="PhAlves23/prompt-engineering-skill"
BRANCH="main"
SKILL_NAME="prompt-engineering"
SKILL_SUBPATH="plugins/${SKILL_NAME}/skills/${SKILL_NAME}"
DEST="${HOME}/.claude/skills/${SKILL_NAME}"

say() { printf '\033[1;36m==>\033[0m %s\n' "$1"; }
err() { printf '\033[1;31mError:\033[0m %s\n' "$1" >&2; exit 1; }

command -v curl >/dev/null 2>&1 || err "curl is required."
command -v tar  >/dev/null 2>&1 || err "tar is required."

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

say "Downloading ${REPO}@${BRANCH}..."
curl -fsSL "https://codeload.github.com/${REPO}/tar.gz/refs/heads/${BRANCH}" -o "${TMP}/repo.tar.gz" \
  || err "Download failed. Check the repo name and that the branch '${BRANCH}' exists."

say "Extracting..."
tar -xzf "${TMP}/repo.tar.gz" -C "${TMP}"

SRC="$(find "${TMP}" -maxdepth 1 -type d -name '*prompt-engineering-skill*' | head -n1)/${SKILL_SUBPATH}"
[ -d "$SRC" ] || err "Could not find the skill inside the archive (${SKILL_SUBPATH})."

if [ -d "$DEST" ]; then
  BACKUP="${DEST}.backup-$(date +%Y%m%d-%H%M%S)"
  say "Existing install found. Backing it up to: ${BACKUP}"
  mv "$DEST" "$BACKUP"
fi

mkdir -p "$(dirname "$DEST")"
cp -R "$SRC" "$DEST"

say "Installed to: ${DEST}"
say "Done. Open Claude Code and run /prompt-engineering (or say \"improve this prompt\")."
