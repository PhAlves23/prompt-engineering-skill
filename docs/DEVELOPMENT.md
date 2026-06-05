# Development & architecture

A map of how this repo is put together, for contributors and maintainers. For the contribution flow itself, see [CONTRIBUTING.md](../CONTRIBUTING.md).

## Mental model

The repo is **one skill, packaged for many tools**. There is exactly one authoritative copy of the skill, and everything else either wraps it or is generated from it.

```
                ┌─────────────────────────────────────────────┐
                │  plugins/prompt-engineering/skills/           │
                │  prompt-engineering/   ← SOURCE OF TRUTH       │
                │    SKILL.md + references/ + assets/            │
                └───────────────┬─────────────────────────────┘
                                │  used directly by
        ┌───────────────────────┼───────────────────────┐
        ▼                       ▼                       ▼
  Claude Code             Codex (native via       OpenCode (native via
  (plugin / curl)         ~/.agents/skills)       skills path)

                ┌─────────────────────────────────────────────┐
                │  adapters/_core.md   ← lean body (condensed)  │
                └───────────────┬─────────────────────────────┘
                                │  build-adapters.sh generates
        ┌───────────┬───────────┼───────────┬───────────────┐
        ▼           ▼           ▼           ▼               ▼
   Cursor.mdc  Windsurf.md  Copilot.md  Codex AGENTS.md  Cline.md  GEMINI.md
```

## Two sources of truth (and why)

| Layer | File(s) | Who consumes it |
|-------|---------|-----------------|
| **Full skill** | `plugins/.../skills/prompt-engineering/` | Tools that load real skills: Claude Code, Codex (symlink), OpenCode |
| **Lean adapters** | generated from `adapters/_core.md` | Tools that only take a single "rule" file: Cursor, Windsurf, Copilot, Cline, Gemini, Codex `AGENTS.md` |

Why two? The full skill is ~90 KB across many files. Tools like Cursor or Copilot load a rule on every request, so dumping 90 KB there would waste the context window. The lean body carries the essentials (principles, decision table, output format) and **links** to the full references online, which the agent fetches only when needed.

## The build step

`scripts/build-adapters.sh` reads `adapters/_core.md`, prepends each tool's frontmatter/header, and writes the six adapter files (Cursor, Windsurf, Copilot, Codex `AGENTS.md`, Cline `.clinerules`, root `GEMINI.md`).

- Run `./scripts/build-adapters.sh` after editing `_core.md`.
- Run `./scripts/build-adapters.sh --check` to verify nothing is stale (this is what CI runs).
- **Never hand-edit a generated adapter** — your change will be overwritten and CI will flag the drift.

## Distribution manifests

| File | Purpose |
|------|---------|
| `.claude-plugin/marketplace.json` | Marketplace index (Claude Code + Copilot CLI `plugin marketplace add`) |
| `plugins/prompt-engineering/.claude-plugin/plugin.json` | The plugin manifest |
| `.cursor-plugin/plugin.json` | Native Cursor plugin manifest |
| `gemini-extension.json` | Gemini CLI extension manifest (points at `GEMINI.md`) |
| `install.sh` | Standalone curl installer for Claude Code |

These are validated by CI (JSON parse) but not auto-generated; edit them by hand and keep versions consistent on release.

## CI

`.github/workflows/validate.yml` runs on push and PR:

1. **JSON** — every `*.json` parses.
2. **Frontmatter** — `SKILL.md` has `name` + `description`; each adapter has `description`.
3. **Adapters in sync** — `build-adapters.sh --check`.
4. **Installer** — `bash -n install.sh`.
5. **Windsurf size** — the rule stays under Windsurf's ~6 KB limit.

If a check fails, the PR can't merge until it's green.

## Releasing (maintainer)

1. Move `## [Unreleased]` items in `CHANGELOG.md` under a new version heading with the date.
2. Bump `version` in: `plugin.json`, `.cursor-plugin/plugin.json`, `gemini-extension.json`, and the `version` badge in `README.md`.
3. Commit, tag, and publish:
   ```bash
   git tag vX.Y.Z -m "vX.Y.Z"
   git push origin main --tags
   gh release create vX.Y.Z --title "vX.Y.Z" --notes-from-tag
   ```
4. Plugin users get the update via `/plugin update`; curl users by re-running the installer.

Follow [Semantic Versioning](https://semver.org/): patch for fixes, minor for additive content, major for breaking structural changes.
