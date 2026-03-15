---
name: update-docs
description: Sync documentation with the codebase by generating from source-of-truth files. Use after code changes that affect setup, APIs, or configuration.
disable-model-invocation: true
---

# Update Docs

Sync documentation with the current codebase state.

## Procedure

### 1. Identify sources of truth

Scan for these files and extract information:

| Source | Generates |
|--------|-----------|
| `package.json` / `Makefile` | Available commands reference |
| `.env.example` / `.env.template` | Environment variable docs |
| `openapi.yaml` / route files | API endpoint reference |
| `Dockerfile` / `docker-compose.yml` | Infrastructure setup docs |
| `CLAUDE.md` | Project overview (keep in sync) |

### 2. Update command reference

Read `package.json` scripts and `Makefile` targets. Update the relevant documentation with a commands table:

```markdown
| Command | Description |
|---------|-------------|
| `make init` | Initialize project |
| `npm run format` | Run formatter |
```

### 3. Update environment docs

If `.env.example` exists, extract variables and document:

```markdown
| Variable | Required | Description | Example |
|----------|----------|-------------|---------|
```

### 4. Staleness check

Find docs not modified in 90+ days. Cross-reference with recent source changes. Flag potentially outdated docs.

### 5. Summary

```text
Documentation Update
──────────────────────
Updated:  docs/SETUP.md (commands table)
Updated:  CLAUDE.md (new scripts)
Flagged:  docs/API.yml (95 days stale)
Skipped:  docs/ARCHITECTURE.md (no changes)
──────────────────────
```

## Rules

- Generate from code, never manually edit generated sections
- Preserve hand-written prose — only update generated sections
- Mark generated content with `<!-- AUTO-GENERATED -->` markers
- Don't create new doc files unless explicitly asked
