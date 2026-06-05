# Evaluation — is the rewrite actually better?

A good rewrite *looks* better. To *know* it's better, test it. This is the lightweight loop the skill points to after delivery, before you commit a prompt to production. Distinct from `auto-optimization.md` (that one is for when you have a dataset and want a framework to optimize automatically; this one is the manual before/after check).

## When to bother
- **Skip it** for one-off prompts you'll run once and read the result of.
- **Do it** when the prompt is reused (a template called many times, a system prompt, an agent instruction) — there, a 5% quality shift compounds across every call.

## The quick A/B (no tooling)
1. **Freeze a test set.** 5–10 representative inputs, including 2–3 hard/edge cases. Reuse the same set for both versions.
2. **Run old vs new** on the identical inputs, same model, same settings.
3. **Score blind against a rubric**, not by vibes. Define 2–4 criteria up front (see below) and rate each output. Ideally, don't look at which version produced which output while scoring.
4. **Check the tail, not just the average.** A rewrite that lifts the average but breaks one edge case may be a regression. Inspect the worst output of each version.
5. **Keep the winner; record why.** Note which change drove the gain — that's reusable knowledge for the next rewrite.

## Criteria by task type
Pick the 2–4 that fit; don't score everything.

| Task type | What to measure |
|-----------|-----------------|
| Classification | Accuracy vs known labels; consistency on re-runs; correct enum format |
| Extraction | Field-level precision/recall; null-instead-of-invented rate; schema-valid JSON |
| Generation/writing | Adherence to tone/length/structure; factual correctness; no preamble leakage |
| Reasoning/analysis | Correct conclusion; sound steps (not just right answer); caught the trade-offs |
| Research | Claims sourced; competing options addressed; recommendation actionable |
| Coding | Tests pass; scope respected (no unrequested refactor); no hardcode/hallucination |
| Agentic | Right tool chosen; acted vs only suggested; stopped at safety gates; reached done criterion |
| Summarization | Coverage of key points; grounded in source; length respected |

## Cheap signals worth tracking
- **Format compliance rate** — % of outputs that parse / match the contract on the first try. The single most predictive metric for production prompts.
- **Reruns under temperature** — run the same input 3× with temperature > 0. High variance on a task that should be deterministic = the prompt is under-specified.
- **Token cost** — a rewrite that adds CoT/examples costs more per call. Confirm the quality gain is worth the latency/cost, especially for high-volume templates.
- **Refusal / hedge rate** — for prompts that should answer directly, count how often the model hedges or asks back.

## LLM-as-judge (when the test set grows)
For 20+ cases where manual scoring is tedious, have a separate model grade outputs against your rubric. Make it return a structured verdict (score + one-line reason per criterion), and spot-check ~20% of its judgments by hand — judges drift, especially on subjective criteria. Don't use the same prompt-under-test as its own judge.

## Regression guard
Once a prompt is in production, keep its frozen test set. Re-run it whenever you:
- edit the prompt,
- switch model versions (a prompt tuned for one model can regress on the next),
- change surrounding context (tools, retrieved data, system prompt).
A prompt that worked is not a prompt that keeps working — model upgrades and context shifts both move the target.
