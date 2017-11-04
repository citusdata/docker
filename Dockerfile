FROM postgres:9.6.5
ARG VERSION=7.0.3
LABEL maintainer="Citus Data https://citusdata.com" \
      org.label-schema.name="Citus" \
      org.label-schema.description="Scalable PostgreSQL for multi-tenant and real-time workloads" \
      org.label-schema.url="https://www.citusdata.com" \
      org.label-schema.vcs-url="https://github.com/citusdata/citus" \
      org.label-schema.vendor="Citus Data, Inc." \
      org.label-schema.version=${VERSION} \
      org.label-schema.schema-version="1.0"

ENV CITUS_VERSION ${VERSION}.citus-1

# install Citus
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       curl \
       wget \
       unzip \
       make \
       gcc \
       g++ \
       libc6-dev \
       protobuf-c-compiler \
       libprotobuf-c0-dev \
       postgresql-server-dev-9.6 \
    && curl -s https://install.citusdata.com/community/deb.sh | bash \
    && apt-get install -y postgresql-$PG_MAJOR-citus-7.0=$CITUS_VERSION \
    && apt-get purge -y --auto-remove curl \
    && rm -rf /var/lib/apt/lists/*

# install cstore_fdw
RUN wget -qO- -O /tmp/tmp.zip https://github.com/citusdata/cstore_fdw/archive/v1.6.0.zip && cd /tmp/ && unzip tmp.zip && rm tmp.zip \ 
&& cd cstore_fdw-1.6.0/ \ 
&& PATH=/usr/local/pgsql/bin/:$PATH make \ 
&& PATH=/usr/local/pgsql/bin/:$PATH make install

# add citus to default PostgreSQL config
RUN echo "shared_preload_libraries='citus,cstore_fdw'" >> /usr/share/postgresql/postgresql.conf.sample

# add scripts to run after initdb
COPY 000-create-citus-extension.sql /docker-entrypoint-initdb.d/

# add health check script
COPY pg_healthcheck /

HEALTHCHECK --interval=4s --start-period=6s CMD ./pg_healthcheck
