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

RUN apt-add-repository ppa:brightbox/ruby-ng && \
    apt-get update && \
    apt-get install -y ruby2.4 ruby2.4-dev ruby-bundler && \
    gem install compass

RUN apt-get install -y python-pip imagemagick unp zip libicu-dev libpq-dev && \
    git clone --recursive https://github.com/CartoDB/cartodb.git

WORKDIR /cartodb

RUN RAILS_ENV=development bundle install

RUN add-apt-repository -y ppa:ubuntugis/ppa && \
    apt-get update && \
    apt-get install -y libgdal-dev gdal-bin python-gdal postgresql-client tzdata
ENV CPLUS_INCLUDE_PATH /usr/include/gdal
ENV C_INCLUDE_PATH /usr/include/gdal
ENV PATH $PATH:/usr/include/gdal

RUN perl -pi -e 's/gdal==1\.10\.0/gdal==2.2.2/' python_requirements.txt && \
    pip install --no-use-wheel -r python_requirements.txt

COPY app_config.yml config/app_config.yml

RUN npm install && \
    sed 's/localhost/postgres/g' config/database.yml.sample > config/database.yml

ADD ./start.sh /opt/start.sh

CMD /bin/bash /opt/start.sh
