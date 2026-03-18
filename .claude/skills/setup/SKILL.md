---
name: setup
description: テンプレートから新規プロジェクトを初期化する。README、CLAUDE.md、Makefile、package.json、docs を更新する。
disable-model-invocation: true
argument-hint: "[プロジェクト名 (optional、git remote から自動検出)]"
---

# プロジェクト初期化

テンプレートリポジトリから新規プロジェクトをセットアップする。

## Procedure

### 1. プロジェクト情報の収集

git remote から自動検出し、不足分はユーザーに確認する:

```bash
gh repo view --json name,description,url 2>/dev/null
git remote get-url origin 2>/dev/null
```

`$ARGUMENTS` が指定されている場合は、プロジェクト名として使用する。

自動検出された値はユーザーが上書き可能。検出できなかった項目は確認する:

- **プロジェクト名** — GitHub リポジトリ名、`$ARGUMENTS`、または確認
- **簡単な説明** — GitHub リポジトリの説明、または確認
- **技術スタック**（例: React + FastAPI + PostgreSQL）— 必ず確認する
- **リポジトリ URL** — git remote から取得、または確認

### 2. ベース初期化の実行

```bash
make init
```

devcontainer と docker-compose のサンプルファイルをコピーする。

### 3. package.json の更新

テンプレートの値を置き換える:

- `name` → プロジェクト名
- `description` → プロジェクトの説明
- devDependencies と scripts はそのまま維持する

### 4. README.md の更新

新規プロジェクトの情報で書き換える:

- プロジェクト名と説明
- 実際の技術スタックとアーキテクチャ図
- 正しいディレクトリ構成
- Getting Started 手順の更新
- テンプレート固有の内容を削除

全体の構造（Overview, Features, Architecture, Getting Started）は維持する。

### 5. CLAUDE.md の更新

以下のセクションを更新する:

- **プロジェクト概要** — 実際のプロジェクトの説明と目的
- **リポジトリ構成** — ディレクトリが変更された場合は調整
- **コマンド** — プロジェクト固有のコマンドがあれば追加

他のセクション（コミット規約、コードスタイル、CI/CD など）はそのまま維持する。

### 6. docs/ の更新

- `docs/SETUP.md` — 実際のセットアップ前提条件と手順を記述
- `docs/ARCHITECTURE.md` — 予定しているアーキテクチャの概要を記述
- `docs/CONTRIBUTING.md` — コントリビューションフローが異なる場合は調整
- `docs/API.yml` — API 設計が決まっていなければプレースホルダーのまま

### 7. Makefile の更新

技術スタックに基づいてターゲットを追加・調整する:

- `init`, `build`, `up`, `down`, `logs`, `clean` は維持
- 必要に応じて `test`, `lint`, `format` ターゲットを追加
- docker-compose のパスや構成が変わった場合はコマンドを更新

### 8. 任意: git 履歴のリセット

git 履歴をリセットして新規スタートするかユーザーに確認する:

```bash
rm -rf .git
git init
git add .
git commit -m "chore: initialize project from template"
```

ユーザーが明示的に確認した場合のみ実行する。

### 9. 完了報告

```text
プロジェクト初期化完了: <project-name>
═══════════════════════════════════════
更新済み:
  - package.json (name, description)
  - README.md (プロジェクト情報、アーキテクチャ)
  - CLAUDE.md (プロジェクト概要)
  - docs/SETUP.md (セットアップ手順)
  - docs/ARCHITECTURE.md (アーキテクチャ概要)
  - Makefile (ターゲット)

初期化済み:
  - .devcontainer/devcontainer.json
  - app/docker-compose.yml

次のステップ:
  1. 生成されたファイルをレビューする
  2. `make build && make up` で起動する
  3. 開発を開始する
═══════════════════════════════════════
```
