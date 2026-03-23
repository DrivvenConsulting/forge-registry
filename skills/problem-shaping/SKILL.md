---
name: problem-shaping
description: Turn a raw idea into a clear problem statement and context alignment (feature-definition.json). Use when only a problem statement is needed before full discovery or backlog refinement.
---

# Problem Shaping

Transform a raw or vague feature idea into a clear, user-focused problem statement (2–4 sentences) with explicit alignment to the product vision. Do **not** define solutions, hypotheses, or implementation—only the problem and its fit with the vision.

## When to Use

- The workflow or parent agent needs only a problem statement and context alignment (e.g. quick validation, or before a human-led discovery).
- You are in **product-owner** problem-shaping mode.

Equip this skill when your role includes shaping raw ideas. Use **confluence-fetch** for product vision, core concepts, and product principles when the parent has not already supplied them.

## Steps

1. **Ingest the raw idea** – Take the raw idea (and optional feature name, context).
2. **Fetch product context (if needed)** – Use **confluence-fetch** to retrieve core product vision, key concepts, and product principles when not already supplied.
3. **Analyze the idea** – Interpret the idea in the context of the product's purpose. Separate the stated "feature" from the underlying user need or opportunity.
4. **Identify the user problem or opportunity** – State who is affected, what goes wrong or what opportunity is missed, and why it matters.
5. **Produce the output** – Populate the JSON with `problem_statement`, `context_alignment`, and `assumptions`. When a **feature name** is provided, write to **`artifacts/feature-definitions/<feature_name>/feature-definition.json`**; otherwise return the JSON in your response.

## Output schema

```json
{
  "problem_statement": "<2-4 sentences, user- and outcome-focused>",
  "context_alignment": "<1-3 sentences linking to product vision>",
  "assumptions": ["<optional list if critical assumptions were made>"]
}
```

- **problem_statement**: Clear description of the user problem and why it matters.
- **context_alignment**: How this problem fits the product vision.
- **assumptions**: Array of strings; use empty array `[]` if no critical assumptions.

## Do

- Keep problem statement to 2–4 sentences; user- and outcome-focused; no solution or implementation detail.
- Ask only the clarifying questions needed when critical context is missing; do not invent details.

## Do Not

- Define solutions, hypotheses, or implementation.
- Invent requirements; if context is ambiguous, ask for clarification.
