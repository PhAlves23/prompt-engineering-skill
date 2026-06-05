# Announcement templates

Ready-to-post copy for launching the skill. Adjust tone per channel. Replace links if you fork under a different owner.

---

## 1. Reddit — r/ClaudeAI (and r/ChatGPTCoding, r/cursor)

> Reddit rewards usefulness and honesty, punishes marketing speak. Lead with the value, not the pitch. No emoji-heavy hype.

**Title:** I built an open-source "prompt engineering" skill for Claude Code (+ Cursor, Copilot, Codex, Gemini) — it rewrites your prompt and tells you what it changed

**Body:**

I kept writing lazy prompts and getting lazy outputs, so I built a skill that fixes the prompt before you run it.

You paste a draft, it returns a rewritten, production-grade version plus a short changelog of *what changed and why* — calibrated to your task type and target model. It won't run the task, just improve the prompt (unless you ask).

What makes it different from the usual "10 prompt tips":
- **Grounded in primary sources** — every technique traces back to Anthropic, OpenAI, Google, or *The Prompt Report*'s taxonomy of 58 techniques. Not vibes.
- **Model-aware** — e.g. it removes "think step by step" for reasoning models (o-series / GPT-5 reasoning), where it actually hurts.
- **Anti-overengineering** — simple prompt gets a lean rewrite, not bloated with chain-of-thought it doesn't need.

It ships with 8 worked examples (classification, coding, extraction, research, agentic, long-context, roleplay), a quality checklist, and an evaluation guide for A/B testing your prompt.

Works in Claude Code (one-line install or plugin), GitHub Copilot, OpenAI Codex, Gemini CLI, OpenCode, Cursor, Windsurf, and Cline.

MIT licensed, contributions welcome (there are some `good first issue`s open):
https://github.com/PhAlves23/prompt-engineering-skill

Happy to answer questions or take suggestions on what to support next.

---

## 2. X / Twitter (thread)

**Tweet 1:**
I open-sourced a prompt-engineering skill for Claude Code.

Paste a rough draft → it rewrites it into a production-grade prompt + a changelog of what changed and why.

Grounded in actual sources (Anthropic, OpenAI, Google, The Prompt Report), not vibes.

🧵

**Tweet 2:**
Why it's different from "10 prompt tips":

- Every technique traces to a primary source
- Model-aware (it strips "think step by step" for reasoning models, where it backfires)
- Anti-overengineering — won't bloat a simple prompt

**Tweet 3:**
It works across 8 tools: Claude Code, Copilot, Codex, Gemini CLI, OpenCode, Cursor, Windsurf, Cline.

One-line install for Claude Code:
`curl -fsSL https://raw.githubusercontent.com/PhAlves23/prompt-engineering-skill/main/install.sh | bash`

**Tweet 4:**
Ships with 8 worked examples, a quality checklist, an evaluation guide, and prompt-injection defenses.

MIT licensed. Contributions welcome — a couple of good-first-issues are open.

https://github.com/PhAlves23/prompt-engineering-skill

---

## 3. LinkedIn

I just open-sourced a tool I'd been wanting for a while: a prompt-engineering skill that rewrites your prompt into a production-grade version — and explains every change.

Most prompt advice is generic tips. This one is grounded in primary sources (Anthropic, OpenAI, Google, and *The Prompt Report*'s taxonomy of 58 techniques), and it adapts to the model you're targeting.

It runs across 8 AI coding tools (Claude Code, Copilot, Codex, Gemini, OpenCode, Cursor, Windsurf, Cline), ships with worked examples and an evaluation guide, and it's MIT licensed.

If you work with LLMs, I'd love your feedback — and contributions are welcome.

https://github.com/PhAlves23/prompt-engineering-skill

---

## 4. Hacker News (Show HN)

**Title:** Show HN: A prompt-engineering skill that rewrites your prompt and explains the changes

**Body:**

I built this because I was tired of generic prompt advice. You give it a draft; it returns a rewritten prompt plus a changelog mapping each change to the weakness it fixes.

Design choices that matter:
- Grounded in primary sources (Anthropic, OpenAI, Google, The Prompt Report's 58-technique taxonomy) — each claim is cited.
- Model-aware: the rules differ by family, so it won't, e.g., force chain-of-thought on reasoning models.
- Anti-overengineering: it calibrates effort to complexity instead of bloating every prompt.

It's a Claude Code skill with adapters for Cursor, Windsurf, Copilot, Codex, Gemini, and OpenCode, generated from a single source so they don't drift. CI validates structure and commit hygiene.

MIT licensed: https://github.com/PhAlves23/prompt-engineering-skill

Feedback and contributions welcome.

---

## 5. Submitting to community directories

Open a PR or issue adding the repo to these curated lists (search the repo for the contribution format first):
- `ComposioHQ/awesome-claude-plugins`
- `Chat2AnyLLM/awesome-claude-plugins`
- `GetBindu/awesome-claude-code-and-skills`
- claudemarketplaces.com (submit form)

---

## Posting tips
- **Don't blast all channels at once.** Start with one (Reddit r/ClaudeAI is the best fit), learn from the response, refine the copy, then expand.
- **Reply to every comment** in the first 24h — early engagement drives reach on every platform.
- **Lead with the problem, not the repo.** People share things that solved a problem they recognize.
- Avoid emoji-heavy hype on Reddit/HN; it reads as marketing and gets downvoted.
