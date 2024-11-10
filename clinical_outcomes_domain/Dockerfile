FROM python:3.9-slim-buster

WORKDIR /app

RUN apt-get update && apt-get install -qq -y \
    git gcc build-essential libpq-dev --fix-missing --no-install-recommends \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./requirements.txt requirements.txt
RUN pip install --upgrade pip --no-cache-dir
RUN pip install -r requirements.txt --no-cache-dir

# Create directory for dbt config
RUN mkdir -p /root/.dbt
COPY ./profiles.yml /root/.dbt/profiles.yml

# Copy source code
COPY ./clinical_outcomes .

CMD ["tail", "-f", "/dev/null"]