---
name: build-fix
description: Incrementally fix build and type errors one at a time with minimal, safe changes.
---

# Build Fix

Fix build and type errors incrementally with minimal changes.

## Procedure

### 1. Detect build system

| File                              | Command                            |
| --------------------------------- | ---------------------------------- |
| `package.json` (build script)     | `npm run build`                    |
| `tsconfig.json` (no build script) | `npx tsc --noEmit`                 |
| `Cargo.toml`                      | `cargo build 2>&1`                 |
| `go.mod`                          | `go build ./...`                   |
| `pyproject.toml`                  | `python -m py_compile` or `mypy .` |
| `pom.xml`                         | `mvn compile`                      |
| `build.gradle`                    | `./gradlew compileJava`            |

### 2. Run build and parse errors

1. Run the build command, capture output
2. Group errors by file
3. Sort by dependency order (fix imports/types before logic)
4. Count total for progress tracking

### 3. Fix loop (one error at a time)

For each error:

1. **Read** the file around the error location
2. **Diagnose** the root cause
3. **Fix minimally** — smallest change that resolves it
4. **Re-run build** — verify it's fixed and no new errors appeared
5. **Next** — continue with remaining errors

### 4. Stop and ask if

- A fix introduces more errors than it resolves
- The same error persists after 3 attempts
- The fix requires architectural changes
- Missing dependencies need to be installed

### 5. Summary

```text
Build Fix Results
─────────────────
Fixed:     n errors
Remaining: n errors
Introduced: 0 new errors

Files modified:
- path/to/file (what was fixed)
```

If errors remain, suggest next steps.
