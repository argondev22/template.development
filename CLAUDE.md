# CLAUDE.md

このファイルは、Claude Code がこのリポジトリで作業する際のガイダンスを提供する。

## プロジェクト概要

これは**開発テンプレートリポジトリ**であり、標準化されたプロジェクト構成、ツール、CI/CD 設定を提供する。新規プロジェクトの出発点としてクローンして使用する。

## リポジトリ構成

- **app/** - アプリケーションソースコード
- **bin/** - プロジェクト初期化スクリプト (`make init`)
- **docs/** - プロジェクトドキュメント (API、アーキテクチャ、セットアップなど)
- **infra/** - インフラ構成
- **.github/** - GitHub Actions ワークフロー、PR テンプレート、Issue テンプレート
- **.husky/** - Git フック (commitlint による commit-msg 検証)

## コマンド

```bash
# プロジェクト初期化
make init

# Docker 操作
make build    # コンテナをビルド
make up       # コンテナを起動
make down     # コンテナを停止
make logs     # コンテナログを表示
make clean    # Docker リソースを削除

# フォーマット & リント
npm run format          # Prettier + markdownlint で自動修正
npm run format:check    # フォーマットチェック (CI用)
npm run lint:markdown   # Markdown のリント
```

## コミット規約

このプロジェクトでは commitlint + husky で **Conventional Commits** を強制している。

フォーマット: `<type>: <subject>`

使用可能な type: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`, `deps`, `docker`

ルール:

- type は必須、小文字のみ
- subject は必須、末尾にピリオドを付けない
- ヘッダーは最大 100 文字
- body/footer の各行は最大 100 文字

## コードスタイル

- **インデント:** スペース 2 つ (Makefile はタブ)
- **改行コード:** LF
- **文字コード:** UTF-8
- **末尾の空白:** 削除 (Markdown を除く)
- **ファイル末尾の改行:** 常に付与
- **Prettier:** printWidth 100、セミコロンあり、ダブルクォート、トレイリングカンマ (ES5)

## CI/CD

GitHub Actions は `main` への push と PR で実行される:

- **Prettier** - コードフォーマットチェック
- **markdownlint** - Markdown リント
- **yamllint** - YAML リント
- **actionlint** - GitHub Actions ワークフローリント
- **Dependabot** - 依存関係の自動更新とオートマージ

## ドキュメント

プロジェクトドキュメントは `docs/` に配置する。セットアップ、アーキテクチャ、API に影響する変更を行った場合は、対応するドキュメントも更新すること:

- `docs/SETUP.md` - セットアップ手順
- `docs/ARCHITECTURE.md` - アーキテクチャ決定事項
- `docs/API.yml` - API 仕様
- `docs/CONTRIBUTING.md` - コントリビューションガイドライン

## 作業ガイドライン

- コミット前に `npm run format:check` を実行して CI が通ることを確認する
- `.github/PULL_REQUEST_TEMPLATE.md` の PR テンプレートに従う
- コード変更に合わせてドキュメントを常に同期させる
- 実装がドキュメントの設計・要件・仕様と異なる場合は、関連ドキュメント (`docs/`, `CLAUDE.md` など) を必ず更新する。古いドキュメントを放置しない — コード変更と同じコミット、または直後に更新する

## 秘密情報の取り扱い

秘密情報は**絶対にコミットや GitHub へのアップロードをしてはならない**。以下のルールを厳守すること:

### 対象ファイル

以下のファイルはコミット禁止。`git add` の対象にしない:

- `.env`, `.env.*` (`.env.example` を除く)
- `credentials.json`, `serviceAccountKey.json` などの認証情報ファイル
- `*.pem`, `*.key`, `*.p12` などの秘密鍵・証明書
- `*secret*`, `*token*` を含むファイル名

### 対象コンテンツ

以下の値をソースコードやドキュメントにハードコードしない:

- API キー、アクセストークン、シークレット
- パスワード、接続文字列
- AWS / GCP / Azure のクレデンシャル
- SSH 秘密鍵
- JWT シークレット

### 運用ルール

- 秘密情報は環境変数または Secret Manager 経由で注入する
- テンプレートやサンプルには必ずダミー値 (`your-api-key-here` など) を使用する
- ユーザーに秘密情報を含むファイルのコミットを求められた場合は、リスクを警告し代替案を提示する
- `git diff` や `git status` の出力に秘密情報が含まれていないか常に確認する

## メモリ管理

ユーザーとの会話で得た重要な情報を `.claude/memory/` 配下にメモリファイルとして保存する:

- **ユーザーの好み・ポリシー**: コーディングスタイル、ツール使用法、ワークフローの好みと指示
- **プロジェクト固有の決定事項**: アーキテクチャ決定、技術選定とその理由、制約
- **繰り返しのフィードバック**: 修正指示、「こうやってくれ」というセッションをまたいで残すべきリクエスト
- **外部リソースの参照先**: 関連ドキュメント、チケット、ダッシュボードの URL など

保存時のルール:

- コード自体から読み取れる情報 (構造、パターンなど) は保存しない
- git 履歴から取得できる情報は保存しない
- 一時的なタスク状態は保存しない
- 重複を避けるため、保存前に既存のメモリを確認する
