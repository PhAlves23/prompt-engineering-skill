# Changelog

All notable changes to this project are documented here. The format is based on
[Keep a Changelog](https://keepachangelog.com/), and this project adheres to
[Semantic Versioning](https://semver.org/).

## [1.1.0] - 2026-06-05

### Added
- Roleplay/persona worked example in `worked-examples.md`. (#3, @saurabhhhcodes)
- Cline adapter (`.clinerules/prompt-engineering.md`). (#4, @saurabhhhcodes)
- Single-source adapter generation: `adapters/_core.md` + `scripts/build-adapters.sh`, with an `--check` mode wired into CI so adapters can't drift.
- `commitlint` CI workflow enforcing Conventional Commits on every pull request.
- Repository banner (`assets/banner.png`) using the Prompt Cause brand, with editable source (`assets/banner.html` + `logo.png`).
- `CITATION.cff` (enables GitHub's "Cite this repository").
- `.github/CODEOWNERS` (auto-requests maintainer review on every PR).
- Structured GitHub Issue Forms (YAML) with dropdowns.
- `SECURITY.md` (vulnerability disclosure policy) and `docs/DEVELOPMENT.md` (architecture + release guide).
- Announcement templates for launch (`docs/announcement-templates.md`).
- Repository topics for discoverability.

### Changed
- Professional documentation pass: README with badges, table of contents, a before/after example, and per-platform install via collapsible sections; beginner-friendly CONTRIBUTING.
- Commit history normalized to Conventional Commits.

## [1.0.0] - 2026-06-05

### Added
- Initial release of the **Prompt Engineering** skill for Claude Code.
- Core skill: `SKILL.md` with the 5-phase workflow (diagnose → select techniques → rewrite → self-review → deliver), canonical prompt structure, golden rules, and a technique → task decision table.
- Reference library: `techniques.md`, `technique-index.md` (full Prompt Report taxonomy of 58 techniques), `model-profiles.md`, `task-patterns.md`, `worked-examples.md` (7 complete cases), `quality-checklist.md`, `evaluation.md`, `prompt-security.md`, `auto-optimization.md`, `sources.md`, plus a canonical XML template.
- Distribution: `install.sh` (one-line curl installer) and a Claude Code plugin marketplace (`.claude-plugin/marketplace.json` + plugin manifest).
- Adapters for other AI tools: Cursor (`.cursor/rules`), Windsurf (`.windsurf/rules`), GitHub Copilot (`.github/prompts`), and OpenAI Codex (`AGENTS.md`).
- Native multi-platform support: Codex skill discovery via `~/.agents/skills` (see `docs/INSTALL.codex.md`), Gemini CLI extension (`gemini-extension.json` + `GEMINI.md`), Copilot CLI marketplace, native Cursor plugin manifest (`.cursor-plugin/plugin.json`), and an OpenCode guide (`docs/INSTALL.opencode.md`).
- Website install snippets (HTML + Markdown) under `docs/`.
- GitHub Actions CI (`.github/workflows/validate.yml`): validates JSON, skill/adapter frontmatter, installer syntax, and the Windsurf rule size limit.
- `.github/FUNDING.yml` for GitHub Sponsors.

[1.1.0]: https://github.com/PhAlves23/prompt-engineering-skill/releases/tag/v1.1.0
[1.0.0]: https://github.com/PhAlves23/prompt-engineering-skill/releases/tag/v1.0.0
