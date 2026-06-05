# Worked examples

Complete cases: draft → optimized prompt → changelog. Use them as a reference for the **quality bar and the output format**. The skill preaches few-shot; these are its own few-shots. Mirror this level of rigor and this delivery format.

---

## Example 1 — Classification (weak draft)

**User draft:**
```
classify the sentiment of this comment: {{comment}}
```

**Expected skill output:**

## Optimized prompt
```
You are a sentiment analyst specialized in customer feedback.

Classify the sentiment of the comment below into one of these categories: positive, negative, neutral.

<comment>
{{comment}}
</comment>

Follow these steps:
1. Identify the expressions that carry emotion (positive or negative).
2. Weigh the overall tone, accounting for irony and negation.
3. Choose the category that best represents the predominant sentiment.

Put your reasoning in <analysis>. On the last line, answer ONLY one word: positive, negative, or neutral.
```

## What changed
- Role — defines the domain (customer feedback), calibrates the interpretation.
- Output enum + strict contract ("ONLY one word") — eliminates loose text, eases parsing.
- Short CoT (3 steps) — captures irony/negation, the main error sources in sentiment.
- XML on the input — separates data from instruction, robust to comments with line breaks.

## Assumptions / open questions
- Assumed 3 categories. If you need a scale (1–5) or "mixed", let me know and I'll adjust the enum.

---

## Example 2 — Coding (medium draft, Claude target)

**User draft:**
```
improve the performance of this search function, it's slow
{{code}}
```

**Expected skill output:**

## Optimized prompt
```
Optimize the performance of the search function below, which is slow in production.

<code>
{{code}}
</code>

Requirements:
- Focus on the real cause of the slowness (algorithmic complexity, I/O, allocation). Measure before assuming.
- Keep the behavior and the public signature identical — the optimization must not change results.
- Scope: change only what's needed for performance. Don't refactor adjacent code, don't add abstractions or features.
- General solution for all valid inputs, no hardcode for specific cases.
- Never speculate about code that isn't visible; if it depends on something external, state the assumption.

Before finalizing, explain in <analysis> what the bottleneck was and why the change fixes it. Then deliver the optimized code.
```

## What changed
- Outcome-oriented objective ("optimize the performance", real cause) instead of a vague request.
- Explicit invariant (identical behavior/signature) — prevents the "optimization" from breaking the function.
- Anti-overengineering + anti-hardcode (Claude coding profile) — blocks unrequested refactoring.
- Anti-hallucination — don't speculate about out-of-sight code.
- Bottleneck self-explanation — forces real diagnosis, not a guess.

## Assumptions / open questions
- None. If there's a memory vs CPU constraint, tell me which to prioritize.

---

## Example 3 — Already-good prompt (don't invent changes)

**User draft:**
```
You are a technical reviewer. Review the text in <text> for clarity and factual correctness.
List each problem found in <problems> with: quoted excerpt, type (clarity|fact), and suggested fix.
Don't rewrite the whole text; only point out the problems.
<text>{{text}}</text>
```

**Expected skill output:**

This prompt is already solid — role, XML input, structured output, and defined scope. Marginal tweaks only:

## Optimized prompt
```
You are a meticulous technical reviewer. Review the text in <text> for clarity and factual correctness.

For each problem found, record an item in <problems> with:
- excerpt: the exact quote from the text
- type: clarity or fact
- fix: the concrete suggestion

Only point out the problems; don't rewrite the whole text. If there are no problems in a category, say so explicitly.

<text>{{text}}</text>
```

## What changed
- Just two tweaks: each item's structure made explicit (reduces format variation) and an instruction for the "no problems" case (avoids an ambiguous empty output).
- Kept everything that was already good. There's no gain in rewriting more than this.

---

## Example 4 — Structured extraction (JSON, anti-hallucination)

**User draft:**
```
extract the data from this invoice {{invoice}}
```

**Expected skill output:**

## Optimized prompt
```
You are a precise extractor of invoice data.

Extract the fields below from the document in <invoice>. If a field is not present, use null — never infer or invent a value.

<invoice>
{{invoice}}
</invoice>

Before extracting, copy into <evidence> the exact excerpts that support each field (field name → quoted text). Then return ONLY a JSON object with this schema, with no comments or preamble:

{
  "invoice_number": "string | null",
  "issue_date": "YYYY-MM-DD | null",
  "supplier_name": "string | null",
  "total_amount": number | null,
  "currency": "string | null",
  "line_items": [{ "description": "string", "quantity": number, "unit_price": number }]
}
```

## What changed
- Role + domain — calibrates which fields count as an invoice.
- Explicit JSON schema with types and nullability — turns a vague ask into a machine-parseable contract.
- Grounding by quotes (`<evidence>` before the JSON) — forces each field to come from the document, cutting hallucinated values.
- Anti-hallucination rule (`null`, never invent) — the most common failure in extraction.
- "ONLY a JSON object, no preamble" — eliminates the wrapping prose that breaks parsers.

## Assumptions / open questions
- Assumed ISO date format and amount as a number. If you need the original string (e.g. "1.234,56") or a fixed currency, tell me.

---

## Example 5 — Research (competing hypotheses, verification)

**User draft:**
```
research whether we should migrate from Postgres to a vector DB for our RAG
```

**Expected skill output:**

## Optimized prompt
```
You are a senior data infrastructure architect.

Research question: should we migrate our RAG retrieval from Postgres (pgvector) to a dedicated vector database?

Success criterion: a recommendation grounded in evidence, with the conditions under which each option wins — not a generic "it depends".

Conduct it in a structured way:
1. State the competing hypotheses (stay on pgvector / migrate to a dedicated vector DB / hybrid), and track a confidence level for each as you go.
2. Evaluate against concrete dimensions: query latency at our scale, recall quality, operational cost, team familiarity, migration effort.
3. For each factual claim (benchmarks, limits, pricing), verify it across at least two sources; flag anything you can only support with one.
4. Surface the strongest argument AGAINST your leading recommendation before concluding.

Deliver:
- A comparison table (dimension × option).
- A final recommendation with the decisive conditions.
- An "open questions" list of what we'd need to measure on our own data to confirm.
```

## What changed
- Role + explicit success criterion — turns an open browse into a decision with a bar for "done".
- Competing hypotheses with confidence tracking — avoids anchoring on the first option.
- Concrete evaluation dimensions — prevents a vague essay; forces comparable analysis.
- Multi-source verification + single-source flag — reduces confident-but-wrong claims.
- Steelman against own recommendation — counters confirmation bias.
- Output contract (table + recommendation + open questions) — makes it actionable.

## Assumptions / open questions
- Assumed the decision drivers are latency/cost/effort. If compliance or vendor lock-in is the real constraint, tell me and I'll re-weight the dimensions.

---

## Example 6 — Agentic / tool-use (action vs suggestion, safety)

**User draft:**
```
you have access to the github and shell tools. fix the failing test in the repo
```

**Expected skill output:**

## Optimized prompt
```
Your task: make the failing test in this repository pass, fixing the root cause (not the test).

Available tools:
- shell — run commands (test runner, git, file inspection). Use to reproduce the failure and verify the fix.
- github — read/comment on issues and PRs. Use to open the PR at the end.

Guidelines:
- First reproduce the failure and read the relevant code before changing anything. Never speculate about code you haven't opened.
- By default, IMPLEMENT the fix directly; don't just describe what should be done.
- Fix the underlying cause. Don't weaken or delete the assertion to make it pass.
- Run independent inspection commands in parallel; sequence only when one depends on another's output.
- For irreversible actions (force-push, deleting branches, history rewrite), stop and ask for confirmation first.
- Done = the full test suite passes locally and you've opened a PR describing the root cause and the fix.
```

## What changed
- Reframed "fix the failing test" → "fix the root cause, not the test" — closes the cheat path of deleting the assertion.
- Per-tool guidance (when to use each) — reduces wrong-tool calls; an agent that can't tell which tool to use behaves like a human who can't.
- Read-before-edit + anti-hallucination — prevents blind edits.
- Explicit act-vs-suggest — Claude 4.x needs the action mandate, otherwise it may only propose.
- Parallel-tool-calls guidance — speeds up independent inspection.
- Safety gate on irreversible actions — autonomy/safety balance.
- Explicit done criterion — stops the agent from declaring victory early.

## Assumptions / open questions
- Assumed you want a PR at the end. If you'd rather commit straight to a branch without a PR, say so.

---

## Example 7 — Long-context summarization (data-at-top, grounding)

**User draft:**
```
summarize this contract and tell me the risky clauses {{contract}}
```

**Expected skill output:**

## Optimized prompt
```
<documents>
  <document index="1">
    <source>{{contract_name}}</source>
    <document_content>
{{contract}}
    </document_content>
  </document>
</documents>

You are a contracts lawyer reviewing the document above for a non-legal business owner.

First, extract into <quotes> the exact clauses that carry risk (auto-renewal, liability, termination, penalties, exclusivity, IP assignment). Quote them verbatim with their section number.

Then produce:
1. A plain-language summary of the contract in under 200 words.
2. A risk list: for each risky clause, the quote, why it's risky, and a suggested negotiation point.

Base every statement on the quotes you extracted. If the contract is silent on a common protection, say so explicitly.
```

## What changed
- Long-context layout — the contract goes at the top, instructions and question at the bottom (up to +30% quality; counters "lost in the middle").
- Grounding by quotes before the task — anchors the analysis in the actual text, cuts invented clauses.
- Role + audience (lawyer → non-legal owner) — sets depth and plain language.
- Two-part output contract (summary + risk list with negotiation points) — makes it actionable, not just descriptive.
- "Say so if silent" — surfaces missing protections, a frequent real risk.

## Assumptions / open questions
- Assumed an English-language contract and a business (not consumer) context. If it's under a specific jurisdiction's law, tell me and I'll have it flag jurisdiction-specific clauses.

---

**Lessons from these examples:**
1. The changelog connects each change to a **concrete weakness** — never a generic "improved clarity".
2. When the draft is already good, **say so and do the minimum** — don't invent changes to justify work.
3. Stated assumptions replace questions: assume the sensible default and flag it, instead of blocking.
4. The structure scales with task type — extraction needs a schema, research needs competing hypotheses, agentic needs a done criterion and safety gates, long-context needs data-at-top + grounding.
