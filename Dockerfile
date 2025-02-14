FROM python:3.9.9-buster

RUN apt-get update \
    && apt-get install -y --no-install-recommends apt-utils libsasl2-dev libssl-dev \
 libfuzzy-dev net-tools python3-psycopg2 git osslsigncode apache2-utils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip

COPY MockS/requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip install --no-cache-dir --compile -r requirements.txt

COPY ./MockS/ /app/

EXPOSE 8000

COPY docker/entrypoint/entrypoint.sh /app/
COPY docker/entrypoint/entrypoint_celery.sh /app/
COPY docker/entrypoint/entrypoint_beat_celery.sh /app/