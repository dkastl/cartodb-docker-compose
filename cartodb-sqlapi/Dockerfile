FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y -q apt-utils software-properties-common locales && \
    dpkg-reconfigure locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

RUN apt-get install -y make pkg-config git curl

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN apt-get install -y nodejs

RUN apt-get install -y libpixman-1-0 libpixman-1-dev libcairo2-dev \
    libjpeg-dev libgif-dev libpango1.0-dev

RUN git clone git://github.com/CartoDB/CartoDB-SQL-API.git && \
    cd CartoDB-SQL-API && \
    npm install

WORKDIR /CartoDB-SQL-API

COPY development.js config/environments/development.js

CMD node app.js development
