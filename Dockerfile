FROM python:3.11.3-alpine3.18

LABEL maintainer="carloseduguimaraess@gmail.com"

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY requirements.txt /app/
WORKDIR /app

RUN apk add --no-cache \
    postgresql-client \
    gcc \
    python3-dev \
    musl-dev \
    postgresql-dev \
    jpeg-dev \
    zlib-dev \
    libffi-dev \
    && pip install --no-cache-dir -r requirements.txt \
    && adduser --disabled-password --no-create-home duser \
    && mkdir -p /data/web/static \
    && mkdir -p /data/web/media \
    && chown -R duser:duser /app \
    && chown -R duser:duser /data/web/static \
    && chown -R duser:duser /data/web/media \
    && chmod -R 755 /data/web/static \
    && chmod -R 755 /data/web/media \
    && chmod -R +x /app

COPY . /app

USER duser

CMD ["sh", "commands.sh"]