FROM citusdata/citus:latest
MAINTAINER Citus Data https://citusdata.com

ARG BRANCH=master

RUN adduser --disabled-password --gecos '' citus

# Install build dependencies, remove citus release package
RUN apt-get update || true \
    && apt-get remove -y postgresql-$PG_MAJOR-citus \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       curl \
       postgresql-server-dev-$PG_MAJOR \
       libedit-dev libselinux1-dev libxslt-dev  \
       libpam0g-dev git flex make build-essential

RUN mkdir /citus && chown citus /citus

USER citus
RUN git clone -b $BRANCH https://github.com/citusdata/citus.git /citus

WORKDIR /citus
RUN ./configure
RUN make

USER root
RUN make install
