# Exhaustive technique index

Master map of ALL known prompting techniques, organized by the **The Prompt Report** taxonomy (6 text-based categories, 58 techniques) + extras from vendors and post-2024 literature. Each item: name + 1 line. The ones marked ★ have application detail in `techniques.md`. Use this index to make sure no approach was forgotten when optimizing a prompt.

## 1. In-Context Learning (ICL) — examples in the prompt
- ★ **Few-Shot / Multishot** — 2–5 input→output examples.
- ★ **Zero-Shot** — instruction with no examples.
- **Exemplar selection (KNN / Vote-K)** — pick examples similar to the input.
- **Exemplar ordering** — example order matters; the last ones carry more weight.
- **Self-Generated ICL (SG-ICL)** — model generates its own examples when there's no dataset.
- **Prompt Mining** — discover the template that best matches the training distribution.
- **KATE / similar-example retrieval** — retrieve examples by embedding.

## 2. Zero-Shot — instruction modifiers
- ★ **Role / Expert / Persona** — assigns a role.
- ★ **Style prompting** — defines style/tone/format in the instruction.
- ★ **Emotion prompting (EmotionPrompt)** — emotional appeal (ineffective in modern models).
- ★ **Rephrase and Respond (RaR)** — rephrases the question before answering.
- ★ **Re-reading (RE2)** — re-reads the input.
- ★ **Self-Ask** — generates follow-up sub-questions.
- ★ **System 2 Attention (S2A)** — cleans the context of noise before answering.
- ★ **SimToM** — establishes what each actor knows (theory of mind).
- **"Take a deep breath"** — trigger phrase (worked in old Google models; null in Claude).

## 3. Thought Generation — explicit reasoning
- ★ **Chain-of-Thought (CoT)** — step-by-step reasoning.
- **Zero-Shot CoT** — "think step by step" with no examples.
- **Few-Shot CoT** — examples with reasoning.
- ★ **Step-Back prompting** — steps back to a general principle first.
- ★ **Analogical prompting** — generates its own analogous examples.
- ★ **Thread-of-Thought (ThoT)** — CoT for long/chaotic context.
- ★ **Contrastive CoT** — correct AND incorrect demonstrations.
- ★ **Plan-and-Solve (PaS)** — plans before executing.
- **Tabular CoT** — reasoning in table format.
- **Active-Prompt** — selects which examples to annotate with CoT by uncertainty.
- **Automatic CoT (Auto-CoT)** — generates the example chains automatically.
- **Complexity-based prompting** — prefers longer/more complex reasoning chains.
- **Memory-of-Thought** — retrieves relevant past reasoning.
- **Uncertainty-routed CoT** — trusts the chain only if there's consensus.

## 4. Decomposition — break the problem down
- ★ **Least-to-Most** — subproblems from easy to hard, in a chain.
- ★ **Tree-of-Thoughts (ToT)** — parallel branches with evaluation and backtracking.
- ★ **Decomposed Prompting (DECOMP)** — delegates subtasks to handlers.
- ★ **Plan-and-Solve** — (see thought generation).
- ★ **Program-Aided LM (PAL)** — reasoning as executed code.
- ★ **Program of Thoughts (PoT)** — steps as a program.
- ★ **Skeleton-of-Thought** — skeleton → expansion.
- **Recursion-of-Thought** — recursive sub-calls for large problems.
- **Faithful CoT** — ensures the chain actually leads to the answer.
- **Maieutic prompting** — tree of explanations + logical satisfiability. (detail in techniques.md)

## 5. Ensembling — multiple aggregated samples
- ★ **Self-Consistency** — majority vote over N CoT chains.
- ★ **Universal Self-Consistency (USC)** — consistency for free-text outputs.
- ★ **DiVeRSe** — diverse prompts + multiple paths + scoring.
- ★ **Prompt Paraphrasing / Ensemble** — aggregates prompt rephrasings.
- ★ **Max Mutual Information / Meta-CoT** — selection/combination by information.
- **COSP / USP** — selection of consistent examples without labels.
- **DENSE** — ensemble of demonstrations.
- **Boosted Prompt Ensembles** — "hard" examples chosen by the previous ensemble's uncertainty.

## 6. Self-Criticism — self-verification and refinement
- ★ **Self-Refine / Reflexion** — generates, critiques, refines in a loop.
- ★ **Chain-of-Verification (CoVe)** — independent verification questions.
- ★ **Self-Verification** — verifies candidate solutions by reconstructing the problem.
- ★ **Self-Calibration** — estimates confidence in the answer.
- ★ **Reversing CoT (RCoT)** — reconstructs the problem from the answer.
- ★ **Cumulative Reasoning** — accumulates validated steps.
- **Self-Consistency as verification** — using consensus to filter.

## 7. Grounding / external context
- ★ **RAG (Retrieval-Augmented Generation)** — retrieves external data and grounds.
- ★ **Generated Knowledge** — model generates knowledge before answering.
- ★ **Grounding by quotes** — extracts relevant excerpts before the task.
- **Iterative RAG / FLARE** — retrieves on demand during generation.
- **Chain-of-Note** — annotates the relevance of each retrieved document.

## 8. Orchestration / agentic
- ★ **Prompt chaining** — sequential calls with inspection.
- ★ **ReAct** — reasoning + action (tools).
- **ReWOO** — separates reasoning from tool use to save tokens.
- **Reflexion (agentic)** — self-reflection memory across attempts.
- ★ **Context engineering** — managing the context flow (see techniques.md).
- ★ **Sub-agents** — delegation to clean contexts.

## 9. Meta / automatic (prompt optimization)
- ★ **Meta-prompting** — model generates/improves prompts.
- **APE, OPRO, DSPy, MIPRO, TextGrad, ProTeGi, Promptbreeder** — automatic optimization. (detail in `auto-optimization.md`)

## 10. Security
- **Defense against prompt injection / jailbreak** — see `prompt-security.md`.

---

**Usage rule:** this index is the universe of options. The skill does NOT apply everything — it chooses the highest-return ones for each task (see the decision table in SKILL.md). Heavy ensembling/decomposition techniques (ToT, self-consistency, maieutic) only come in when criticality justifies the token cost.
