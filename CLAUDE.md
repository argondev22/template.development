# CLAUDE.md

This file provides guidance to Claude Code when working with this repository.

## Project Overview

This is a **development template repository** that provides standardized project structure, tooling, and CI/CD configuration. It is designed to be cloned as a starting point for new projects.

## Repository Structure

- **app/** - Application source code
- **bin/** - Project initialization scripts (`make init`)
- **docs/** - Project documentation (API, Architecture, Setup, etc.)
- **infra/** - Infrastructure configuration
- **.github/** - GitHub Actions workflows, PR templates, issue templates
- **.husky/** - Git hooks (commit-msg with commitlint)

## Commands

```bash
# Project initialization
make init

# Docker operations
make build    # Build containers
make up       # Start containers
make down     # Stop containers
make logs     # View container logs
make clean    # Prune Docker resources

# Formatting & Linting
npm run format          # Run Prettier + markdownlint fix
npm run format:check    # Check formatting (CI)
npm run lint:markdown   # Lint markdown files
```

## Commit Conventions

This project uses **Conventional Commits** enforced by commitlint + husky.

Format: `<type>: <subject>`

Allowed types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`, `deps`, `docker`

Rules:
- Type is required, lowercase only
- Subject is required, no period at the end
- Header max 100 characters
- Body/footer lines max 100 characters

## Code Style

- **Indent:** 2 spaces (tabs for Makefile)
- **Line endings:** LF
- **Charset:** UTF-8
- **Trailing whitespace:** trimmed (except Markdown)
- **Final newline:** always
- **Prettier:** printWidth 100, semicolons, double quotes, trailing commas (ES5)

## CI/CD

GitHub Actions runs on push to `main` and PRs:

- **Prettier** - Code formatting check
- **markdownlint** - Markdown linting
- **yamllint** - YAML linting
- **actionlint** - GitHub Actions workflow linting
- **Dependabot** - Dependency updates with auto-merge

## Documentation

All project documentation lives in `docs/`. When making changes that affect setup, architecture, or APIs, update the corresponding doc file:

- `docs/SETUP.md` - Setup instructions
- `docs/ARCHITECTURE.md` - Architecture decisions
- `docs/API.yml` - API specifications
- `docs/CONTRIBUTING.md` - Contribution guidelines

## Working Guidelines

- Run `npm run format:check` before committing to ensure CI will pass
- Follow the PR template in `.github/PULL_REQUEST_TEMPLATE.md`
- Keep documentation in sync with code changes
