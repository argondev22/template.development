---
name: pr-fix
description: PR の CI 失敗とレビューコメントを確認し、問題を分析・記録する。
argument-hint: "[PR 番号またはブランチ名 (optional)]"
---

# PR 修正

PR のステータスチェックとレビューコメントを確認し、問題を分析する。

**重要: Claude がコードを直接変更することはしない。** 自動修正コマンド（`make format` 等）の実行は許可されるが、それ以外の問題はすべて `/log ai` で LOG.md に記録し、`/task` → `/impl` のフローで対応する。

## Procedure

### 1. PR の状態を取得

`$ARGUMENTS` で PR 番号またはブランチが指定されている場合はそれを使用する。なければ現在のブランチから検出する。

```bash
git branch --show-current
gh pr checks $ARGUMENTS
gh pr view $ARGUMENTS --json reviews,comments
```

### 2. CI の確認

CI のステータスチェックを確認する:

```bash
gh pr checks $ARGUMENTS
```

すべて通っている場合はスキップしてステップ 3 に進む。

失敗がある場合、詳細ログを取得する:

```bash
gh run view <run-id> --log-failed
```

カテゴリ別に対応する:

#### 自動修正コマンドで解決できるもの

以下のコマンドを実行して修正する:

```bash
make format   # Prettier + markdownlint の自動修正
```

#### 自動修正コマンドで解決できないもの

すべて `/log ai [CI] <内容>` で記録する。例:

- `/log ai [CI] ビルドエラー: UserModel に必須フィールド email が不足`
- `/log ai [CI] テスト失敗: POST /auth/login が 500 を返す。認証ロジックの修正が必要`
- `/log ai [CI] yamllint: deploy.yml の行 42 でインデントエラー`

### 3. レビューコメントの確認

PR のレビューコメントを取得する:

```bash
gh pr view $ARGUMENTS --json reviews,comments
gh api repos/{owner}/{repo}/pulls/{number}/comments
```

コメントがない、またはすべて解決済みの場合はスキップする。

未対応のコメントがある場合、すべて `/log ai [PR指摘] <内容>` で記録する。例:

- `/log ai [PR指摘] レビューで命名の改善を求められている: getUserData → fetchUserProfile`
- `/log ai [PR指摘] エラーハンドリングの追加を求められている: API 呼び出し箇所`
- `/log ai [PR指摘] 認証方式の変更を求められている: JWT → OAuth`

### 4. ローカルでの検証

自動修正コマンドを実行した場合、CI と同じチェックをローカルで実行する:

```bash
make lint
```

### 5. コミットとプッシュ

自動修正コマンドによる変更がある場合のみ、`/commit` スキルでコミットし、リモートにプッシュする。

### 6. 完了報告

```text
PR 確認完了
═══════════════════════════════════════
対象:       <PR 番号またはブランチ>

CI:
  - 自動修正: <N 件>
  - LOG.md に記録: <N 件>

レビュー:
  - LOG.md に記録: <N 件>

LOG.md に記録した項目がある場合:
  - /log で AI コメントを確認し、対応方針を決定してください
  - /task でタスク化 → /impl で実装
═══════════════════════════════════════
```
