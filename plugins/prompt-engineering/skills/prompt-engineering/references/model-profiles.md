# Profiles by target model

Prompt engineering rules diverge by model family. Adjust the rewrite to the target. Default = Claude 4.x.

## Claude 4.x (Opus 4.8/4.7/4.6, Sonnet 4.6, Haiku 4.5) — DEFAULT

**Key behavior:** follows instructions **literally**. Doesn't silently generalize or infer requests you didn't make. More concise and direct than previous generations.

**Do:**
- State **explicit scope**: "apply to ALL sections, not just the first".
- Use XML to structure (house standard).
- Say what to do (positive), not what to avoid.
- Give motivation to the instructions.
- Ask for a self-check before finalizing.
- For "above and beyond", ask explicitly ("go beyond the basics, complete implementation").

**Avoid:**
- Aggressive language ("CRITICAL: you MUST use X"). In 4.5/4.6 it causes **overtriggering** of tools/skills. Prefer "Use X when...".
- **Prefill** on the last assistant message — not supported in 4.6+. Use output contract / structured outputs.
- Over-prompting thoroughness — the models are already proactive; instructions like "if in doubt, use the tool" cause overtrigger.
- Forcing fixed verbosity — the model calibrates length to complexity; if you need a fixed length, instruct it explicitly.

**Thinking:** adaptive (4.6+) or off by default (Opus 4.8). With thinking off, the word "think" is sensitive — use "consider/evaluate/reason". For reasoning, prefer "think deeply" (general) over a prescriptive step-by-step — the model's reasoning usually beats the human script.

**Coding (Claude):**
- `xhigh`/`high` effort for coding and agentic.
- Explicit anti-overengineering: "only change what was requested or is clearly necessary; don't add features, docstrings, error handling, or abstractions that weren't asked for".
- Anti-hardcode: "general solution for all valid inputs, not just the tests; don't create helper scripts/workarounds".
- Anti-hallucination: "never speculate about code you haven't opened; read the file before answering".
- Autonomy/safety balance: ask for confirmation before destructive/irreversible actions (delete, force-push, actions on shared systems).

**Agentic (Claude):**
- Explicit instruction to **act** vs suggest ("change this function" > "can you suggest changes?").
- Parallel tool calls: encourage independent calls in parallel.
- Sub-agents: 4.6 tends to spawn too many; guide when it's worth it (parallel, isolated context) vs direct work.
- Long-horizon: state in structured files (JSON for status, free text for notes, git for checkpoints); incremental progress.

## OpenAI GPT / reasoning (GPT-5.x, o-series)

**GPT (non-reasoning):** precise, outcome-oriented prompts. "Describe what 'good' is, which constraints matter, what evidence exists, what the final answer should contain." Reserve ALWAYS/NEVER/must for real invariants (security, required fields).

**Reasoning models (o-series, GPT-5 reasoning):**
- Perform better with **high-level guidance**, not micro-steps. Give a clear objective + strong constraints + **explicit output contract**, without prescribing each intermediate step.
- Do **NOT** instruct "think step by step" / manual CoT — it can get in the way (they already reason internally).
- `reasoning_effort` controls effort/tool use (default medium; raise for complex tasks).
- Strong on dense, long documents (contracts, financial), at drawing parallels and deciding over implicit truths.

## Google Gemini

**PTCF framework** — the most reliable form:
- **Persona:** who the model is (and who the audience is).
- **Task:** the specific desired result.
- **Context:** relevant background information.
- **Format:** how the output should look.
- Clear delimiters (XML tags or markdown headings) between the parts.
- Iterative: treat templates as a starting point and refine.

## General portability rule

When adapting a prompt between families:
1. Claude → reasoning model: remove manual CoT and micro-steps; keep objective + output contract.
2. Reasoning model → Claude/classic GPT: add structure, examples, and (if analytical) CoT.
3. Any → Gemini: reorganize into the PTCF skeleton.
4. Always keep: role, output contract, constraints, `{{...}}` variables.
