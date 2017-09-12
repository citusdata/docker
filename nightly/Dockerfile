FROM citusdata/citus:latest
LABEL maintainer="Citus Data https://citusdata.com" \
      org.label-schema.name="Citus" \
      org.label-schema.description="Scalable PostgreSQL for multi-tenant and real-time workloads" \
      org.label-schema.url="https://www.citusdata.com" \
      org.label-schema.vcs-url="https://github.com/citusdata/citus" \
      org.label-schema.vendor="Citus Data, Inc." \
      org.label-schema.version="Nightly" \
      org.label-schema.schema-version="1.0"

# switch to Citus nightly
RUN apt-key del 1530DF18 \
    && rm -rf /etc/apt/sources.list.d/citusdata_community.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       curl \
    && curl -s https://install.citusdata.com/community-nightlies/deb.sh | bash \
    && apt-get install -y postgresql-$PG_MAJOR-citus \
    && apt-get purge -y --auto-remove curl \
    && rm -rf /var/lib/apt/lists/*
