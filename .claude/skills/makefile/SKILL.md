---
name: makefile
description: プロジェクトの状態を分析し、開発者が必要とするコマンドを Makefile に反映する。
disable-model-invocation: true
argument-hint: "[追加したいコマンドの説明 (optional)]"
---

# Makefile 更新

プロジェクトの状態を分析し、開発者が直接叩く必要のあるコマンドを Makefile に統一的なインターフェースとして整備する。

## Procedure

### 1. プロジェクトの分析

以下のファイル・設定を確認し、開発者が操作に使うコマンドを洗い出す:

- `package.json` — npm scripts
- `docker-compose.yml` / `docker-compose.*.yml` — Docker 操作
- `Dockerfile` — ビルド関連
- `tsconfig.json` / `eslint.config.*` / `.prettierrc*` — ビルド・リント・フォーマット
- `jest.config.*` / `vitest.config.*` / `pytest.ini` / `pyproject.toml` — テスト
- `infra/` — インフラ関連コマンド（terraform, cdk 等）
- その他、プロジェクト固有の設定ファイル

### 2. 既存の Makefile を確認

`Makefile` を読み込み、現在定義されているターゲットを把握する。

`$ARGUMENTS` が指定されている場合は、その内容に対応するターゲットの追加・更新にフォーカスする。

### 3. 必要なターゲットの特定

分析結果から、以下の観点でターゲットを整理する:

- **既に Makefile にあり、そのままでよいもの** → 変更しない
- **既に Makefile にあるが、実態と合っていないもの** → 更新する
- **Makefile にないが、開発者が直接叩きそうなもの** → 追加する
- **Makefile にあるが、もう使われていないもの** → 削除を提案する

### 4. Makefile の更新

ターゲットは以下のフォーマットで記述する:

```makefile
target: ## 日本語の説明
	@コマンド
```

ルール:

- すべてのターゲットに `## 説明` コメントを付ける（`make help` で表示されるため）
- `.PHONY` にすべてのターゲットを列挙する
- コマンドの先頭には `@` を付けて、実行時にコマンド自体を表示しない
- 関連するターゲットはコメント行でグループ化する
- `help` ターゲットは常に先頭に配置する

グループの例:

```makefile
# --- セットアップ ---
install: ## 依存関係をインストール

# --- 開発 ---
dev: ## 開発サーバーを起動

# --- Docker ---
build: ## Docker コンテナをビルド

# --- 品質 ---
format: ## コードを自動整形
lint: ## リンターを実行
test: ## テストを実行
```

### 5. 完了報告

```text
Makefile を更新しました
═══════════════════════════════════════
追加: <N ターゲット>
更新: <N ターゲット>
削除提案: <N ターゲット>

変更内容:
  - <ターゲット名>: <説明>
═══════════════════════════════════════
```
