---
name: fix-ci
description: Check PR status checks (CI) and fix failing checks. Use when a PR has failing CI or you want to verify CI will pass before pushing.
argument-hint: "[PR number or branch name]"
---

# Fix CI

Check PR status checks and fix any failures.

## Procedure

### 1. Get CI status

If a PR number or branch is provided via `$ARGUMENTS`, use it. Otherwise detect from current branch.

```bash
# Get current branch if no argument
git branch --show-current

# Check PR status checks
gh pr checks $ARGUMENTS

# If no PR exists yet, get the workflow runs for the branch
gh run list --branch $(git branch --show-current) --limit 5
```

If all checks pass, report "All CI checks passing." and stop.

### 2. Identify failures

For each failing check, get the detailed log:

```bash
# Get failed job logs
gh run view <run-id> --log-failed
```

Parse the logs to identify:

- Which job failed (prettier, markdownlint, yamllint, actionlint, build, tests, etc.)
- The specific error messages and file locations
- Whether it's a formatting issue, lint error, or build failure

### 3. Fix by category

#### Prettier failures

```bash
npm run format
```

Then check which files were modified and review the changes.

#### markdownlint failures

```bash
npm run format:markdown
```

For rules that can't be auto-fixed, read the error, fix manually.

#### yamllint failures

Read the error output, fix YAML formatting issues (indentation, trailing spaces, line length, etc.) in the reported files.

#### actionlint failures

Read the error, fix GitHub Actions workflow syntax issues in `.github/workflows/`.

#### Build failures

Invoke the `/build-fix` skill workflow.

#### Test failures

Read test output, identify failing tests, fix the root cause (not the test assertion unless the test is wrong).

### 4. Verify locally

Run the same checks that CI runs:

```bash
npm run format:check
npm run lint:markdown
```

For yamllint (if installed locally):

```bash
yamllint .
```

### 5. Commit the fixes

If local verification passes and there are changes, automatically commit using the `/commit` skill workflow:

- Stage only the files that were modified by the fixes
- Use commit type `style` for formatting fixes, `fix` for lint/build/test fixes
- Subject should reference CI, e.g., `fix: resolve failing CI checks (prettier, markdownlint)`

### 6. Push and report

Push the commit to the remote branch, then report:

```text
CI Fix Results
──────────────
Checked:  <PR number or branch>
Failures: n found, n fixed

Fixed:
- prettier: n files reformatted
- markdownlint: n issues fixed

Remaining:
- (any issues that couldn't be auto-fixed)

Local verification: PASS
Committed: <sha>
Pushed: <branch>
```

If there are remaining issues that couldn't be auto-fixed, list them with suggestions.
