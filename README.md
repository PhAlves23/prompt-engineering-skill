# Prompt Engineering — a Claude Code skill

Turn a raw draft into a production-grade prompt. This skill rewrites and optimizes prompts using proven prompt engineering techniques, distilled from primary sources (Anthropic best practices + prompt improver, OpenAI GPT-5/reasoning guides, Google Gemini PTCF, and *The Prompt Report*'s taxonomy of 58 techniques).

It gives you a **rewritten prompt ready to paste** plus a **short changelog** of what changed and why — calibrated to your task type and target model.

## What's inside

- **Canonical structure** — role, context+motivation, sequential instructions, XML, few-shot, chain-of-thought, output contract, success criteria.
- **Technique selection** by task type (classification, extraction, generation, coding, reasoning, research, agentic, summarization) and by target model (Claude 4.x, OpenAI GPT/reasoning, Gemini).
- **Exhaustive technique index** — all 58 techniques from *The Prompt Report* plus vendor/post-2024 extras.
- **Worked examples** — full draft → optimized → changelog cases across every task type.
- **Quality checklist** and an **evaluation guide** (how to A/B test that the rewrite is actually better).
- **Prompt security** (injection/jailbreak) and **automatic optimization** (APE, OPRO, DSPy, MIPRO) references.

## Install

### Option A — one-line installer (simplest)

```bash
curl -fsSL https://raw.githubusercontent.com/PhAlves23/prompt-engineering-skill/main/install.sh | bash
```

This copies the skill into `~/.claude/skills/prompt-engineering`. It backs up any existing install and touches nothing else. Restart Claude Code afterwards.

### Option B — Claude Code plugin (versioned, updatable)

Inside Claude Code:

```
/plugin marketplace add PhAlves23/prompt-engineering-skill
/plugin install prompt-engineering
```

### Option C — manual

1. Download or clone this repo.
2. Copy `plugins/prompt-engineering/skills/prompt-engineering/` into `~/.claude/skills/`.
3. The final path must be `~/.claude/skills/prompt-engineering/SKILL.md`.
4. Restart Claude Code.

## Use

Once installed, in any Claude Code session:

- Type `/prompt-engineering` and paste your draft, or
- Just say **"improve this prompt"**, **"optimize this prompt"**, **"rewrite this prompt"**, or paste a draft asking to make it better.

The skill activates automatically and returns the optimized prompt + changelog. It improves the prompt — it does not run it (unless you ask).

## Other tools (Cursor, Codex, Copilot, Windsurf…)

This skill is natively a **Claude Code** Agent Skill. To use it in other AI tools, see [`adapters/`](adapters/) — it re-packages the skill as a lean rule for Cursor (`.cursor/rules`), Windsurf (`.windsurf/rules`), GitHub Copilot (`.github/prompts`), and OpenAI Codex (`AGENTS.md`), each in that tool's native format with install instructions. The full reference docs are linked, not copied, so they don't bloat the context window.

## Uninstall

- Installer/manual: `rm -rf ~/.claude/skills/prompt-engineering`
- Plugin: `/plugin uninstall prompt-engineering`

## Verify the install

```bash
test -f ~/.claude/skills/prompt-engineering/SKILL.md && echo "installed" || echo "not found"
```

## License

MIT — see [LICENSE](LICENSE). Free to use, modify, and redistribute with attribution.

---

> **Note for the maintainer:** the installer and the plugin commands above reference the repo `PhAlves23/prompt-engineering-skill` on the `main` branch. If you publish under a different GitHub owner or repo name, update the URLs in this README and in `install.sh`.
