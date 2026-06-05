# Changelog

All notable changes to this project are documented here. The format is based on
[Keep a Changelog](https://keepachangelog.com/), and this project adheres to
[Semantic Versioning](https://semver.org/).

## [1.0.0] - 2026-06-05

### Added
- Initial release of the **Prompt Engineering** skill for Claude Code.
- Core skill: `SKILL.md` with the 5-phase workflow (diagnose → select techniques → rewrite → self-review → deliver), canonical prompt structure, golden rules, and a technique → task decision table.
- Reference library: `techniques.md`, `technique-index.md` (full Prompt Report taxonomy of 58 techniques), `model-profiles.md`, `task-patterns.md`, `worked-examples.md` (7 complete cases), `quality-checklist.md`, `evaluation.md`, `prompt-security.md`, `auto-optimization.md`, `sources.md`, plus a canonical XML template.
- Distribution: `install.sh` (one-line curl installer) and a Claude Code plugin marketplace (`.claude-plugin/marketplace.json` + plugin manifest).
- Adapters for other AI tools: Cursor (`.cursor/rules`), Windsurf (`.windsurf/rules`), GitHub Copilot (`.github/prompts`), and OpenAI Codex (`AGENTS.md`).
- Native multi-platform support: Codex skill discovery via `~/.agents/skills` (see `docs/INSTALL.codex.md`), Gemini CLI extension (`gemini-extension.json` + `GEMINI.md`), Copilot CLI marketplace, and a native Cursor plugin manifest (`.cursor-plugin/plugin.json`).
- Website install snippets (HTML + Markdown) under `docs/`.

[1.0.0]: https://github.com/PhAlves23/prompt-engineering-skill/releases/tag/v1.0.0
