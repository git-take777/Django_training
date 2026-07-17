# セキュリティ要件（public リポジトリ運用）

本リポジトリは **学習用の public リポジトリ**。以下を厳守する。

## git push してはいけないもの

| 対象 | 理由 |
|---|---|
| `SECRET_KEY` | Django のセッション署名等に使用。漏洩するとセッション偽造が可能 |
| `.env` などの環境変数ファイル | 各種認証情報を含む |
| DB ファイル・ダンプ（`*.sqlite3`, dump 等） | **実際の取引データ・取引先名・金額**が入る。実データは絶対に公開しない |
| PostgreSQL の実パスワード | 本リポジトリは Docker + PostgreSQL 構成。実値は `.env` に置き、gitignore する |
| 認証情報全般（APIキー、パスワード） | 漏洩リスク |
| `local_settings.py` 等のローカル設定 | 環境依存の秘密情報を含みうる |

## 対策

### 1. .gitignore で管理（リポジトリ直下の `.gitignore` に記載）
リポジトリ直下の `.gitignore` に設定済み（`.env` / `*.sqlite3` / `local_settings.py` など）。
一度 push した秘密情報は履歴に残るため、`.gitignore` 追加だけでは消えない（キー再生成・履歴書き換えが必要になる）。

### 2. SECRET_KEY を環境変数化
```python
# settings.py
import os
SECRET_KEY = os.environ.get("DJANGO_SECRET_KEY", "dev-only-insecure-key")
```
`python-dotenv` や `django-environ` で `.env` から読み込む構成が定番（`.env` は gitignore 対象）。

### 3. .env.example を代わりにコミット
値を空にしたテンプレート（例: `DJANGO_SECRET_KEY=`）だけを公開し、実値は各自ローカルで設定する。

### 4. DEBUG 設定
公開デプロイする場合は `DEBUG = False` にする。学習用ローカル開発の間は `True` で問題ないが、public repo でも実運用値を直書きしない癖をつける。

### 5. コミット前チェック
- `git status` で意図しないファイルが staged されていないか確認
- 取引先の実名・実金額をサンプルデータやスクリーンショットに含めない（ダミーデータを使う）
