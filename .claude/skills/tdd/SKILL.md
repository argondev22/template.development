---
name: tdd
description: Test-driven development workflow. Write failing tests first, then implement minimal code to pass. Use when building new features or fixing bugs.
disable-model-invocation: true
argument-hint: "[description of what to implement]"
---

# TDD

Enforce test-driven development: RED -> GREEN -> REFACTOR.

## Procedure

### 1. Understand the requirement

Analyze `$ARGUMENTS` and identify:

- What behavior to implement
- What inputs and outputs are expected
- What edge cases exist

### 2. Scaffold interfaces (SCAFFOLD)

Define types/interfaces for inputs and outputs. Write stub implementations that throw or return placeholder values.

### 3. Write failing tests (RED)

Write tests BEFORE any implementation:

- Happy path scenarios
- Edge cases (empty, null, boundary values)
- Error conditions

Run the tests and **verify they fail** for the expected reason (not because of syntax errors or missing imports).

### 4. Implement minimal code (GREEN)

Write the minimum code needed to make all tests pass. No more.

Run the tests and **verify they all pass**.

### 5. Refactor (REFACTOR)

Improve the implementation:

- Extract constants, clarify naming
- Remove duplication
- Simplify logic

Run the tests and **verify they still pass** after each change.

### 6. Check coverage

If a coverage tool is available, run it and report the result. Add more tests if below 80%.

### 7. Report

```text
TDD Session Complete
────────────────────
Tests:    n passed, 0 failed
Coverage: x%
Cycle:    RED -> GREEN -> REFACTOR

Files created/modified:
- path/to/implementation
- path/to/tests
```

## Rules

- NEVER write implementation before tests
- NEVER skip running tests between phases
- NEVER write more code than needed to pass
- Test behavior, not implementation details
- Prefer integration tests over heavy mocking
