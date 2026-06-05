# Contributing

Thanks for your interest in improving the Prompt Engineering skill. Contributions of every size are welcome — a typo fix, a sharper instruction, a new worked example, or support for another tool.

This guide assumes you've never contributed to an open-source project before, so it spells out each step.

## Table of contents

- [Ground rules](#ground-rules)
- [Ways to contribute](#ways-to-contribute)
- [Development setup](#development-setup)
- [How the adapters work (important)](#how-the-adapters-work-important)
- [The contribution workflow](#the-contribution-workflow)
- [Commit and PR conventions](#commit-and-pr-conventions)
- [What happens after you open a PR](#what-happens-after-you-open-a-pr)
- [Reporting issues](#reporting-issues)

## Ground rules

- **Cite your sources.** This skill's credibility comes from being grounded in primary sources. If you add or change a technique claim, add the reference to [`references/sources.md`](plugins/prompt-engineering/skills/prompt-engineering/references/sources.md).
- **Keep it model-aware.** If a change is specific to a model family, say which (see [`references/model-profiles.md`](plugins/prompt-engineering/skills/prompt-engineering/references/model-profiles.md)).
- **Don't over-engineer.** The skill preaches anti-overengineering — apply it to the skill. Prefer the smallest change that adds real value.
- **English only** for skill content (the skill targets a global audience).
- **Be respectful.** See the [Code of Conduct](CODE_OF_CONDUCT.md).

## Ways to contribute

- **Fix or sharpen content** in the skill or its references.
- **Add a worked example** for a task type that's underrepresented.
- **Improve platform support** — a new adapter, or a fix for how an existing tool activates the skill.
- **Improve docs** — installation, troubleshooting, clarity.
- **Report a bug or request a feature** via the issue templates.

## Development setup

No build toolchain or language runtime is required — the skill is Markdown + JSON. You only need `git` and `bash`.

```bash
# 1. Fork the repo on GitHub (button in the top-right of the repo page).
# 2. Clone YOUR fork:
git clone https://github.com/<your-username>/prompt-engineering-skill.git
cd prompt-engineering-skill

# 3. Test the skill locally in Claude Code by symlinking it:
ln -s "$(pwd)/plugins/prompt-engineering/skills/prompt-engineering" ~/.claude/skills/prompt-engineering-dev
# Restart Claude Code; the dev copy appears alongside any installed version.
```

To run the same checks CI runs, before pushing:

```bash
# JSON valid?
find . -name '*.json' -not -path './.git/*' -exec python3 -m json.tool {} \; > /dev/null && echo "JSON ok"

# Adapters in sync with their source?
./scripts/build-adapters.sh --check

# Installer syntax?
bash -n install.sh
```

## How the adapters work (important)

The skill has **two layers**, and they have different sources of truth:

1. **The full skill** lives in `plugins/prompt-engineering/skills/prompt-engineering/` (`SKILL.md` + `references/`). This is the complete, authoritative version used by Claude Code, Codex (native), and OpenCode (native).

2. **The lean adapters** for Cursor, Windsurf, Copilot, Codex (`AGENTS.md`), and Gemini are **generated** from a single file: [`adapters/_core.md`](adapters/_core.md). They are condensed versions that link back to the full references online, so they don't bloat the context window.

**This means:** never hand-edit the adapter files directly. Edit `adapters/_core.md`, then regenerate:

```bash
./scripts/build-adapters.sh
```

CI runs `./scripts/build-adapters.sh --check` and **fails the PR if the committed adapters don't match `_core.md`** — this prevents the adapters from silently drifting out of sync. If your PR fails on that check, run the build and commit the result.

If you change the **full skill's** core principles in a way that should also reach the lean adapters, update `adapters/_core.md` to match, then rebuild.

## The contribution workflow

This is the standard GitHub "fork and pull request" flow:

1. **Create a branch** in your fork with a descriptive name:
   ```bash
   git checkout -b feat/add-roleplay-example
   ```
   Use prefixes: `feat/`, `fix/`, `docs/`, `chore/`.

2. **Make your change.** Edit the relevant file. If you touched `_core.md`, run `./scripts/build-adapters.sh`. If you touched JSON, confirm it parses.

3. **Update the changelog.** Add a bullet under an `## [Unreleased]` heading at the top of [`CHANGELOG.md`](CHANGELOG.md) (create the heading if it isn't there).

4. **Commit** (see conventions below) and **push** to your fork:
   ```bash
   git add -A
   git commit -m "docs: add roleplay worked example"
   git push origin feat/add-roleplay-example
   ```

5. **Open a Pull Request.** GitHub will show a "Compare & pull request" button after you push. The PR template will load — fill it in, describing what changed and why, and link any source.

6. **Respond to review.** A maintainer will comment. Push more commits to the same branch to address feedback; the PR updates automatically.

## Commit and PR conventions

- **Commit messages:** short imperative summary, optionally prefixed (`feat:`, `fix:`, `docs:`, `chore:`). Example: `fix: correct the long-context layout rule`.
- **One logical change per PR.** Smaller PRs are reviewed and merged faster.
- **Fill in the PR checklist** (sources cited, adapters rebuilt, JSON valid, changelog updated).

## What happens after you open a PR

1. **CI runs automatically** (the "Validate" workflow). It must be green.
2. **A maintainer reviews** for correctness, source grounding, and fit. Expect questions or change requests — that's normal and not a rejection.
3. **Merge.** Once approved and green, the maintainer merges. Your contribution ships in the next release and you're credited in the changelog.

## Reporting issues

Use the templates under [Issues](https://github.com/PhAlves23/prompt-engineering-skill/issues/new/choose):

- **Bug report** — something doesn't work.
- **Feature request** — a technique, example, or behavior to add (cite the source).
- **Platform support** — activation/install behavior on a specific tool.

By contributing, you agree your contributions are licensed under the project's [MIT License](LICENSE).
