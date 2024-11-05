#!/bin/sh
set -e

echo "🔄 Waiting for PostgreSQL..."
while ! nc -z $POSTGRES_HOST $POSTGRES_PORT; do
    echo "🟡 PostgreSQL is unavailable (sleeping)..."
    sleep 2
done
echo "✅ PostgreSQL is up and running on $POSTGRES_HOST:$POSTGRES_PORT"

echo "🔄 Applying database migrations..."
python manage.py migrate --noinput

echo "🔄 Collecting static files..."
python manage.py collectstatic --noinput

echo "🔄 Creating superuser if it doesn't exist..."
python manage.py createsuperuser --noinput || true

echo "🚀 Starting Django development server..."
python manage.py runserver 0.0.0.0:8000