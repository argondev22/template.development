---
name: pr
description: 現在のブランチからプルリクエストを作成する。
disable-model-invocation: true
argument-hint: "[PR タイトル (optional)]"
---

# PR 作成

現在のブランチからプルリクエストを作成する。

## Procedure

### 1. 状態の確認

以下を並列で実行する:

```bash
git branch --show-current
git status
git log --oneline main..HEAD
git diff main..HEAD --stat
```

確認事項:

- `main` ブランチにいる場合 → 停止する（PR は作業ブランチから作成する）
- 未コミットの変更がある場合 → ユーザーに警告し、先にコミットするか確認する
- `main` との差分がない場合 → 停止する（PR にする変更がない）

### 2. リモートへのプッシュ

リモートブランチの状態を確認し、必要に応じてプッシュする:

```bash
git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null
```

- リモートブランチが未設定、またはローカルが先行している場合:

```bash
git push -u origin <current-branch>
```

### 3. PR 内容の作成

`main..HEAD` のコミット履歴と diff を分析し、PR テンプレート（`.github/PULL_REQUEST_TEMPLATE.md`）に沿って内容を作成する。

**タイトル:**

- `$ARGUMENTS` が指定されている場合はそれを使用する
- 指定がない場合はコミット履歴から適切なタイトルを生成する
- 70 文字以内に収める

**本文:**

```markdown
## What does this PR do?

<コミット履歴と diff から、変更の目的を 1〜3 文で要約>

## Changes

- <変更点を箇条書き>

## How to test

<テスト手順を箇条書き>

## Notes

<補足事項。なければ省略>
```

### 4. PR の作成

```bash
gh pr create --title "<タイトル>" --body "$(cat <<'EOF'
<本文>
EOF
)"
```

### 5. 完了報告

```text
PR を作成しました
═══════════════════════════════════════
URL:      <PR の URL>
Title:    <タイトル>
Branch:   <current-branch> → main
Commits:  <N commits>
═══════════════════════════════════════
```
