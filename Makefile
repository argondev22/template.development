.PHONY: install format lint build up down logs clean help

help: ## コマンド一覧を表示
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2}'

install: ## 依存関係をインストール
	@npm install

format: ## Prettier + markdownlint で自動修正
	@npx prettier --write .
	@npx markdownlint-cli2 --fix --config .markdownlint.jsonc "**/*.md"

lint: ## 全リンターチェック（CI と同等）
	@npx prettier --check .
	@npx markdownlint-cli2 --config .markdownlint.jsonc "**/*.md"

build: ## Docker コンテナをビルド
	@cd app && docker compose build

up: ## Docker コンテナを起動
	@cd app && docker compose up -d

down: ## Docker コンテナを停止
	@cd app && docker compose down

logs: ## Docker コンテナログを表示
	@cd app && docker compose logs -f

clean: ## Docker リソースを削除
	@docker system prune -f
	@docker volume prune -f
