FROM postgres:9.4
MAINTAINER Alex Komrakov <alexkomrakov@gmail.com>

ENV LANG en_US.utf8
ENV POSTGIS_LOCALE_PREFIX en_US
RUN localedef -i $POSTGIS_LOCALE_PREFIX -c -f UTF-8 -A /usr/share/locale/locale.alias $POSTGIS_LOCALE

ENV POSTGIS_MAJOR 2.2
ENV POSTGIS_VERSION 2.2.2+dfsg-1.pgdg80+1

RUN apt-get update \
      && apt-get install -y --no-install-recommends \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
           postgis=$POSTGIS_VERSION \
      && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d/postgis.sh
