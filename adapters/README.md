# Adapters — use this skill in other AI tools

The skill in this repo is, natively, a **Claude Code Agent Skill** (`SKILL.md` in `~/.claude/skills/`). That format is read only by Claude Code and Claude apps. Other AI coding tools use their own "rules" formats.

These adapters re-package the skill for each tool: a **lean, self-contained rule** with the core principles, decision table, and output format, plus a link back to the full reference docs in this repo (loaded on demand, so it doesn't bloat the context window).

> **Behavior caveat:** Claude Code and Windsurf can activate the skill **by intent** (you just say "improve this prompt"). Cursor activates by `@mention` or model decision. Codex, Copilot, and Gemini load rules either always-on or by file glob — there's no intent trigger, so you invoke it by asking explicitly. The wording differs; the content is the same.

| Tool | File | How it activates |
|------|------|------------------|
| Cursor | `.cursor/rules/prompt-engineering.mdc` | `@prompt-engineering` or model decision |
| Windsurf | `.windsurf/rules/prompt-engineering.md` | `model_decision` trigger (by intent) |
| GitHub Copilot | `.github/prompts/prompt-engineering.prompt.md` | `/prompt-engineering` in Copilot Chat |
| OpenAI Codex | `AGENTS.md` | always loaded; ask explicitly |

## Install

### Cursor
Copy `cursor/.cursor/rules/prompt-engineering.mdc` into your project at `.cursor/rules/`. Then in Cursor chat, type `@prompt-engineering` and paste your draft, or just ask to improve a prompt.
For a **global** rule (all projects), paste the same content into Cursor Settings → Rules → User Rules.

### Windsurf
Copy `windsurf/.windsurf/rules/prompt-engineering.md` into your project at `.windsurf/rules/`. The `model_decision` trigger lets Windsurf activate it automatically when you ask to improve a prompt.

### GitHub Copilot
Copy `copilot/.github/prompts/prompt-engineering.prompt.md` into your repo at `.github/prompts/`. Enable prompt files in VS Code (`"chat.promptFiles": true`). Then run `/prompt-engineering` in Copilot Chat.
(Prefer it always-on? Move the content into `.github/copilot-instructions.md` instead — but note that loads on every request.)

### OpenAI Codex
Copy `codex/AGENTS.md` to your repo root, or merge its content into an existing `AGENTS.md`. Codex loads it automatically. Ask "improve this prompt" to invoke. The same `AGENTS.md` is also read by several other AGENTS.md-aware tools.

### Other tools (Gemini CLI, Cline, Roo, Continue, Zed…)
No dedicated adapter, but the content is portable markdown. Use the **Codex `AGENTS.md`** as the base and rename/relocate to the tool's convention:
- Gemini CLI → `GEMINI.md`
- Cline → `.clinerules`
- Roo Code → `.roo/rules/`
- Continue.dev → a rule block in its config

## Keeping them in sync
All adapters share the same core body (mirrored from `SKILL.md`). When you update the skill, re-generate the adapters so they don't drift. The reference docs are linked, not copied, so those stay current automatically.
