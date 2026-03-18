---
name: pr-fix
description: PR の CI 失敗とレビューコメントを確認し、問題を修正する。
argument-hint: "[PR 番号またはブランチ名 (optional)]"
---

# PR 修正

PR のステータスチェックとレビューコメントを確認し、問題を修正する。

## Procedure

### 1. PR の状態を取得

`$ARGUMENTS` で PR 番号またはブランチが指定されている場合はそれを使用する。なければ現在のブランチから検出する。

```bash
git branch --show-current
gh pr checks $ARGUMENTS
gh pr view $ARGUMENTS --json reviews,comments
```

### 2. CI の確認と修正

CI のステータスチェックを確認する:

```bash
gh pr checks $ARGUMENTS
```

すべて通っている場合はスキップしてステップ 3 に進む。

失敗がある場合、詳細ログを取得する:

```bash
gh run view <run-id> --log-failed
```

カテゴリ別に修正する:

#### Prettier の失敗

```bash
npm run format
```

#### markdownlint の失敗

```bash
npm run format:markdown
```

自動修正できないルールは手動で修正する。

#### yamllint の失敗

エラー出力を読み、YAML フォーマットを修正する。

#### actionlint の失敗

`.github/workflows/` 内のワークフロー構文を修正する。

#### ビルドの失敗

エラーログを分析し、原因を特定して修正する。

#### テストの失敗

失敗しているテストを特定し、根本原因を修正する。

### 3. レビューコメントの確認と対応

PR のレビューコメントを取得する:

```bash
gh pr view $ARGUMENTS --json reviews,comments
gh api repos/{owner}/{repo}/pulls/{number}/comments
```

コメントがない、またはすべて解決済みの場合はスキップする。

未対応のコメントがある場合:

1. 各コメントの内容を読み、指摘事項を把握する
2. コードを修正して指摘に対応する
3. 対応内容をユーザーに報告する

### 4. ローカルでの検証

CI と同じチェックをローカルで実行する:

```bash
npm run format:check
npm run lint:markdown
```

### 5. 修正のコミットとプッシュ

変更がある場合は `/commit` スキルでコミットし、リモートにプッシュする。

### 6. 完了報告

```text
PR 修正完了
═══════════════════════════════════════
対象:       <PR 番号またはブランチ>

CI:
  - <N 件の失敗を修正 / すべて通過済み>

レビュー:
  - <N 件の指摘に対応 / 未対応のコメントなし>

未解決:
  - <自動修正できなかった問題>

ローカル検証: PASS
═══════════════════════════════════════
```
