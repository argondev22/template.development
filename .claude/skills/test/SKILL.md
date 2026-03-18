---
name: test
description: プロジェクトのテストを実行し、結果を報告する。失敗があれば LOG.md に記録する。
disable-model-invocation: true
argument-hint: "[テスト対象のパスやパターン (optional)]"
---

# テスト実行

プロジェクトのテストを実行し、結果を報告する。

**重要: このスキルはテストを実行するだけで、コードの修正は行わない。**

## Procedure

### 1. テスト環境の検出

プロジェクトの設定ファイルからテストランナーを検出する:

| ファイル                                 | テストコマンド                      |
| ---------------------------------------- | ----------------------------------- |
| `jest.config.*` / `package.json` (jest)  | `make test` または `npx jest`       |
| `vitest.config.*`                        | `make test` または `npx vitest run` |
| `pytest.ini` / `pyproject.toml` (pytest) | `make test` または `pytest`         |
| `go.mod`                                 | `go test ./...`                     |
| `Cargo.toml`                             | `cargo test`                        |

`make test` ターゲットが存在する場合は優先的に使用する。

### 2. テストの実行

`$ARGUMENTS` が指定されている場合は、対象を絞ってテストを実行する。

```bash
make test
```

または対象を指定:

```bash
npx jest $ARGUMENTS
```

### 3. 結果の分析

テスト結果を分析する:

- **全件パス** → 成功を報告して終了
- **失敗あり** → 失敗したテストを `/log ai [テスト] <内容>` で LOG.md に記録する

記録例:

- `/log ai [テスト] POST /auth/login のバリデーションテストが失敗: 空文字のメールアドレスで 400 が返るべきところ 200 が返る`
- `/log ai [テスト] UserModel.create のユニットテストが失敗: unique 制約違反時の例外ハンドリングが未実装`

### 4. 完了報告

```text
テスト実行完了
═══════════════════════════════════════
実行:   <N テスト>
成功:   <N>
失敗:   <N>
スキップ: <N>

失敗したテスト:
  - <テスト名>: <失敗理由の要約>

LOG.md に記録: <N 件>
═══════════════════════════════════════
```
