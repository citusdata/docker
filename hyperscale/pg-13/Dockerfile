FROM postgres:13.5
ARG VERSION=10.2.2
LABEL maintainer="Citus Data https://citusdata.com" \
      org.label-schema.name="Citus" \
      org.label-schema.description="Scalable PostgreSQL for multi-tenant and real-time workloads" \
      org.label-schema.url="https://www.citusdata.com" \
      org.label-schema.vcs-url="https://github.com/citusdata/citus" \
      org.label-schema.vendor="Citus Data, Inc." \
      org.label-schema.version=${VERSION} \
      org.label-schema.schema-version="1.0"

ENV CITUS_VERSION ${VERSION}.citus-1
ENV POSTGRES_DB citus
ENV PGDATA /data

# install Citus and needed extension on hyperscale
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       curl \
    && curl -s https://install.citusdata.com/community/deb.sh | bash \
    && apt-get install -y postgresql-$PG_MAJOR-citus-10.2=$CITUS_VERSION \
                          postgresql-$PG_MAJOR-hll=2.16.citus-1 \
                          postgresql-$PG_MAJOR-topn=2.4.0 \
                          postgresql-13-postgis-3 \
                          postgresql-plperl-13 \
                          postgresql-contrib \
                          postgresql-13-partman \
                          postgresql-13-tdigest \
                          postgresql-13-mysql-fdw \
                          postgresql-13-cron \
    && apt-get purge -y --auto-remove curl \
    && rm -rf /var/lib/apt/lists/*

# set shared_preload_libraries to the list of extensions that needs to be loaded when postgresql starts
RUN echo "shared_preload_libraries='citus,pg_cron,pg_stat_statements'" >> /usr/share/postgresql/postgresql.conf.sample

# set default database name for pg_cron extension
RUN echo "cron.database_name = 'citus'" >> /usr/share/postgresql/postgresql.conf.sample

# add scam-sha-256 into postgresql.conf.sample to make scram-sha-256 in pg_hba.conf work
RUN echo "password_encryption = scram-sha-256" >> /usr/share/postgresql/postgresql.conf.sample

# add scripts to run after initdb
COPY hyperscale/001-db-user-creation.sql /docker-entrypoint-initdb.d/
COPY hyperscale/002-create_extension_functions.sql /docker-entrypoint-initdb.d/
COPY hyperscale/003-create_citus_extension.sql /docker-entrypoint-initdb.d/
COPY hyperscale/004-postgres_replication_origins.sql /docker-entrypoint-initdb.d/
COPY hyperscale/005-other_extensions.sql /docker-entrypoint-initdb.d/
COPY hyperscale/006-pg_cron_pg_partman_setup.sql /docker-entrypoint-initdb.d/
COPY hyperscale/007-grant_usage_fdw.sql /docker-entrypoint-initdb.d/
COPY hyperscale/008-other_grants.sql /docker-entrypoint-initdb.d/
COPY hyperscale/009-stat_statements_reset.sql /docker-entrypoint-initdb.d/

# copy access rules for postgres
COPY hyperscale/pg_hba.conf /pg_hba.conf

# add health check script
COPY pg_healthcheck wait-for-manager.sh /

# required for to replace citus user password in the execution of docker-entrypoint.sh
RUN chown -R postgres:postgres /docker-entrypoint-initdb.d

COPY hyperscale/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

HEALTHCHECK --interval=4s --start-period=6s CMD ./pg_healthcheck

