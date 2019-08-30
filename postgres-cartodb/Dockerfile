FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y -q apt-utils software-properties-common locales && \
    dpkg-reconfigure locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

RUN apt-get install -y make pkg-config git curl

RUN add-apt-repository ppa:cartodb/postgresql-10 && \
    apt-get update && \
    apt-get install -y postgresql-10 postgresql-plpython-10 postgresql-server-dev-10

RUN git clone https://github.com/CartoDB/cartodb-postgresql.git && \
    cd cartodb-postgresql && \
    make all install

RUN add-apt-repository ppa:cartodb/gis && \
    apt-get update

RUN apt-get install -y gdal-bin libgdal-dev postgis

RUN set -ex && \
    echo "listen_addresses='*'" >> /etc/postgresql/10/main/postgresql.conf && \
    echo "local     all       all                     trust" >  /etc/postgresql/10/main/pg_hba.conf && \
    echo "host      all       all       0.0.0.0/0     trust" >> /etc/postgresql/10/main/pg_hba.conf && \
    echo "host      all       all       ::1/128       trust" >> /etc/postgresql/10/main/pg_hba.conf && \
    /etc/init.d/postgresql start && \
    # createdb template_postgis -U postgres && \
    createuser publicuser --no-createrole --no-createdb --no-superuser -U postgres && \
    createuser tileuser --no-createrole --no-createdb --no-superuser -U postgres && \
    createdb -T template0 -O postgres -U postgres -E UTF8 template_postgis && \
    psql -c "CREATE EXTENSION postgis;CREATE EXTENSION postgis_topology;" template_postgis -U postgres && \
    /etc/init.d/postgresql stop

CMD /etc/init.d/postgresql start && tail -f /var/log/postgresql/postgresql-10-main.log
