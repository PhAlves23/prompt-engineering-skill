# Automatic Prompt Optimization (APO)

When the prompt is part of a system with an **evaluation dataset and ground truth**, you can optimize the prompt programmatically instead of by hand. Useful for production pipelines where measurable accuracy matters more than human effort. The skill recommends these tools when the user has evals; it doesn't run them.

## Methods / frameworks

- **APE (Automatic Prompt Engineer)** — the LLM paraphrases the prompt in several ways and selects the best candidate by model feedback on a metric.
- **OPRO (Optimization by PROmpting)** — a meta-prompt describes the optimization problem + previous solutions and their scores; the LLM proposes better prompts iteratively. Beat human prompts by up to 8% (GSM8K) and 50% (BBH).
- **DSPy** — treats prompts as **compilable code**: you define the signature/modules and optimizers (BootstrapFewShot, MIPRO) compile few-shots and instructions against ground truth. The most mature production pattern.
- **MIPRO** — jointly optimizes instructions and examples via Bayesian search.
- **TextGrad** — "textual gradients": uses natural-language critique as a gradient signal to edit the prompt.
- **ProTeGi** — prompt optimization with textual gradients + beam search.
- **Promptbreeder** — prompt evolution (mutation + selection) that also evolves the mutation prompts themselves.

## 2025–2026 (research-grade)
- **Self-Discover** — the model composes its own reasoning structure for the task.
- **Evoke / Promptomatix** — automated critique+edit pipelines.
Production adoption is still maturing; APE, OPRO, DSPy/MIPRO, TextGrad, and ProTeGi are the most used in 2026.

## When to recommend
- There's a **labeled dataset** and an objective metric → DSPy/MIPRO or OPRO.
- Want a quick win rewriting the instruction → APE/TextGrad.
- No dataset → stick to manual meta-prompting (this skill).

## Equivalent manual flow (no framework)
1. Define a metric + a small test set.
2. Generate K variations of the prompt (meta-prompting).
3. Run them all on the set, measure.
4. Take the best, generate variations of it (hill climbing).
5. Repeat until plateau. Record the winner and the metric.
