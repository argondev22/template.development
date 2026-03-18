---
name: init
description: セッション開始時にプロジェクトの状態を把握する。最初に実行するスキル。
disable-model-invocation: true
---

# セッション初期化

セッション開始時にプロジェクトの現状を把握し、次の作業に繋げる。

## Procedure

### 1. ドキュメントの確認

以下のファイルを読み込み、プロジェクトの概要と現在の状態を把握する:

- `README.md` — プロジェクトの概要
- `docs/` 配下のドキュメント（`DESIGN.md`, `REQUIREMENTS.md`, `TASK.md` など）

各ファイルについて:

- 内容がある → 要点を 1〜2 行でまとめる
- 空または未作成 → 「未作成」と記録する

### 2. Git の状態確認

以下を並列で実行する:

```bash
git status
git log --oneline -10
git branch -a
gh pr list --limit 5 2>/dev/null
```

把握すべき情報:

- 現在のブランチ
- 未コミットの変更があるか
- 直近のコミット履歴（作業の流れ）
- オープンな PR の有無

### 3. メモリの読み込み

`.claude/memory/` 配下のファイルを確認する:

```bash
ls .claude/memory/
```

- メモリファイルが存在する場合は、すべて読み込んで内容を把握する
- `.gitkeep` のみ、またはディレクトリが空の場合はスキップする

### 4. セッションサマリーの出力

収集した情報を以下のフォーマットで出力する:

```text
Session Summary
═══════════════════════════════════════
Project:  <project name from README>
Branch:   <current branch>
Status:   <clean / N uncommitted changes>

Recent Commits:
  - <commit 1>
  - <commit 2>
  - <commit 3>
  ...

Documents:
  - README.md: <概要 or 未作成>
  - docs/DESIGN.md: <概要 or 未作成>
  - docs/REQUIREMENTS.md: <概要 or 未作成>
  - docs/TASK.md: <概要 or 未作成>

Memory:
  - <filename>: <概要>
  - (none)

Open PRs:
  - #N <title> (or none)
═══════════════════════════════════════
```

### 5. 次のアクションを聞く

サマリー出力後、ユーザーに「何をしますか？」と聞いて指示を待つ。
