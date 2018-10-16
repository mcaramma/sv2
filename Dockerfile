FROM ubuntu:bionic

# ------- Preparation ------------------------------

ENV DEBIAN_FRONTEND=noninteractive \
    SRC_FOLDER=/usr/local/src \
    ZONE_INFO=America/Bogota

RUN apt-get update \
    && apt-get -y install build-essential git tar wget curl tzdata lsof net-tools htop atop glances iotop dstat sysstat procps tcpdump \
    && ln -fs /usr/share/zoneinfo/${ZONE_INFO} /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && mkdir -p ${SRC_FOLDER} /docker-entrypoint-initdb.d

# ------- AgensGraph ------------------------------

ENV AG_VERSION master

RUN useradd -m -c "AgensGraph User" -U agens -p agens \
    && mkdir -p /home/agens/AgensGraph/data \
    && mkdir -p /home/agens/.keras \
    && touch /home/agens/.keras/keras.json \
    && chown -R agens:agens /home/agens \
    && chmod -R 700 /home/agens

ENV AGDATA=/home/agens/AgensGraph/data \
    PATH=/home/agens/AgensGraph/bin:$PATH \
    LD_LIBRARY_PATH=/home/agens/AgensGraph/lib:$LD_LIBRARY_PATH \
    AGHOME=/home/agens/AgensGraph

RUN apt-get -y install \
        libreadline-dev \
        zlib1g-dev \
        bison \
        flex \
        uuid \
        openssl \
        libnss3 \
        libssl-dev \
        libperl-dev \
        libossp-uuid-dev \
        libkeyutils-dev \
        libldap2-dev \
        libxslt1-dev \
        libxml2-dev \
        libc++-dev \
        libc++abi-dev \
        icu-devtools \
        libicu-dev \
        krb5-config \
        krb5-locales \
        libgssapi-krb5-2 \
        libpam0g-dev \
        libkrb5-dev \
        libpam-krb5 \
        krb5-k5tls \
        krb5-sync-plugin \
        krb5-sync-tools \
        pgtop \
        tcl \
        tcl-dev \
        python \
        python-dev \
        python-pip \
        python-setuptools \
    && pip install \
        sqlalchemy-fdw \
        'scikit-learn[alldeps]' \
        tensorflow \
        pandas \
        pillow \
        h5py \
        keras \
    && cd ${SRC_FOLDER} \
    && git clone https://github.com/bitnine-oss/agensgraph.git \
    && cd agensgraph \
    && git checkout ${AG_VERSION} \
    && ./configure --prefix=$AGHOME \
                   --enable-thread-safety \
                   --with-pam \
                   --with-ldap \
                   --with-gssapi \
                   --with-openssl \
                   --with-krb-srvnam=POSTGRES \
                   --with-uuid=ossp \
                   --with-libxslt \
                   --with-libxml \
                   --with-python \
                   --with-perl \
                   --with-tcl \
                   --with-icu \
    && make install-world \
    && cd ${SRC_FOLDER} \
    && wget -c https://github.com/lesovsky/pgcenter/releases/download/v0.5.0/pgcenter.linux-amd64.tar.gz \
    && tar zxvf pgcenter.linux-amd64.tar.gz \
    && rm pgcenter.linux-amd64.tar.gz \
    && mv pgcenter /usr/bin \
    && pip install pgxnclient \
    && pgxn install multicorn \
    && pgxn install plv8 \
    && pgxn install acl \
    && pgxn install icu_ext \
    && sed -r -i "s/[#]*\s*(listen_addresses)\s*=\s*'(.*)'/\1 = '\*'/" $AGHOME/share/postgresql/postgresql.conf.sample \
    && echo "host    all     all      0.0.0.0/0     md5" >> $AGHOME/share/postgresql/pg_hba.conf.sample \
    && echo "host    all     all      ::1/128       md5" >> $AGHOME/share/postgresql/pg_hba.conf.sample \
    && echo '{"floatx":"float32","epsilon":1e-07,"backend": "tensorflow","image_data_format": "channels_last"}' > $AGHOME/../.keras/keras.json

RUN mkdir -p /home/agens/scripts
ADD entrypoint.sh /home/agens/scripts
RUN chmod +x /home/agens/scripts/entrypoint.sh

# ------------- pg_cron ----------------------------

RUN cd ${SRC_FOLDER} \
    && git clone https://github.com/citusdata/pg_cron.git \
    && cd pg_cron \
    && make \
    && make install

# ------------- PL/R -------------------------------

# TODO install more r-cran-* packages
RUN apt-get -y install r-base r-base-dev r-cran-date r-cran-matrixstats \
    && cd ${SRC_FOLDER} \
    && git clone https://github.com/postgres-plr/plr \
    && cd plr \
    && USE_PGXS=1 make \
    && USE_PGXS=1 make install

# -------- PL/Lua NG+JIT ---------------------------

# TODO install luarocks + packages
ENV LUA_VERSION 5.3

RUN apt-get -y install lua${LUA_VERSION} liblua${LUA_VERSION}-dev \
    && cd ${SRC_FOLDER} \
    && git clone http://luajit.org/git/luajit-2.0.git \
    && cd luajit-2.0 \
    && git checkout v2.1 \
    && make install \
    && cd ${SRC_FOLDER} \
    && git clone https://github.com/pllua/pllua-ng.git \
    && cd pllua-ng \
    && git checkout master \
    && make \
        LUA_INCDIR=/usr/include/lua${LUA_VERSION} \
        LUAJIT=/usr/local/bin/luajit \
        LUALIB="-llua${LUA_VERSION}" \
        LUAC=luac${LUA_VERSION} \
        LUA=lua${LUA_VERSION} \
        install

# --------- PostGIS --------------------------------

ENV POSTGIS_VERSION 2.5.0

RUN apt-get -y install libxml2-dev libgeos-dev libgdal-dev libproj-dev \
    && cd ${SRC_FOLDER} \
    && wget -c https://download.osgeo.org/postgis/source/postgis-${POSTGIS_VERSION}.tar.gz \
    && tar zxvf postgis-${POSTGIS_VERSION}.tar.gz \
    && cd postgis-${POSTGIS_VERSION} \
    && ./configure \
    && make \
    && make install

COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d/postgis.sh
COPY ./update-postgis.sh /usr/local/bin

# ------- TimescaleDB -----------------------------

ENV TIMESCALEDB_VERSION 0.12.1

RUN apt-get -y install ca-certificates openssl cmake libldap-2.4 \
    && cd ${SRC_FOLDER} \
    && git clone https://github.com/timescale/timescaledb.git \
    && cd timescaledb \
    && git checkout ${TIMESCALEDB_VERSION} \
    && ./bootstrap -DPROJECT_INSTALL_METHOD="docker" \
    && cd build \
    && make install \
    && sed -r -i "s/[#]*\s*(shared_preload_libraries)\s*=\s*'(.*)'/\1 = 'timescaledb,\2'/;s/,'/'/" $AGHOME/share/postgresql/postgresql.conf.sample

COPY docker-entrypoint-initdb.d/reenable_auth.sh /docker-entrypoint-initdb.d/

# ------- Citus Data -------------------------------

ENV CITUS_VERSION v7.5.1

RUN apt-get -y install autoconf automake \
    && cd ${SRC_FOLDER} \
    && git clone https://github.com/citusdata/citus.git \
    && cd citus \
    && git checkout $CITUS_VERSION \
    && ./configure --without-libcurl \
    && make install \
    && sed -r -i "s/[#]*\s*(shared_preload_libraries)\s*=\s*'(.*)'/\1 = 'citus,\2'/;s/,'/'/" $AGHOME/share/postgresql/postgresql.conf.sample

# ------- ZomboDB ---------------------------------

RUN cd ${SRC_FOLDER} \
    && git clone https://github.com/zombodb/zombodb.git \
    && cd zombodb \
    && make clean install

# ------- EdgeDB ----------------------------------

ENV EDB_VERSION master

RUN apt-get -y install \
        tk-dev \
        libbz2-dev \
        libssl-dev \
        libpng-dev \
        libsqlite3-dev \
        libfreetype6-dev \
        python3.6 \
        python3.6-dev \
        python3-pip \
        python3-distutils \
        python3-setuptools \
    && pip3 install \
        click \
        promise \
        asyncpg \
        Parsing \
        pygments \
        setproctitle \
        graphql-core \
        'typing_inspect~=0.3.1' \
        'prompt_toolkit>=1.0.15,<2.0.0' \
    && cd ${SRC_FOLDER} \
    && git clone https://github.com/edgedb/edgedb.git \
    && cd edgedb \
    && git checkout ${EDB_VERSION} \
    && rm -rf postgres \
    && python3 setup.py install \
    && cd ext \
    && make \
    && make install \
    && chown -R agens /usr/local/lib/python3.*/dist-packages/edgedb_server-*.egg

# --------- Clean-up -------------------------------

RUN rm -rf ${SRC_FOLDER}/* \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# --------- entrypoint/database setup --------------

USER agens
EXPOSE 5432 5656

RUN set -e;\
    initdb;\
	ag_ctl start; sleep 5;\
	createdb;\
	agens -c "create graph agens_graph";\
    agens -c "ALTER USER agens PASSWORD 'agens'";\
    ag_ctl stop

ENTRYPOINT ["/home/agens/scripts/entrypoint.sh"]
