---
name: init-project
description: Initialize a new project from this template. Updates README, CLAUDE.md, Makefile, package.json, and docs to match the new project.
disable-model-invocation: true
argument-hint: "[project name (optional, auto-detected from git remote)]"
---

# Init Project

Set up a new project from this template repository.

## Procedure

### 1. Gather project information

Auto-detect from git remote, then ask for anything missing:

```bash
# Auto-detect project name and repo URL from git remote
gh repo view --json name,description,url 2>/dev/null

# Fallback: parse from git remote URL
git remote get-url origin 2>/dev/null
```

If `$ARGUMENTS` is provided, use it as the project name override.

Auto-detected values can be overridden by the user. Ask for anything that couldn't be detected:

- **Project name** — from GitHub repo name, or `$ARGUMENTS`, or ask
- **Brief description** — from GitHub repo description, or ask
- **Tech stack** (e.g., React + FastAPI + PostgreSQL, or different) — always ask
- **Repository URL** — from git remote, or ask

### 2. Run base initialization

```bash
make init
```

This copies devcontainer and docker-compose example files.

### 3. Update package.json

Replace template values:

- `name` → project name
- `description` → project description
- Keep all devDependencies and scripts as-is

### 4. Update README.md

Rewrite with the new project's information:

- Project name and description
- Actual tech stack and architecture diagram
- Correct directory structure
- Updated Getting Started steps
- Remove template-specific content ("Template for Development", sample app references)

Preserve the overall structure (Overview, Features, Architecture, Getting Started).

### 5. Update CLAUDE.md

Update these sections:

- **Project Overview** — actual project description and purpose
- **Repository Structure** — adjust if directories changed
- **Commands** — add project-specific commands if needed

Keep all other sections (Commit Conventions, Code Style, CI/CD, etc.) unchanged.

### 6. Update docs/

- `docs/SETUP.md` — write actual setup prerequisites and steps
- `docs/ARCHITECTURE.md` — outline the planned architecture
- `docs/CONTRIBUTING.md` — adjust if contribution flow differs
- Leave `docs/API.yml` as placeholder unless API design is known

### 7. Update Makefile

Add or adjust targets based on the tech stack:

- Keep `init`, `build`, `up`, `down`, `logs`, `clean`
- Add `test`, `lint`, `format` targets if applicable
- Update commands if docker-compose path or structure changes

### 8. Optional: Reset git history

Ask the user if they want to reset git history to start fresh:

```bash
rm -rf .git
git init
git add .
git commit -m "chore: initialize project from template"
```

Only do this if the user explicitly confirms.

### 9. Summary

```text
Project Initialized: <project-name>
─────────────────────────────────────
Updated:
  - package.json (name, description)
  - README.md (project info, architecture)
  - CLAUDE.md (project overview)
  - docs/SETUP.md (setup instructions)
  - docs/ARCHITECTURE.md (architecture outline)
  - Makefile (targets)

Initialized:
  - .devcontainer/devcontainer.json
  - app/docker-compose.yml

Next steps:
  1. Review the generated files
  2. Run `make build && make up` to start
  3. Begin development
```
