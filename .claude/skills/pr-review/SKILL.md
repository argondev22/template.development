---
name: pr-review
description: PR のステータスチェック（CI）を確認し、失敗しているチェックを修正する。
argument-hint: "[PR 番号またはブランチ名 (optional)]"
---

# PR レビュー

PR のステータスチェックを確認し、失敗があれば修正する。

## Procedure

### 1. CI ステータスの取得

`$ARGUMENTS` で PR 番号またはブランチが指定されている場合はそれを使用する。なければ現在のブランチから検出する。

```bash
git branch --show-current
gh pr checks $ARGUMENTS
gh run list --branch $(git branch --show-current) --limit 5
```

すべてのチェックが通っている場合は「すべての CI チェックが通っています。」と報告して終了する。

### 2. 失敗の特定

失敗しているチェックごとに詳細ログを取得する:

```bash
gh run view <run-id> --log-failed
```

ログから以下を特定する:

- どのジョブが失敗したか（prettier, markdownlint, yamllint, actionlint, build, tests など）
- 具体的なエラーメッセージとファイルの場所
- フォーマットの問題か、リントエラーか、ビルドエラーか

### 3. カテゴリ別の修正

#### Prettier の失敗

```bash
npm run format
```

変更されたファイルを確認し、変更内容をレビューする。

#### markdownlint の失敗

```bash
npm run format:markdown
```

自動修正できないルールは、エラーを読んで手動で修正する。

#### yamllint の失敗

エラー出力を読み、報告されたファイルの YAML フォーマット（インデント、末尾の空白、行の長さなど）を修正する。

#### actionlint の失敗

エラーを読み、`.github/workflows/` 内の GitHub Actions ワークフローの構文を修正する。

#### ビルドの失敗

エラーログを分析し、ビルドエラーの原因を特定して修正する。

#### テストの失敗

テスト出力を読み、失敗しているテストを特定し、根本原因を修正する（テスト自体が間違っている場合を除き、テストのアサーションではなくコードを修正する）。

### 4. ローカルでの検証

CI と同じチェックをローカルで実行する:

```bash
npm run format:check
npm run lint:markdown
```

yamllint がローカルにインストールされている場合:

```bash
yamllint .
```

### 5. 修正のコミット

ローカル検証が通り、変更がある場合は `/commit` スキルでコミットする:

- 修正で変更されたファイルのみをステージングする
- フォーマット修正には `style`、リント/ビルド/テスト修正には `fix` を使用する

### 6. プッシュと報告

コミットをリモートブランチにプッシュし、報告する:

```text
CI 修正結果
═══════════════════════════════════════
対象:     <PR 番号またはブランチ>
失敗:     N 件検出、N 件修正

修正済み:
  - prettier: N ファイル再フォーマット
  - markdownlint: N 件修正

未解決:
  - (自動修正できなかった問題)

ローカル検証: PASS
コミット:   <sha>
プッシュ:   <branch>
═══════════════════════════════════════
```

自動修正できなかった問題がある場合は、提案とともに一覧を表示する。
