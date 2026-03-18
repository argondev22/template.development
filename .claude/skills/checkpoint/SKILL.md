---
name: checkpoint
description: Create, verify, or list named checkpoints for safe experimentation. Use before risky changes or major refactors.
disable-model-invocation: true
argument-hint: "[create|verify|list|clear] [name]"
---

# Checkpoint

Create and manage named checkpoints in your workflow.

## Usage

- `/checkpoint create <name>` — save current state
- `/checkpoint verify <name>` — compare current state to a checkpoint
- `/checkpoint list` — show all checkpoints
- `/checkpoint clear` — remove old checkpoints (keeps last 5)

Arguments: $ARGUMENTS

## Create

1. Verify the working tree is in a good state (no build errors)
2. Create a git commit with message: `checkpoint: <name>`
3. Log to `.claude/checkpoints.log`:

```bash
echo "$(date +%Y-%m-%d-%H:%M) | <name> | $(git rev-parse --short HEAD)" >> .claude/checkpoints.log
```

1. Report:

```text
Checkpoint created: <name>
Commit: <sha>
Time:   <timestamp>
```

## Verify

1. Find the checkpoint in `.claude/checkpoints.log`
2. Compare current state to checkpoint:

```bash
git diff <checkpoint-sha>..HEAD --stat
```

1. Report:

```text
Checkpoint: <name> (<sha>)
──────────────────────────
Files changed:   n
Lines added:     +n
Lines removed:   -n
Commits since:   n
```

## List

Read `.claude/checkpoints.log` and display all entries with name, timestamp, and SHA.

## Clear

Keep only the 5 most recent entries in `.claude/checkpoints.log`.
