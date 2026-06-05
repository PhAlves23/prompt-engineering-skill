# Self-review checklist (Phase 4)

Run it against the rewritten prompt before delivering. Each item is NOT mandatory for every prompt — mark "N/A" when it doesn't apply to the task. But mentally justify each N/A.

## Clarity and scope
- [ ] Could a colleague with no context execute the prompt without doubt? (golden test)
- [ ] Are the objective and the success criterion explicit?
- [ ] Is the scope stated without ambiguity? (Claude 4.x is literal)
- [ ] Instructions in the right order, numbered when order matters?

## Language
- [ ] Positive instructions ("do X") instead of negative ("don't do Y") where possible?
- [ ] Do non-obvious instructions have motivation/why?
- [ ] No unnecessary aggressive language ("CRITICAL/you MUST") that causes overtrigger?

## Structure
- [ ] Components separated in XML (instruction, context, data, examples)?
- [ ] Consistent, descriptive tags?
- [ ] In long-context: long data at the top, query at the end?
- [ ] Dynamic variables in `{{double_brackets}}`, preserved from the original?

## Techniques appropriate to the task
- [ ] Few-shot included when format/tone/classification matters? (3–5, diverse, in tags)
- [ ] CoT asked for when the task is analytical — AND removed if the target is a reasoning model?
- [ ] Self-check asked for when the answer is verifiable?
- [ ] No superfluous technique inflating latency/cost with no gain?

## Output
- [ ] Explicit output contract (format, schema, length, no-preamble)?
- [ ] Says what to do in the output, not just what to avoid?
- [ ] Prompt style matches the desired output style?

## Target model
- [ ] Adjusted to the right model's profile? (Claude literal / reasoning high-level / Gemini PTCF)
- [ ] No prefill if the target is Claude 4.6+?

## Coding/agentic (when applicable)
- [ ] Anti-overengineering, anti-hardcode, and anti-hallucination present?
- [ ] Autonomy/safety balance for irreversible actions?

If any critical item fails → fix it before delivering. The changelog should reflect the decisions.
