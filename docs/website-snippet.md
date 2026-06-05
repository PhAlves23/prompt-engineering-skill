## Prompt Engineering — AI skill

Turn a raw draft into a production-grade prompt. Returns a rewritten prompt + a changelog of what changed and why — calibrated to your task type and target model.

### Claude Code (recommended)

One-line install:

```bash
curl -fsSL https://raw.githubusercontent.com/PhAlves23/prompt-engineering-skill/main/install.sh | bash
```

Or install as a plugin (inside Claude Code):

```
/plugin marketplace add PhAlves23/prompt-engineering-skill
/plugin install prompt-engineering
```

Then restart Claude Code and run `/prompt-engineering` — or just say "improve this prompt".

### Other AI tools

Adapters re-package the skill for each tool's native rules format:

- **Cursor** — `.cursor/rules/` · invoke with `@prompt-engineering`
- **Windsurf** — `.windsurf/rules/` · activates by intent
- **GitHub Copilot** — `.github/prompts/` · run `/prompt-engineering`
- **OpenAI Codex** — `AGENTS.md` · ask to improve a prompt

[Setup guide for other tools →](https://github.com/PhAlves23/prompt-engineering-skill/tree/main/adapters) · [View on GitHub →](https://github.com/PhAlves23/prompt-engineering-skill)

_MIT licensed · free to use, modify, and share._
