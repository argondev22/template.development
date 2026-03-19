---
name: setup
description: テンプレートから新規プロジェクトを初期化する。README、Makefile、Docker環境、package.json を更新し依存関係をインストールする。
disable-model-invocation: true
argument-hint: "[プロジェクト名 (optional、git remote から自動検出)]"
---

# プロジェクト初期化

テンプレートリポジトリから新規プロジェクトをセットアップする。

**冪等性**: このスキルは何度実行しても安全である。各ステップで現在の状態を確認し、更新が必要な場合のみ変更を行う。すでに正しい値が設定されている項目はスキップする。

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

### 2. README.md の更新

現在の README.md を読み込み、プロジェクト情報がすでに反映されているか確認する。テンプレートのままの内容、または収集した情報と異なる場合のみ更新する。

**更新する範囲（プロジェクト固有セクション）:**

- `# 見出し` + `## 概要` — プロジェクト名と説明
- `## 特徴` — プロジェクトの技術スタック・特徴
- `## ディレクトリ構成` — 実際のディレクトリツリー
- `## セットアップ` — 前提条件、クイックスタート手順

**変更しない範囲（開発テンプレートセクション）:**

- `## 開発フローとスキル` — mermaid 図、スキル一覧、使い方の例
- `## コマンド`
- `## ライセンス`

すでにプロジェクト固有の内容に更新済みの場合はスキップする。

### 3. Docker 環境の整備

技術スタックに基づいて、以下のファイルをテンプレート（`.example`）から生成・更新する。すでにプロジェクト固有の内容に更新済みの場合はスキップする。

**devcontainer:**

- `.devcontainer/devcontainer.example.json` を基に `.devcontainer/devcontainer.json` を生成する
- 技術スタックに応じて調整する項目:
  - `name` → プロジェクト名
  - `features` → 使用言語・ランタイム（Node, Python, Go 等）
  - `customizations.vscode.extensions` → 技術スタックに適した拡張機能
  - `forwardPorts` → 実際に使用するポート

**docker-compose:**

- `app/docker-compose.example.yml` を基に `app/docker-compose.yml` を生成する
- 技術スタックに応じてサービス構成を調整する（フレームワーク、DB 種類、ポート等）

**Dockerfile:**

- `app/client/Dockerfile` — フロントエンドの技術スタックに合わせて書き換える
- `app/server/Dockerfile` — バックエンドの技術スタックに合わせて書き換える

### 4. Makefile の更新

`/makefile` スキルを実行して、技術スタックに基づいた Makefile を生成する:

```
/makefile
```

### 5. 依存関係のインストール

`node_modules/` が存在しないか、`package.json` と `node_modules/` が同期していない場合のみ実行する:

```bash
make install
```

npm パッケージ（commitlint, Prettier, husky 等）をインストールする。

### 6. package.json の更新

現在の `package.json` を読み込み、値がすでにプロジェクト情報と一致している場合はスキップする。テンプレートの値のままの場合のみ置き換える:

- `name` → プロジェクト名
- `description` → プロジェクトの説明
- devDependencies と scripts はそのまま維持する

### 7. 完了報告

```text
プロジェクト初期化完了: <project-name>
═══════════════════════════════════════
更新済み:
  - <更新したファイルのみリスト>

スキップ（変更不要）:
  - <すでに最新だったファイルのみリスト>

次のステップ:
  1. 生成されたファイルをレビューする
  2. `make build && make up` で起動する
  3. 開発を開始する
═══════════════════════════════════════
```
