# Contributing

Thanks for your interest in improving the Prompt Engineering skill. Contributions of all sizes are welcome — fixing a typo, sharpening an instruction, adding a worked example, or extending platform support.

## Ground rules

- **Cite your sources.** This skill's credibility comes from being grounded in primary sources (Anthropic, OpenAI, Google, *The Prompt Report*, and named papers). If you add or change a technique claim, add the source to `references/sources.md`.
- **Keep it model-aware.** Prompt engineering rules differ by model family. If a change is model-specific, note which models it applies to (see `references/model-profiles.md`).
- **Don't over-engineer.** The skill itself preaches anti-overengineering — apply it to the skill. Prefer the smallest change that adds real value.
- **English only** for all skill content (the skill targets a global audience).

## Where things live

- The canonical skill is `plugins/prompt-engineering/skills/prompt-engineering/` (`SKILL.md` + `references/` + `assets/`).
- Adapters for other tools are in `adapters/` and share a common body mirrored from `SKILL.md`. **If you edit the skill's core principles, re-generate the adapters** so they don't drift. The reference docs are linked (not copied), so those stay in sync automatically.

## Making a change

1. Fork and branch (`feat/...`, `fix/...`, `docs/...`).
2. Make your change. If you touched JSON (`marketplace.json`, `plugin.json`, `gemini-extension.json`, `.cursor-plugin/plugin.json`), validate it parses.
3. Update `CHANGELOG.md` under an "Unreleased" heading.
4. Open a PR using the template. Describe what changed and why; link any source.

## Reporting issues

Use the issue templates: bug report, feature request, or platform support. For platform support, include the tool name, version, and what activation behavior you observed.

## License

By contributing, you agree your contributions are licensed under the project's [MIT License](LICENSE).
