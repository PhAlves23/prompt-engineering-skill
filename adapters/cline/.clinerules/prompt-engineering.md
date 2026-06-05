# .clinerules — Prompt Engineering

> Drop this file into your project at .clinerules/prompt-engineering.md.
> Cline loads markdown files from the .clinerules directory as workspace rules.
> To use the skill, ask: "improve this prompt", "optimize this prompt",
> or paste a draft and ask to make it better.


# Prompt Engineering

Turn a raw draft into a production-grade prompt. **Improve the prompt, don't run it** — return a rewritten version + a short changelog. Only execute the task the prompt describes if the user explicitly asks.

## Operating principle
- Calibrate effort to complexity. Simple prompt → lean structural rewrite. Complex prompt (reasoning, classification, generation with criteria, agentic) → full structure. Don't over-engineer.
- If the draft is already good, say so and do the minimum. Don't invent changes to justify a rewrite.
- Default target model is Claude 4.x. If the user names another (GPT/o-series, Gemini), adjust accordingly (reasoning models do NOT want "think step by step").
- Preserve every `{{variable}}` from the original. Convert negative instructions into positive ones. Add motivation to non-obvious instructions.

## Workflow
1. **Diagnose** — real intent, task type, target model, audience, output format, constraints, dynamic variables, draft weaknesses.
2. **Select techniques** — only those that add value (see decision table).
3. **Rewrite** in the canonical structure.
4. **Self-review** — could a colleague with no context run this without doubt? Fix what fails.
5. **Deliver** — optimized prompt + changelog.

## Canonical structure (omit sections that don't add value)
1. **Role/persona** — one line: who the model is + domain.
2. **Task + objective** — what to produce + success criterion (outcome-oriented).
3. **Context + motivation** — background + *why* it matters.
4. **Data/inputs** — in XML tags. Long-context (20k+ tokens): long data at the TOP, question at the END (+up to 30% quality).
5. **Instructions** — numbered when order matters, positive, explicit scope ("apply to ALL sections, not just the first").
6. **Reasoning** — `<thinking>` block for analytical tasks; NOT for reasoning models.
7. **Examples (few-shot)** — 3–5 diverse, in `<example>` tags. Strongest lever for format/tone.
8. **Output contract** — exact format (JSON schema, XML, "result only, no preamble"). Say what to do, not what to avoid.

## Golden rules
1. Explicit clarity — treat the model as a brilliant employee with no context on your norms.
2. Positive > negative.
3. Context + motivation improves generalization.
4. Explicit scope (Claude 4.x is literal).
5. Outcome over steps for reasoning models.
6. XML to structure.
7. Examples are the strongest lever for format/tone/consistency.
8. CoT for reasoning — separate `<thinking>` from `<answer>`.
9. Match style (prompt style → output style); variables in `{{double_brackets}}`.
10. Define success criteria.
11. No prefill in Claude 4.6+ → use output contract / structured outputs.
12. Structure beats psychological tricks ("this is important", "take a deep breath" are null/negative in modern models).
13. Delimit untrusted input + declare instruction priority when processing user/web/doc text or operating as an agent.
14. Heavy techniques (self-consistency, Tree-of-Thoughts, maieutic) cost N× tokens — only when criticality justifies it.

## Technique → task decision table
| Task type | Core techniques |
|-----------|-----------------|
| Classification | Role, XML inputs, diverse few-shot, short CoT, enum output |
| Structured extraction | Role, XML, JSON schema, grounding by quotes, null-not-invent |
| Generation/writing | Role, persona+audience, tone examples, format, constraints |
| Coding | Clear objective, explicit scope, anti-overengineering, anti-hardcode, self-check |
| Reasoning/analysis | CoT (non-reasoning) or high-level goal (reasoning), self-check/Reflexion |
| Research | Success criteria, competing hypotheses, multi-source verification, decomposition |
| Agentic/tool-use | Explicit action instruction, ReAct, parallel tool calls, autonomy/safety balance |
| Summarization | Long-context layout (data at top), grounding, length output contract |

## Output format
```
## Optimized prompt
<code block with the final prompt, ready to paste — preserving {{variables}}>

## What changed
- <technique applied> — <why / which weakness it fixes>   (4–8 bullets)

## Assumptions / open questions
- <only if any>
```

## Deep references (full skill)
For exhaustive technique detail, worked examples, model profiles, and the evaluation guide, see the source repo:
https://github.com/PhAlves23/prompt-engineering-skill/tree/main/plugins/prompt-engineering/skills/prompt-engineering/references