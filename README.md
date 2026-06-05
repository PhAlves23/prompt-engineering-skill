# Prompt Engineering — a Claude Code skill

Turn a raw draft into a production-grade prompt. This skill rewrites and optimizes prompts using proven prompt engineering techniques, distilled from primary sources — Anthropic best practices + prompt improver, OpenAI GPT-5/reasoning guides, Google Gemini PTCF, and *The Prompt Report*'s taxonomy of 58 techniques.

It returns a **rewritten prompt ready to paste** plus a **short changelog** of what changed and why — calibrated to your task type and target model.

It improves the prompt — it does not run it (unless you ask).

## How it works

You paste a draft (or describe what you want). The skill runs a 5-phase workflow — diagnose → select techniques → rewrite in a canonical structure → self-review against a checklist → deliver. It picks only the techniques that fit your task type and target model, preserves your `{{variables}}`, and explains every change.

## Installation

### Claude Code — one-line installer

```bash
curl -fsSL https://raw.githubusercontent.com/PhAlves23/prompt-engineering-skill/main/install.sh | bash
```

Copies the skill into `~/.claude/skills/prompt-engineering` (backs up any existing install, touches nothing else). Restart Claude Code afterward.

### Claude Code — plugin (versioned, updatable)

```
/plugin marketplace add PhAlves23/prompt-engineering-skill
/plugin install prompt-engineering
```

### GitHub Copilot CLI

The plugin marketplace works in Copilot CLI too:

```bash
copilot plugin marketplace add PhAlves23/prompt-engineering-skill
copilot plugin install prompt-engineering@prompt-engineering-marketplace
```

### OpenAI Codex (native skill discovery)

Codex discovers the full skill from `~/.agents/skills/`. See [`docs/INSTALL.codex.md`](docs/INSTALL.codex.md) — in short:

```bash
git clone https://github.com/PhAlves23/prompt-engineering-skill.git ~/.codex/prompt-engineering-skill
mkdir -p ~/.agents/skills
ln -s ~/.codex/prompt-engineering-skill/plugins/prompt-engineering/skills/prompt-engineering ~/.agents/skills/prompt-engineering
```

### Gemini CLI (extension)

```bash
gemini extensions install https://github.com/PhAlves23/prompt-engineering-skill
```

### Cursor / Windsurf (rules)

Copy the rule for your tool from [`adapters/`](adapters/):
- **Cursor** → `adapters/cursor/.cursor/rules/prompt-engineering.mdc` into your project's `.cursor/rules/` (invoke with `@prompt-engineering`). A native Cursor plugin manifest is also provided (`.cursor-plugin/plugin.json`).
- **Windsurf** → `adapters/windsurf/.windsurf/rules/prompt-engineering.md` into `.windsurf/rules/` (activates by intent).

See [`adapters/README.md`](adapters/README.md) for per-tool details and other tools (Cline, Roo, Continue, Zed).

### Manual (any Claude-compatible tool)

1. Copy `plugins/prompt-engineering/skills/prompt-engineering/` into your skills directory.
2. The final path must end in `.../prompt-engineering/SKILL.md`.
3. Restart the tool.

## Verify installation

Start a new session and ask for something that should trigger the skill — for example, "improve this prompt" with a draft pasted below it, or run `/prompt-engineering` in Claude Code. The agent should return an optimized prompt + a changelog.

```bash
# Claude Code / curl install:
test -f ~/.claude/skills/prompt-engineering/SKILL.md && echo "installed" || echo "not found"
```

## Use

Type `/prompt-engineering` (Claude Code / Copilot) or just say **"improve this prompt"**, **"optimize this prompt"**, **"rewrite this prompt"**, or paste a draft asking to make it better.

## What's inside

- **Canonical structure** — role, context+motivation, sequential instructions, XML, few-shot, chain-of-thought, output contract, success criteria.
- **Technique selection** by task type (classification, extraction, generation, coding, reasoning, research, agentic, summarization) and target model (Claude 4.x, OpenAI GPT/reasoning, Gemini).
- **Exhaustive technique index** — all 58 techniques from *The Prompt Report* plus vendor/post-2024 extras.
- **Worked examples** — 7 full draft → optimized → changelog cases across task types.
- **Quality checklist** + **evaluation guide** (A/B test that the rewrite is actually better).
- **Prompt security** (injection/jailbreak) and **automatic optimization** (APE, OPRO, DSPy, MIPRO) references.
- Every technique claim is traceable to a primary source in [`references/sources.md`](plugins/prompt-engineering/skills/prompt-engineering/references/sources.md).

## Updating

- **curl install:** re-run the installer.
- **Claude / Copilot plugin:** `/plugin update prompt-engineering`.
- **Codex symlink:** `cd ~/.codex/prompt-engineering-skill && git pull`.
- **Gemini extension:** `gemini extensions update prompt-engineering`.

## Uninstall

- curl / manual: `rm -rf ~/.claude/skills/prompt-engineering`
- Claude plugin: `/plugin uninstall prompt-engineering`
- Codex: `rm ~/.agents/skills/prompt-engineering`

## Contributing

Issues and PRs welcome — see [CONTRIBUTING.md](CONTRIBUTING.md) and the [Code of Conduct](CODE_OF_CONDUCT.md). The skill stays grounded in cited sources; if you change a technique claim, cite it.

## License

MIT — see [LICENSE](LICENSE). Free to use, modify, and redistribute with attribution.

---

> **Maintainer note:** installer and commands reference `PhAlves23/prompt-engineering-skill` on `main`. If you fork under a different owner, update the URLs in this README and in `install.sh`.
