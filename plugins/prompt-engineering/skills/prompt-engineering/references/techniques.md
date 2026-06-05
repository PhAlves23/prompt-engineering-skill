# Prompting technique catalog

Reference of the relevant techniques, with **when to use** and **when NOT to use**. Based on Anthropic best practices, The Prompt Report (taxonomy of 58 techniques), promptingguide.ai, OpenAI/Google guides.

## Fundamentals (almost always)

### Direct zero-shot
Clear instruction with no examples. Default for simple, well-defined tasks.
- **Use:** lookup, trivial formatting, a task the model already masters.
- **Avoid:** when format/tone/edge cases matter — use few-shot there.

### Role / persona prompting
Defines who the model is ("You are a senior financial analyst..."). Focuses tone, vocabulary, and depth.
- **Use:** whenever tone/domain matter. One sentence already changes the result.
- **Caution:** a generic persona doesn't help; be specific about the domain and the audience.

### Context + motivation
Give the *why* behind the instruction. The model generalizes better from the motivation.
- E.g.: instead of "never use ellipses", say "the output will be read by a TTS engine that doesn't pronounce ellipses".

### Structuring with XML
Descriptive tags (`<context>`, `<instructions>`, `<input>`, `<example>`) separate components and reduce misinterpretation. Nest into hierarchy (`<documents><document index="1">...`).
- **Use:** any prompt mixing instruction + data + examples. The house standard for Claude.

## Few-shot / multishot

2–5 input→output examples (ideally input→reasoning→output). The most reliable lever for format, tone, and consistency.
- **Example quality:** relevant (mirror the real case), diverse (cover edge cases, no accidental pattern), structured (in `<example>` tags).
- **Quantity:** 3–5 is the best cost-benefit. You can ask the model to evaluate/generate examples.
- **Use:** classification, extraction, specific format, tone of voice.
- **Avoid:** when examples bias toward a single pattern and the task needs generalization — diversify.
- **Example selection/ordering matters (ICL):** pick examples similar to the input (KNN/Vote-K), balance classes, and mind the order — examples at the end carry more weight. In classification, cover all labels.

## Zero-shot — prompt modifiers

Techniques that improve the answer without examples, just by altering the instruction.

### Expert prompting
Variant of Role (see Fundamentals): persona of a **specialist in the exact domain** ("You are a senior epidemiologist reviewing..."), raising depth and technical vocabulary. Combine with the audience ("...explaining to a layperson").

### Style prompting
Specifies the desired style (tone, format, length) directly in the instruction, rather than via examples.

### Emotion prompting (EmotionPrompt) — USE WITH SKEPTICISM
Adds an emotional appeal ("this is very important to my career"). Showed a gain in older models. **In modern models (Claude 4.x, GPT-5) the effect is null or negative** — structure beats psychological trick. The same goes for "take a deep breath": it worked in some old Google models, not in Claude. **Default: don't use; prefer structure.**

### Rephrase and Respond (RaR)
Instructs the model to **rephrase the question in its own words before answering**. Clarifies intent and reduces misunderstanding. "Rephrase and expand the question, then answer."

### Re-reading (RE2)
Asks it to **re-read the question** ("Read the question again:" + repeats the input). Improves comprehension on complex queries, cheap.

### Self-Ask
The model decides whether it needs **follow-up sub-questions**, answers each, and then composes the final answer. Good for multi-hop questions (reasoning over several facts).

### System 2 Attention (S2A)
First rewrites the context **removing irrelevant/distracting information**, then answers over the clean context. Reduces the effect of noise and conflicting info.

### SimToM (Simulation Theory of Mind)
For scenarios with multiple actors/perspectives: establishes what each agent knows before answering. Useful in theory-of-mind tasks.

## Reasoning

### Chain-of-Thought (CoT)
Asks for step-by-step reasoning before the answer. Big gain in math, logic, hard classification (studies show jumps of ~18%→79% in reasoning).
- **Zero-shot CoT:** "Think through the problem before answering."
- **Few-shot CoT:** examples that show the reasoning in `<thinking>`.
- **Structure it:** separate reasoning (`<thinking>`/`<analysis>`) from the final output (`<answer>`).
- **Use:** analytical, multi-step tasks, decisions with trade-offs.
- **Do NOT use:** in reasoning models (OpenAI o-series, GPT-5 reasoning) — they already reason internally and "think step by step" can hurt. In Claude with extended thinking off, the word "think" is sensitive — use "consider/evaluate/reason".

### Self-consistency
Samples multiple reasoning paths (CoT with temperature) and picks the majority answer. Increases robustness in arithmetic/common sense.
- **Use:** when you need high reliability and can pay N samples. In a single-shot prompt, it translates to "generate 3 independent approaches and reconcile them".
- **Cost:** N× tokens. Reserve for high criticality.

### Self-check / verification
"Before finalizing, verify your answer against [criterion]." Catches errors cheaply, especially coding/math.
- **Use:** almost always in tasks with a verifiable answer.

### Step-back / decomposition
Break a complex problem into sub-questions, or step back to a more general principle before solving.
- **Use:** research, large problems, when the direct path fails.

### Least-to-Most (Zhou et al. 2022)
Explicitly decomposes the problem into subproblems ordered from easiest to hardest, and solves them in a chain — each solution feeds the next.
- **Difference from step-back:** explicit, progressive ordering; the output of one subproblem becomes the input of the next.
- **Use:** complex reasoning with sequential dependency (multi-step math, composite problems).

### Tree of Thoughts — ToT (Yao et al. 2023)
Explores **multiple reasoning branches in parallel**, evaluates each, and discards the ones that don't lead to the solution (search + backtracking, not a linear chain).
- **Use:** problems where there are several plausible approaches and you need to compare/backtrack (planning, puzzles, optimization).
- **Cost:** far more tokens than CoT. Reserve for problems that linear CoT can't solve. In single-shot, it translates to "generate 3 distinct lines of reasoning, evaluate each, and proceed only with the most promising one".

### Skeleton-of-Thought
First generates a **skeleton** of the answer (topics/structure), then expands each point.
- **Use:** long, structured answers; keeps coverage without losing the thread and eases parallelization.

### Generated Knowledge (Liu et al. 2022)
Asks the model to **generate relevant knowledge** about the topic BEFORE answering, and uses that knowledge as context.
- **Use:** common-sense / factual tasks when there's no external base (RAG) available. A cheap alternative to RAG.

### Reflexion / Self-Refine
Self-critique loop: the model generates → critiques its own answer pointing out flaws → refines. Stronger than a single self-check.
- **Difference from self-check:** it's iterative (critiques and rewrites), not just a final verification.
- **Use:** coding, sequential reasoning, tasks where the first attempt tends to have correctable errors. In single-shot: "Generate an answer. Then critique it against {{criteria}} pointing out concrete flaws. Finally, produce the revised version."

### Analogical prompting
The model **generates its own analogous examples** to the problem before solving it (auto-few-shot), inspired by human analogical reasoning. Dispenses with labeled examples.
- **Use:** reasoning/math when you don't have ready-made examples.

### Contrastive CoT
Provides demonstrations of **correct AND incorrect** reasoning (positive + negative), so the model learns what to avoid. Reduces reasoning errors.

### Thread-of-Thought (ThoT)
A CoT variant for **long, chaotic contexts**: "Analyze this context in manageable parts, summarizing and advancing step by step." Keeps the thread in large inputs.

### Plan-and-Solve (PaS)
Improved zero-shot: "First understand the problem and **lay out a plan**; then execute the plan step by step." Reduces errors from skipped steps vs plain "think step by step".

### Maieutic prompting
Generates a **tree of recursive explanations** (abduction) and resolves inconsistencies as a logical satisfiability problem. Up to ~20% more accuracy on reasoning that demands logical consistency. Expensive; reserve for high criticality.

## Decomposition (with code/program)

### PAL — Program-Aided Language models
The model generates the **reasoning as code** (e.g. Python) and delegates the computation to an interpreter. Eliminates the model's arithmetic/logic errors.
- **Use:** math, logic, precise data manipulation. Requires an execution runtime.

### Program of Thoughts (PoT)
Similar to PAL: expresses the reasoning steps as an executable program, separating reasoning from computation.

### Decomposed Prompting (DECOMP)
Decomposes the task and **delegates each subtask to a specialized "handler"** (which can be another call/tool). More modular than Least-to-Most.

### Recursion-of-Thought / Skeleton-of-Thought
Recursion: splits into sub-calls when the problem exceeds the context. Skeleton: skeleton → expansion (see above).

## Orchestration

### Prompt chaining
Break the task into sequential API calls, inspecting intermediate outputs. Most common pattern: **self-correction** (draft → review against criteria → refine).
- **Use:** when you need to log/evaluate/branch between steps, or enforce a pipeline. In Claude 4.x much of the multi-step is internal, so chain only when you need inspection.

### ReAct (Reason + Act)
Interleaves reasoning and tool calls. Model thinks → acts (tool) → observes → repeats.
- **Use:** agentic, when the model needs external information (search, APIs, files).

### Meta-prompting
Use the model to generate/improve prompts (this is what this skill does). Higher-order: the model applies PE techniques automatically.
- **Base of Anthropic's prompt improver:** example identification → initial draft (XML) → CoT refinement → example enhancement.

## Ensembling (multiple samples → aggregation)

Run the model several times and combine the results. Increases robustness at the cost of N× tokens — reserve for high criticality.

### Self-Consistency
Samples N CoT paths (with temperature) and picks the majority answer. (Detailed above under Reasoning.)

### Universal Self-Consistency (USC)
When the answer is not a discrete label (free text), uses the model itself to pick the most consistent answer among the samples, instead of an exact vote.

### DiVeRSe
Generates multiple diverse prompts + multiple paths per prompt, then scores and aggregates. Greater coverage than plain self-consistency.

### Prompt paraphrasing / ensemble
Rephrases the same prompt in several ways, runs them all, and aggregates — reduces sensitivity to the specific wording.

### Max Mutual Information / Meta-CoT
Selects the template/reasoning that maximizes mutual information with the output, or combines multiple chains into a meta-reasoning.

## Self-criticism (self-verification)

The model evaluates/corrects its own output. Cheaper than ensembling.

### Chain-of-Verification (CoVe)
Generates the answer → formulates independent **verification questions** → answers each WITHOUT looking at the original answer → revises based on them. Reduces factual hallucination.

### Self-Verification
Generates several candidate solutions and verifies each by rewriting the problem (e.g. checks whether the solution reproduces the input data).

### Self-Calibration
The model estimates the **confidence** in its own answer — useful for routing (low confidence → escalate/review).

### Reversing CoT (RCoT) / Cumulative Reasoning
RCoT: reconstructs the problem from the answer to detect inconsistency. Cumulative: accumulates validated steps incrementally.

## Output control

### Output contract
Specify the exact format: JSON schema, XML tags, "result only, no preamble", length. Say what to do, not what to avoid.
- **Eliminate preamble:** "Answer directly, without phrases like 'Here is...'."
- **Structured outputs** (Claude/OpenAI) constrain to a schema — prefer them over prefill.

### Grounding by quotes
In tasks over long documents: ask it to extract relevant quotes into `<quotes>` BEFORE doing the task. Cuts the noise of the rest of the document.

### Prefill — DEPRECATED in Claude 4.6+
Prefill of the last assistant message is no longer supported in Claude 4.6+. Migrate to output contract / structured outputs / direct instruction. (Still exists in older models and in other positions of the conversation.)

### RAG (Retrieval-Augmented Generation)
Connects the model to retrieved external data (docs, knowledge base) to ground the answer in verifiable context, instead of only the pretraining.
- **In the prompt:** structure the retrieved context in XML, instruct it to answer ONLY based on it and to cite the source, and to say "not found" when the context doesn't cover it — reduces hallucination.
- **Difference from Generated Knowledge:** RAG searches an external base; Generated Knowledge makes the model generate the knowledge.

## Long context (20k+ tokens)

- **Long data at the top**, above query/instructions/examples. Query at the end → up to +30% quality.
- **"Lost in the middle" (Stanford):** performance drops when the relevant info is in the MIDDLE of long context — models perform better with key info at the start or the end. Position what matters at the edges.
- **Each document in `<document>`** with `<source>` and `<document_content>`.
- **Grounding by quotes** before the task.

## Context engineering (agents / multi-turn)

A broader discipline than prompt engineering: while PE optimizes **one** interaction, context engineering manages **the whole flow of tokens** to the agent (system prompt, tools, history, external data) over time. Primary source: Anthropic — *Effective context engineering for AI agents*. Apply it when the "prompt" is actually an agentic system, not a one-shot.

- **Context is a finite resource.** There's "context rot": recall degrades as the context grows. Guiding principle: *the smallest possible set of high-signal tokens that maximizes the desired outcome.* Minimal ≠ short — it still needs enough information.
- **System prompt at the right "altitude".** Neither hardcoded, brittle logic nor too vague. Specific enough to guide, flexible enough for heuristics. Organize into sections (`<background_information>`, `<instructions>`, tool guide, output format). Start minimal, add only where testing reveals failure.
- **Tool design matters as much as the prompt.** Minimize overlap between tools; each one self-contained, error-robust, with descriptive parameters. If a human doesn't know which tool to use, neither does the agent. Minimum viable set; tools that return token-efficient info.
- **Just-in-time retrieval.** Instead of pre-loading everything, keep lightweight identifiers (paths, queries, links) and load on demand via tools. Hybrid (recommended): pre-load the essentials for speed + allow autonomous exploration (this is the Claude Code model: `CLAUDE.md` upfront + glob/grep on-demand).
- **Long tasks — three tools:**
  - **Compaction:** summarize the history as you approach the limit; preserve architectural decisions, open bugs, implementation details; discard redundant tool outputs. Maximize recall first, refine precision later.
  - **Note-taking (agentic memory):** the agent writes notes persisted outside the context and re-reads them later — survives context resets.
  - **Sub-agents:** delegate focused tasks to sub-agents with a clean context; they return condensed summaries (1–2k tokens), not the whole exploration.
- **Three context failure modes:** too little info → hallucination; too much info → overflow that drowns attention; conflicting/distracting info → confusion. Curate the context at every step.

## Anti-patterns to fix in a draft

- Negative instruction where a positive one fits.
- Missing success criterion.
- Undefined output format.
- Scope ambiguity (Claude 4.x takes it literally).
- CoT forced on a reasoning model.
- Aggressive language ("CRITICAL: you MUST...") that causes overtriggering in Claude 4.5/4.6 — prefer "Use X when...".
- Examples inconsistent with each other or with the instruction.
- Micromanaging steps in reasoning models instead of giving objective + output contract.
