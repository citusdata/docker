FROM postgres:9.6.1
MAINTAINER Citus Data https://citusdata.com

ENV CITUS_VERSION 6.0.1.citus-1

# Install cstore_fdw
RUN apt-get update \
    && apt-get install -y git gcc make postgresql-server-dev-9.5 libpq-dev python-psycopg2 \
       protobuf-c-compiler libprotobuf-c0-dev \
    && git clone https://github.com/citusdata/cstore_fdw /opt/cstore \
    && cd /opt/cstore && make && make install \
    && apt-get purge -y --auto-remove git gcc make

# Install Citus
RUN apt-get install -y --no-install-recommends \
       ca-certificates \
       curl \
    && curl -s https://install.citusdata.com/community/deb.sh | bash \
    && apt-get install -y postgresql-$PG_MAJOR-citus=$CITUS_VERSION \
    && apt-get purge -y --auto-remove curl \
    && rm -rf /var/lib/apt/lists/*

# Add citus with cstore_fdw to default PostgreSQL config
RUN echo "shared_preload_libraries='citus, cstore_fdw'" >> /usr/share/postgresql/postgresql.conf.sample

# Add scripts to run after initdb
COPY 000-symlink-workerlist.sh 001-create-citus-extension.sql 002-create-cstore-extension.sql /docker-entrypoint-initdb.d/

# Expose workerlist via volume
VOLUME /etc/citus
