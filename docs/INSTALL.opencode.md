# Installing Prompt Engineering for OpenCode

OpenCode supports skills natively and also reads `AGENTS.md`. Two ways to install, simplest first.

## Option A — AGENTS.md (simplest)

OpenCode is AGENTS.md-aware. Copy the adapter to your repo root (or merge into an existing `AGENTS.md`):

```bash
curl -fsSL https://raw.githubusercontent.com/PhAlves23/prompt-engineering-skill/main/adapters/codex/AGENTS.md -o AGENTS.md
```

Restart OpenCode. Ask "improve this prompt" to use it. This gives you the lean rule (core principles + decision table + links to the full references).

## Option B — native skill (full skill)

Clone the repo and point OpenCode's skills config at the skill directory so you get the complete skill with all reference docs.

1. **Clone:**
   ```bash
   git clone https://github.com/PhAlves23/prompt-engineering-skill.git ~/.config/opencode/prompt-engineering-skill
   ```

2. **Register the skills path** in your `opencode.json` (global at `~/.config/opencode/opencode.json`, or project-level):
   ```json
   {
     "skills": {
       "paths": [
         "~/.config/opencode/prompt-engineering-skill/plugins/prompt-engineering/skills"
       ]
     }
   }
   ```
   > Check your OpenCode version's docs for the exact skills-path key if this one isn't recognized — the config schema has evolved across releases.

3. **Restart OpenCode.**

## Verify

Use OpenCode's native `skill` tool:
```
use skill tool to list skills
```
You should see `prompt-engineering` listed.

## Updating

```bash
cd ~/.config/opencode/prompt-engineering-skill && git pull
```

## Uninstalling

- Option A: delete the `AGENTS.md` content you added.
- Option B: remove the `skills.paths` entry and `rm -rf ~/.config/opencode/prompt-engineering-skill`.
