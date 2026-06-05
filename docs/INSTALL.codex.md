# Installing Prompt Engineering for Codex

Codex discovers skills natively from `~/.agents/skills/`. Clone the repo and symlink the skill so Codex loads the **full** skill (not a stripped-down rule).

## Prerequisites
- Git

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/PhAlves23/prompt-engineering-skill.git ~/.codex/prompt-engineering-skill
   ```

2. **Create the skill symlink:**
   ```bash
   mkdir -p ~/.agents/skills
   ln -s ~/.codex/prompt-engineering-skill/plugins/prompt-engineering/skills/prompt-engineering ~/.agents/skills/prompt-engineering
   ```

   **Windows (PowerShell):**
   ```powershell
   New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.agents\skills"
   cmd /c mklink /J "$env:USERPROFILE\.agents\skills\prompt-engineering" "$env:USERPROFILE\.codex\prompt-engineering-skill\plugins\prompt-engineering\skills\prompt-engineering"
   ```

3. **Restart Codex** to discover the skill.

## Verify
```bash
ls -la ~/.agents/skills/prompt-engineering
```
You should see a symlink (or junction on Windows) pointing to the skill directory, containing `SKILL.md`.

## Use
Ask: "improve this prompt", "optimize this prompt", or paste a draft and ask to make it better.

## Updating
```bash
cd ~/.codex/prompt-engineering-skill && git pull
```
The skill updates instantly through the symlink.

## Uninstalling
```bash
rm ~/.agents/skills/prompt-engineering
```
Optionally delete the clone: `rm -rf ~/.codex/prompt-engineering-skill`.

---

> **Alternative (no clone):** if you only want the lightweight rule, copy [`adapters/codex/AGENTS.md`](../adapters/codex/AGENTS.md) to your repo root instead. The symlink method above is preferred — it gives Codex the complete skill with all reference docs.
