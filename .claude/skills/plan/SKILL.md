---
name: plan
description: Create a step-by-step implementation plan before writing code. Use when starting new features, refactoring, or architectural changes.
disable-model-invocation: true
argument-hint: "[description of what to implement]"
---

# Plan

Create an implementation plan and WAIT for user confirmation before writing any code.

## Procedure

### 1. Analyze the request

- Restate requirements in clear, concrete terms
- Identify ambiguities and ask clarifying questions if needed

### 2. Explore the codebase

- Find relevant existing code, patterns, and conventions
- Identify files that will need changes
- Check for existing tests, types, and interfaces

### 3. Create the plan

Present in this format:

```markdown
## Requirements

- [bullet list of what will be built]

## Affected Files

- `path/to/file` — what changes and why

## Implementation Phases

### Phase 1: [name]

- Step 1
- Step 2

### Phase 2: [name]

- Step 1
- Step 2

## Risks

- [HIGH/MEDIUM/LOW]: description and mitigation

## Open Questions

- [anything that needs clarification]
```

### 4. WAIT for confirmation

Do NOT write any code until the user explicitly approves.

Accept responses like:

- "ok" / "proceed" / "yes" — start implementation
- "modify: ..." — adjust the plan
- "skip phase X" — reorder or remove phases

### 5. Execute

After confirmation, implement phase by phase. Report progress at each phase boundary.
