# Templates by task type

Ready-made skeletons. Adapt to the case, fill in `{{variables}}`, remove sections that don't add value. Claude 4.x style (default); for other models, cross-reference `model-profiles.md`.

## Classification

```
You are a classification system specialized in {{domain}}.

Your task: classify {{item}} into one of the categories below.

<categories>
{{list_of_categories}}
</categories>

<input>
{{text_to_classify}}
</input>

Follow these steps:
1. List the key concepts in the input.
2. Compare each concept against the categories.
3. Rank the 3 most likely categories with a justification.
4. Choose the final category.

Put your analysis in <analysis>. Then, on the final line, answer ONLY the name of the chosen category, with no additional text.
```
Techniques: role, XML, short CoT, strict enum output. Add 3–5 `<example>` if there's ambiguity.

## Structured extraction

```
You are a precise data extractor for {{domain}}.

Extract the fields below from the document. If a field doesn't exist, use null — never invent it.

<document>
{{document}}
</document>

Return ONLY a JSON object with this schema:
{
  "field_a": "string",
  "field_b": number | null,
  "field_c": ["string"]
}
```
Techniques: role, XML input, explicit output schema, anti-hallucination (null instead of inventing), grounding by quotes if the doc is long.

## Generation / writing

```
You are {{persona}} writing for {{audience}}.

Task: produce {{artifact}} about {{topic}}.

<context>
{{relevant_context}}
</context>

Requirements:
- Tone: {{tone}}
- Length: {{length}}
- Structure: {{structure}}
- {{other constraints}}

<example>
{{example of desired tone/style}}
</example>

Write in flowing, direct prose. {{output contract}}
```
Techniques: persona+audience, context, tone examples, positive constraints, match style.

## Coding

```
{{clear objective: what to implement and why}}

Context:
<codebase>
{{relevant files/snippets}}
</codebase>

Requirements:
- {{expected behavior}}
- Scope: change only what was requested or is clearly necessary. Don't add features, abstractions, docstrings, or error handling that weren't asked for.
- General solution for all valid inputs, not just the tests. No hardcode or workarounds.
- Never speculate about code you haven't opened — read the file first.

Before finalizing, verify the solution against {{criterion/tests}}.
```
Techniques: outcome-oriented objective, explicit scope, anti-overengineering, anti-hardcode, anti-hallucination, self-check. Claude: `xhigh`/`high` effort.

## Reasoning / analysis

**Claude / classic GPT:**
```
You are {{specialist}}.

Problem:
<problem>
{{description}}
</problem>

Reason through the problem in <thinking>: list premises, consider competing approaches, weigh trade-offs. Then, in <answer>, give the conclusion and the justification.

Before finalizing, verify your reasoning against {{criterion}}.
```

**Reasoning model (o-series / GPT-5 reasoning):** remove the `<thinking>` block and the micro-steps. Give only:
```
Objective: {{desired result}}
Constraints: {{hard limits}}
Available evidence: {{data}}
Output: {{exact output contract}}
```

## Research

```
Research question: {{question}}

Success criterion: {{what counts as a complete, reliable answer}}.

Conduct it in a structured way:
- Develop competing hypotheses and track your confidence level in each.
- Verify information across multiple sources; don't rely on a single source.
- Self-critique the approach regularly and update a hypothesis tree.
- Decompose the question into sub-questions.

Deliver: {{format — cited report, comparison table, etc.}}
```
Techniques: success criteria, competing hypotheses, multi-source verification, decomposition, self-critique.

## Agentic / tool-use

```
{{task objective}}

Available tools: {{list + when to use each}}.

Guidelines:
- By default, IMPLEMENT the change instead of just suggesting it.
- Call independent tools in parallel; sequential only when there's a parameter dependency.
- For destructive or irreversible actions (delete, force-push, actions on shared systems), confirm first.
- {{completion criterion}}
```
Techniques: explicit action instruction, parallel tool calls, autonomy/safety balance, done criterion.

## Summarization / transformation (long-context)

```
<documents>
  <document index="1">
    <source>{{source}}</source>
    <document_content>
{{long_document}}
    </document_content>
  </document>
</documents>

[long data ABOVE; instruction and question BELOW]

First, extract the relevant excerpts for {{objective}} into <quotes>. Then, based on the quotes, produce {{output}} in {{format/length}}.
```
Techniques: long-context layout (data at top, query at end), grounding by quotes, length output contract.
