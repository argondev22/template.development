---
name: commit
description: Create a well-structured conventional commit. Use when committing changes to git.
disable-model-invocation: true
---

# Commit

Create a well-structured commit from the current changes.

## Procedure

### 1. Check current state

Run in parallel:

```bash
git status
git diff --staged
git diff
git log --oneline -5
```

If there are no changes (no untracked, no modified, no staged), report "Nothing to commit." and stop.

### 2. Review changes

Analyze all changes (staged + unstaged + untracked) to understand:

- What was changed and why
- Which files are related and belong in the same commit
- Whether any files should NOT be committed (secrets, `.env`, large binaries, temporary files)

If changes span multiple unrelated concerns, suggest splitting into separate commits and ask the user which to commit first.

### 3. Stage files

Stage the relevant files by name. Prefer `git add <file>...` over `git add -A` or `git add .`.

Never stage:

- `.env`, `.env.local`, or files containing secrets
- Large binary files not tracked by Git LFS
- OS/IDE artifacts (`.DS_Store`, `.idea/`, etc.)

Warn the user if any of these are detected.

### 4. Determine commit type

Choose the appropriate type based on the changes:

| Type | When to use |
|------|-------------|
| `feat` | New feature or capability |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `style` | Formatting, whitespace (no logic change) |
| `refactor` | Code restructuring (no feature/fix) |
| `perf` | Performance improvement |
| `test` | Adding or updating tests |
| `build` | Build system or external dependencies |
| `ci` | CI/CD configuration |
| `chore` | Maintenance tasks |
| `revert` | Reverting a previous commit |
| `deps` | Dependency updates |
| `docker` | Docker configuration changes |

### 5. Write commit message

Format: `<type>: <subject>`

Rules (from commitlint config):

- Type: required, lowercase
- Subject: required, no trailing period, header max 100 chars
- Body: optional, blank line before, max 100 chars per line
- Focus on **why**, not what (the diff shows the what)

Match the language style of recent commits (`git log --oneline -5`).

### 6. Commit

Create the commit using a heredoc:

```bash
git commit -m "$(cat <<'EOF'
<type>: <subject>

<optional body>

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

### 7. Verify

Run `git status` to confirm the commit succeeded and the working tree is clean (or only expected files remain).
