#!/bin/sh
set -e

# DB が healthy になってから起動する前提だが、念のため migrate を先に流す
python manage.py migrate --noinput

# CMD（デフォルトは runserver）を実行
exec "$@"
