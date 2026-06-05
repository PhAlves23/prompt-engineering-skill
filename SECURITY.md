# Security Policy

## Scope

This project is a documentation-only skill (Markdown + JSON + a small shell installer). It ships no runtime service and collects no data. The realistic security surface is:

- **`install.sh`** — runs on a user's machine via `curl | bash`.
- **JSON manifests** — consumed by host tools (Claude Code, Cursor, etc.).
- **Skill content** — text loaded into an AI agent's context.

## Reporting a vulnerability

If you find a security issue — for example, a way the installer could be abused, or skill content that could be weaponized for prompt injection against users — please report it privately first:

1. Use GitHub's **[Report a vulnerability](https://github.com/PhAlves23/prompt-engineering-skill/security/advisories/new)** (Security → Advisories) to open a private advisory, **or**
2. Open a minimal public issue asking the maintainer to make private contact, without disclosing details.

Please do **not** open a public issue describing an exploit before it's fixed.

### What to include
- A clear description and the affected file(s).
- Steps to reproduce or a proof of concept.
- The impact you foresee.

### What to expect
- An acknowledgement as soon as the maintainer sees it.
- An assessment and, if confirmed, a fix in a patch release with credit to you (unless you prefer to stay anonymous).

## Good practice for users

`curl | bash` runs code from the internet. Before piping any installer to your shell — including this one — you can read it first:

```bash
curl -fsSL https://raw.githubusercontent.com/PhAlves23/prompt-engineering-skill/main/install.sh | less
```

The installer only downloads this repository and copies the skill into `~/.claude/skills/`. It backs up any existing install and modifies nothing else.
