---
name: code-review
description: Comprehensive security and quality review of uncommitted changes. Use when reviewing code before committing.
---

# Code Review

Comprehensive code review of uncommitted changes.

## Procedure

### 1. Gather changes

```bash
git diff --name-only HEAD
git diff HEAD
```

If there are no changes, check staged files with `git diff --cached --name-only`.
If still nothing, report "No changes to review." and stop.

### 2. Review each changed file

Analyze every changed file against the checklist below. Read surrounding context when needed to understand intent.

### 3. Output report

For each finding, output:

```text
[SEVERITY] file/path:line — description
  → suggested fix
```

Severity levels: CRITICAL, HIGH, MEDIUM, LOW

### 4. Summary

End with a summary table:

| Severity | Count |
|----------|-------|
| CRITICAL | n     |
| HIGH     | n     |
| MEDIUM   | n     |
| LOW      | n     |

If CRITICAL or HIGH issues exist, clearly state the changes should NOT be committed until resolved.
If no issues found, approve with a short confirmation.

---

## Checklist

### Security (CRITICAL)

- Hardcoded credentials, API keys, tokens, passwords
- SQL injection (string concatenation in queries)
- XSS vulnerabilities (unsanitized user input in HTML)
- Command injection (unsanitized input in shell commands)
- Path traversal (user input in file paths without validation)
- Insecure deserialization
- Sensitive data in logs or error messages
- Missing authentication/authorization checks
- Secrets or `.env` files being committed

### Correctness (HIGH)

- Logic errors, off-by-one, null/undefined mishandling
- Missing error handling for I/O, network, or external calls
- Race conditions or concurrency issues
- Resource leaks (unclosed connections, file handles, listeners)
- Incorrect type usage or unsafe type assertions
- Broken error propagation (swallowed errors, empty catch blocks)

### Maintainability (MEDIUM)

- Functions exceeding ~50 lines or doing multiple unrelated things
- Nesting depth > 4 levels
- Duplicated logic that should be extracted
- Dead code, unused imports, unreachable branches
- Unclear naming (single-letter variables outside loops, misleading names)
- Missing validation at system boundaries (API inputs, env vars)
- TODO/FIXME/HACK comments without linked issue

### Style (LOW)

- Inconsistent formatting (should be caught by Prettier, but flag if not)
- Inconsistent naming conventions within the file
- Debug statements (console.log, print, debugger) left in production code
- Commented-out code blocks
