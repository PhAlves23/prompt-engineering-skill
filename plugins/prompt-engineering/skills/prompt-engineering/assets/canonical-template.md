# Canonical skeleton of the optimized prompt

Copy and fill in. Remove sections that don't add value to the task. Order matters (especially long-context).

```
<role>
You are {{specific persona + domain}}.
</role>

<task>
{{what to produce}}. Success = {{success criterion}}.
</task>

<context>
{{background information}}. This matters because {{motivation}}.
</context>

<!-- LONG-CONTEXT: long data goes HERE, at the top, before the instructions -->
<inputs>
  <document index="1">
    <source>{{source}}</source>
    <document_content>
{{data}}
    </document_content>
  </document>
</inputs>

<instructions>
1. {{step 1}}
2. {{step 2}}
3. {{step 3}}
Apply to ALL {{items}}, not just the first.
</instructions>

<!-- Only in analytical tasks AND a non-reasoning model -->
<reasoning>
Before answering, reason in <thinking>: {{what to consider}}.
</reasoning>

<!-- Few-shot: 3–5, diverse -->
<examples>
  <example>
    <input>{{ex_input}}</input>
    <thinking>{{ex_reasoning}}</thinking>
    <output>{{ex_output}}</output>
  </example>
</examples>

<output_format>
{{exact format: JSON schema / tags / "result only, no preamble" / length}}
</output_format>

<!-- When verifiable -->
Before finalizing, verify your answer against {{criterion}}.
```

## Quick variants

**Minimal (simple task):** role (1 line) + task + output_format.

**Reasoning model (o-series / GPT-5 reasoning):** role + objective + constraints + evidence + output_format. NO `<reasoning>`/manual CoT, NO micro-steps.

**Gemini (PTCF):** Persona → Task → Context → Format, with headings or XML as delimiters.
```
