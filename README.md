# freelance-accounting

フリーランスの売上・経費を記録し、カテゴリ別・月別にグラフ化する学習用 Django アプリ。

- Django 6.0 / Python 3.13（コンテナ内）
- PostgreSQL 18
- Docker Compose で `web`（Django）と `db`（PostgreSQL）を起動

## ディレクトリ構成

```
freelance-accounting/
├── docker-compose.yml
├── Dockerfile
├── entrypoint.sh
├── requirements.txt
├── .env                # ローカル開発用（gitignore 済み）
├── .env.example        # 変数のひな型
├── .dockerignore
├── .gitignore
└── src/                # Django プロジェクト本体
    ├── manage.py
    └── config/         # 設定モジュール（settings.py など）
```

## 使い方

初回のみ、必要なら `.env` を自分の値に調整してください（そのままでもローカルで動きます）。

```bash
# 起動（初回はイメージのビルドが走る）
docker compose up --build

# ブラウザで開く
# http://localhost:8000/
```

コンテナ起動時に `migrate` が自動で流れます。管理ユーザーを作る場合:

```bash
docker compose exec web python manage.py createsuperuser
# → http://localhost:8000/admin/
```

停止 / 後片付け:

```bash
docker compose down          # コンテナ停止
docker compose down -v       # DB データ（volume）も削除
```

## 次のステップ

この環境は「箱」だけの状態です。次は Phase 2 として
`records` アプリを作成し、`Category` / `Transaction`（必要なら `Client`）
モデルを実装していきます。

```bash
docker compose exec web python manage.py startapp records
```
