---
name: prompt-engineering
description: Optimizes and rewrites prompts using proven prompt engineering techniques — draft diagnosis, canonical structure (role, context+motivation, sequential instructions, XML, few-shot, chain-of-thought, output contract, success criteria), technique selection by task type and by target model (Claude 4.x, OpenAI reasoning/GPT, Gemini). Use when the user says "/prompt-engineering", "improve this prompt", "optimize this prompt", "rewrite this prompt", "apply best practices to this prompt", "turn this into a good prompt", or pastes a prompt draft asking to make it better. Reusable across any project.
license: MIT
---

# Prompt Engineering

Turns a raw draft into a production-grade prompt by applying proven prompt engineering techniques. Distilled from primary sources (Anthropic prompting best practices + prompt improver, OpenAI GPT-5/reasoning guides, Google Gemini PTCF, The Prompt Report) — see `references/` for the full material.

## Purpose

The user sends a prompt draft (or describes what they want). The skill returns a **rewritten, optimized version**, ready to paste, plus a **short changelog** of what changed and why. It is not meant to answer the prompt — it is meant to improve the prompt.

## Operating principle

- **Improve the prompt, don't run it.** This skill rewrites the prompt; it does not respond to the task the prompt describes. If the request is ambiguous (the user pasted a prompt without saying what they want), the default is to **optimize the prompt** and, at the end, offer to run it. Only execute the task if the user explicitly asks ("run this prompt", "answer this").
- **Produce directly.** Don't ask for permission. Only ask clarifying questions (1–3, max) when missing information would materially change the rewrite — expected output type, target model, or audience. If unanswered, assume the most sensible default, **state the assumption** in the changelog, and proceed.
- **Calibrate effort to complexity.** Simple prompt (lookup, formatting) → lean structural rewrite, no inflating with CoT/examples. Complex prompt (reasoning, classification, generation with criteria, agentic) → full structure. Don't decorate beyond what's needed — prompt over-engineering hurts latency and cost with no gain.
- **If the draft is already good, say so and do the minimum.** Don't invent changes to justify the rewrite. Apply the anti-overengineering rule to yourself: when the prompt already has solid role, structure, scope, and output contract, deliver only the marginal tweaks that genuinely add value and state that the rest was already good. Rewriting a good prompt into something "different but not better" is a failure.
- **Optimize for the right model.** The default is Claude 4.x. If the user indicates another target (GPT/o-series, Gemini), adjust per `references/model-profiles.md` — the rules diverge (e.g. reasoning models do NOT want "think step by step").

## Workflow (5 phases)

Inspired by Anthropic's official prompt improver flow (example identification → initial draft → CoT refinement → example enhancement), expanded with diagnosis and technique selection.

### Phase 1 — Diagnosis
Extract from the draft (and from conversation context):
- **Real intent:** what the user actually wants the model to produce.
- **Task type:** classification · extraction · generation/writing · coding · reasoning/analysis · research · agentic/tool-use · transformation/summarization · roleplay/persona. (Map in `references/task-patterns.md`.)
- **Target model:** Claude 4.x (default) · OpenAI GPT/reasoning · Gemini · other.
- **Audience and output format:** who reads it, in what form (JSON, prose, bullets, table, code).
- **Constraints and invariants:** hard limits (length, tone, what to never do).
- **Dynamic variables:** parts that change on each call → become `{{placeholders}}`.
- **Draft weaknesses:** ambiguity, negative instruction, missing context/motivation, no success criterion, undefined format, missing or inconsistent examples.

### Phase 2 — Technique selection
Pick techniques from the decision table below (detail in `references/techniques.md`). Apply only those that add value to the task. Mentally note the why of each — it goes in the changelog.

### Phase 3 — Rewrite
Build the prompt in the **canonical structure** (below), applying the selected techniques and the **golden rules**. Preserve every `{{...}}` variable from the original. Convert negative instructions into positive ones. Add motivation to non-obvious instructions. Mirror the rigor level and the format of the cases in `references/worked-examples.md`.

### Phase 4 — Self-review
Run `references/quality-checklist.md` against the rewritten version. Fix whatever fails before delivering. Golden test: *"could a colleague with no context execute this prompt without doubt?"* If not, adjust.

### Phase 5 — Delivery
Return in the output format (below): optimized prompt in a copyable block + changelog + open questions (if any). When useful, point to `references/evaluation.md` so the user can A/B test the before/after.

## Canonical structure of the optimized prompt

Recommended order (omit sections that don't add value for the task at hand):

1. **Role/persona** — one line defining who the model is and its domain. Focuses tone and behavior.
2. **Task + objective** — what to produce and the success criterion. Outcome-oriented.
3. **Context + motivation** — background information and *why* it matters (the model generalizes from the why).
4. **Data/inputs** — in XML tags. In long-context (20k+ tokens), long data goes **at the top**, before the instructions; the question goes **at the end** (up to +30% quality).
5. **Instructions** — sequential numbered steps when order matters. Positive ("do X"), not negative ("don't do Y"). Explicit scope (Claude 4.x is literal: "apply to ALL sections, not just the first").
6. **Reasoning** — when the task requires analysis, ask for a `<thinking>`/`<analysis>` block before the answer (CoT). NOT in reasoning models (o-series, GPT-5 reasoning) — see model-profiles.
7. **Examples (few-shot)** — 3–5 relevant and diverse examples, in `<example>`/`<examples>`, showing input→reasoning→output. Especially for format/tone/classification.
8. **Output contract** — exact output format (JSON schema, XML tags, "result only, no preamble"). Say what to do, not what to avoid.

## Golden rules (distilled from the sources)

1. **Explicit clarity.** Treat the model as a brilliant employee with no context on your norms. Specify format and constraints.
2. **Positive > negative.** "Write in flowing prose" beats "don't use markdown". Positive examples > prohibitions.
3. **Context and motivation.** Explain the why behind instructions — it improves generalization.
4. **Explicit scope (Claude 4.x).** The model is literal; it does not infer requests you didn't make. State the breadth.
5. **Outcome over steps (reasoning models).** GPT-5/o-series perform better with objective + constraints + output contract, without micromanaging the intermediate steps. Don't force "think step by step" on them.
6. **XML to structure.** Consistent, descriptive tags separate instruction, context, data, and examples. Nest when there's hierarchy.
7. **Examples are the strongest lever** for format/tone/consistency. 3–5, diverse, in tags.
8. **CoT for reasoning.** Ask for reasoning before the answer in analytical tasks — but separate reasoning (`<thinking>`) from the final output (`<answer>`).
9. **Match style.** The prompt's style influences the output's style. Want markdown-free output? Write the prompt without markdown. Dynamic variables in `{{double_brackets}}`, ideally wrapped in XML, for reuse and testing.
10. **Success criteria.** Define what counts as a good answer. In research/analysis, ask for cross-source verification and competing hypotheses.
11. **No prefill in Claude 4.6+.** Prefill on the last assistant message is no longer supported; use output contract / structured outputs.
12. **Structure > psychological trick.** Emotion prompting ("this is important to me"), "take a deep breath", and the like used to give a gain in older models, but they are **null or negative** in Claude 4.x / GPT-5. Don't use them; solve it with structure.
13. **Security when there's untrusted input.** If the prompt processes user/web/doc text or operates as an agent with tools, delimit the data and declare instruction priority (see `references/prompt-security.md`).
14. **Cost of heavy techniques.** Ensembling (self-consistency, DiVeRSe) and search (Tree-of-Thoughts, maieutic) cost N× tokens. Only when criticality justifies it.

## Technique → task decision table

| Task type | Core techniques | Reference to load |
|-----------|-----------------|-------------------|
| Classification | Role, XML inputs, diverse few-shot, short CoT, enum output | techniques + task-patterns |
| Structured extraction | Role, XML, output schema (JSON), grounding by quotes | task-patterns |
| Generation/writing | Role, persona+audience, tone examples, format, constraints | task-patterns |
| Coding | Clear objective, constraints, explicit scope, anti-overengineering, output contract | model-profiles (Claude coding) |
| Reasoning/analysis | CoT (non-reasoning models) or high-level goal (reasoning models), self-check/Reflexion; Least-to-Most or Tree-of-Thoughts on hard problems | techniques + model-profiles |
| Research | Success criteria, competing hypotheses, multi-source verification, decomposition, RAG/Generated Knowledge | techniques |
| Agentic/tool-use | Explicit action instruction, ReAct, parallel tool calls, autonomy/safety balance, context engineering (just-in-time retrieval, compaction, note-taking, sub-agents) | techniques + model-profiles |
| Summarization/transformation | Long-context layout (data at top), grounding, output contract (length) | techniques |

## Skill output format

Always respond like this:

```
## Optimized prompt

<code block with the final prompt, ready to paste — preserving {{variables}}>

## What changed
- <technique applied> — <why / which weakness it fixes>
- ... (4–8 bullets, concise)

## Assumptions / open questions
- <only if any — assumed defaults or a doubt worth confirming>
```

If the user asks for variations (e.g. lean version vs full version, or Claude version vs GPT version), deliver both in separate blocks.

## When to load the references

- `references/techniques.md` — applied catalog of the highest-return techniques (zero/few-shot, zero-shot modifiers, CoT and variants, decomposition with PAL/PoT code, ensembling, self-criticism CoVe/Reflexion, RAG, **context engineering** for agents) with when to use each. Load when choosing reasoning/research/agentic techniques.
- `references/technique-index.md` — **exhaustive index** of ALL known techniques (The Prompt Report's taxonomy of 58 + extras), by category. Load to make sure no approach was forgotten, or when the user asks for total coverage.
- `references/model-profiles.md` — differences between Claude 4.x, OpenAI GPT/reasoning, and Gemini. Load whenever the target isn't Claude default, or for coding/agentic.
- `references/task-patterns.md` — ready-made templates by task type. Load to build the structure for classification/extraction/generation.
- `references/worked-examples.md` — complete examples (draft → optimized → changelog), including the "already-good prompt" case. Load to calibrate the quality bar and the output format, especially when in doubt about how much to rewrite.
- `references/quality-checklist.md` — self-review checklist (Phase 4). Load always before delivering.
- `references/evaluation.md` — how to test whether the rewrite is actually better (quick A/B, metrics by task type, regression guard). Load when the user wants to validate the gain or has a small test set.
- `references/prompt-security.md` — defense against prompt injection/jailbreak. Load when the prompt processes untrusted input or operates as an agent.
- `references/auto-optimization.md` — automatic prompt optimization (APE, OPRO, DSPy, MIPRO...). Load when the user has a dataset/evals and wants programmatic optimization.
- `references/sources.md` — all the links to primary sources and papers. Load when you need to cite/update the base.
- `assets/canonical-template.md` — reusable XML skeleton of the canonical prompt.

## Scope note

This skill covers **text prompting**. Image/audio/video generation prompting (Midjourney, DALL·E, Veo, etc.) is out of scope — the structural principles transfer partially, but the modality-specific levers (aspect ratio, style refs, weights) are not covered here.
