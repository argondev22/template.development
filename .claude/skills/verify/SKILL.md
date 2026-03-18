---
name: verify
description: Run comprehensive quality checks (build, lint, tests, security). Use before committing or opening a PR.
argument-hint: "[quick|full|pre-commit|pre-pr]"
---

# Verify

Run comprehensive verification on the current codebase state.

## Arguments

- `quick` — build + lint only
- `full` — all checks (default)
- `pre-commit` — format check + lint + git status
- `pre-pr` — all checks + security scan

Mode: $ARGUMENTS (default: full)

## Procedure

### 1. Detect project tools

Scan for available tools by checking config files:

| File                                | Tool         |
| ----------------------------------- | ------------ |
| `package.json` (build script)       | Build        |
| `tsconfig.json`                     | Type check   |
| `.prettierrc*`                      | Prettier     |
| `.eslintrc*` / `eslint.config.*`    | ESLint       |
| `.markdownlint*`                    | markdownlint |
| `jest.config.*` / `vitest.config.*` | Tests        |
| `pyproject.toml`                    | Python tools |
| `Cargo.toml`                        | Rust tools   |
| `go.mod`                            | Go tools     |

Only run checks for tools that actually exist in the project.

### 2. Run checks in order

Stop early if a critical step fails:

1. **Build** — Run the project's build command
2. **Types** — Run type checker if available
3. **Format** — Check formatting (e.g., `npm run format:check`)
4. **Lint** — Run linters (ESLint, markdownlint, yamllint, etc.)
5. **Tests** — Run test suite, report pass/fail count and coverage
6. **Security** — Search for hardcoded secrets, `.env` files, `console.log` in source
7. **Git Status** — Show uncommitted changes and untracked files

### 3. Output report

```text
VERIFICATION: [PASS/FAIL]

Build:    [OK/FAIL/SKIP]
Types:    [OK/n errors/SKIP]
Format:   [OK/n issues/SKIP]
Lint:     [OK/n issues/SKIP]
Tests:    [n/m passed, x% coverage/SKIP]
Security: [OK/n findings/SKIP]
Git:      [clean/n uncommitted changes]

Ready for PR: [YES/NO]
```

If any issues found, list them with fix suggestions.
