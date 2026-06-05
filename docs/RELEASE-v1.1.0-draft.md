# Release draft — v1.1.0

> Draft notes for the next release. Publish with:
> `gh release create v1.1.0 --title "v1.1.0" --notes-file docs/RELEASE-v1.1.0-draft.md`
> Before publishing: bump `version` in `plugin.json`, `.cursor-plugin/plugin.json`,
> `gemini-extension.json`, and the README badge; move the CHANGELOG `[Unreleased]`
> items under a `## [1.1.0] - <date>` heading.

---

The first community release. Thanks to everyone who contributed.

## Highlights
- **More tools, more examples** — broader platform coverage and richer worked examples, all from community contributions.

## Added
- **Cline adapter** (`.clinerules/prompt-engineering.md`), generated from the single source. (#4, @saurabhhhcodes)
- **Roleplay / persona worked example** in `worked-examples.md`. (#3, @saurabhhhcodes)
- **Conventional Commits enforcement** in CI (`commitlint` workflow).
- **Announcement templates** for launch (`docs/announcement-templates.md`).

## Pending (include when merged before cutting the release)
- [ ] **Roo Code adapter** (`.roo/rules/`) — issue #5
- [ ] **Translation / localization worked example** — issue #6

## Internal / maintenance (since v1.0.0)
- Single-source adapter generation (`adapters/_core.md` + `scripts/build-adapters.sh`) with a CI sync check.
- Professional documentation pass: README badges/TOC/before-after demo, beginner-friendly CONTRIBUTING, SECURITY policy, DEVELOPMENT guide.
- `CITATION.cff`, `.github/CODEOWNERS`, structured YAML issue forms, repository topics.
- Commit history normalized to Conventional Commits.

## Contributors
- @saurabhhhcodes — first external contributor (#3, #4)

## Install / upgrade
Plugin users: `/plugin update prompt-engineering`. curl users: re-run the installer. Full instructions in the [README](https://github.com/PhAlves23/prompt-engineering-skill#installation).

**Full changelog:** https://github.com/PhAlves23/prompt-engineering-skill/compare/v1.0.0...v1.1.0
