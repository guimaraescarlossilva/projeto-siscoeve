FROM python:3.11.3-alpine3.18
LABEL mantainer="carloseduguimaraess@gmail.com"

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Copia as pastas necessárias para o contêiner
COPY djangoapp /djangoapp
COPY scripts /scripts

# Define o diretório de trabalho
WORKDIR /djangoapp

# Expõe a porta 8000
EXPOSE 8000

# Executa comandos para configuração do ambiente
RUN python -m venv /venv && \
  /venv/bin/pip install --upgrade pip && \
  /venv/bin/pip install -r /djangoapp/requirements.txt && \
  adduser --disabled-password --no-create-home duser && \
  mkdir -p /data/web/static && \
  mkdir -p /data/web/media && \
  chown -R duser:duser /venv && \
  chown -R duser:duser /data/web/static && \
  chown -R duser:duser /data/web/media && \
  chmod -R 755 /data/web/static && \
  chmod -R 755 /data/web/media && \
  chmod +x /scripts/commands.sh

# Adiciona a pasta scripts e venv/bin no $PATH do container.
ENV PATH="/scripts:/venv/bin:$PATH"

# Muda o usuário para duser
USER duser

# Executa o arquivo /scripts/commands.sh
CMD ["/scripts/commands.sh"]
