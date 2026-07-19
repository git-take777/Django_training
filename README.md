# freelance-accounting

架空のフリーランスの売上・経費を記録し、カテゴリ別・月別にグラフ化する学習用 Django アプリ。

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

```bash
docker compose exec web python manage.py startapp records
```

# Django_training

## tailwindcssの導入

`django-tailwind` の **Standalone（Tailwind v4, Node.js不要）** 構成を使用。
`theme` アプリとして生成済み（`src/theme/`）で、`tailwind_css` タグを読み込んだテンプレートで利用できる。

セットアップ済みの状態でリポジトリを clone した場合、以下だけでよい:

```bash
# コンテナ起動
docker compose up -d

# Tailwind CLI（スタンドアロンバイナリ）を起動し、CSSの変更を監視・ビルドする
# 開発中はこのプロセスを動かし続ける
docker compose exec web python manage.py tailwind start
```

初回のみ、または `theme` アプリを作り直す場合:

```bash
docker compose exec web python manage.py tailwind init
# → アプリ名を聞かれたら「theme」と入力
# → テンプレート選択で「1 (Tailwind v4 Standalone)」を選択（Node.js不要）
```

### テンプレートでの使い方

```html
{% load tailwind_tags %}
<head>
  {% tailwind_css %}
</head>
```

`src/theme/templates/base.html` を参考に、各テンプレートで `{% tailwind_css %}` を読み込むか、`base.html` を extends する。
