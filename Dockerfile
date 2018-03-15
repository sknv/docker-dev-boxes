FROM ubuntu:16.04

# TODO: Uncomment required dependencies.

# Install dependencies.
RUN apt-get update && apt-get install -y --no-install-recommends \
  apt-transport-https ca-certificates curl locales mc software-properties-common tzdata \
  # build-essential gettext \ # Required for Python.
  # build-essential git libreadline-dev libssl-dev zlib1g-dev \ # Required for Ruby.
&& apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* \
# Generate required locales.
&& locale-gen en_US.UTF-8 ru_RU.UTF-8 \
# Set the timezone.
&& echo Europe/Moscow > /etc/timezone \
&& ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime

# Set locales for Docker image.
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

# TODO: Uncomment required software.

##
# Install Go and set env variables.
##

# ENV GOROOT=/usr/local/go GOPATH=/home/docker/code
# ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin
# RUN GO_VERSION=1.10 \
# && curl -sL https://storage.googleapis.com/golang/go"$GO_VERSION".linux-amd64.tar.gz | tar -xz -C /usr/local

##
# Install Java.
##

# RUN JAVA_VERSION=9 \
# && echo "oracle-java$JAVA_VERSION-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections \
# && add-apt-repository ppa:webupd8team/java \
# && apt-get update && apt-get install -y --no-install-recommends oracle-java"$JAVA_VERSION"-set-default \
# && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

##
# Install MariaDB.
##

# RUN MARIADB_VERSION=10.2 \
# # Set MariaDB root password (USE FOR DEV MODE ONLY!).
# && debconf-set-selections <<< 'mysql-server mysql-server/root_password password docker' \
# && debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password docker' \
# # Install MariaDB.
# && apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 \
# && add-apt-repository "deb [arch=amd64,i386,ppc64el] https://mirror.mephi.ru/mariadb/repo/$MARIADB_VERSION/ubuntu xenial main" \
# && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends mariadb-server \
# && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

##
# Install MongoDB.
##

# ENV MONGODATA=/data/mongodb
# RUN MONGO_VERSION=3.6 \
# && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5 \
# && echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/$MONGO_VERSION multiverse" | tee /etc/apt/sources.list.d/mongodb-org-"$MONGO_VERSION".list \
# && apt-get update && apt-get install -y --no-install-recommends mongodb-org \
# && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* \
# # Create a folder for databases.
# && mkdir -p "$MONGODATA" && chown mongodb:mongodb "$MONGODATA" \
# # Start mongod for the current session and wait to ensure the service is running.
# && mongod --fork --dbpath "$MONGODATA" --logpath /var/log/mongodb/mongodb.log && sleep 10 \
# # Enable Mongo authentication (USE FOR DEV MODE ONLY!).
# && mongo admin --eval "db.createUser({ user: 'docker', pwd: 'docker', roles: [{ role: 'userAdminAnyDatabase', db: 'admin' }] })" \
# && sed -i 's/#security:/security:\n  authorization: enabled/g' /etc/mongod.conf \
# # Allow the remote connections (USE FOR DEV MODE ONLY!).
# && sed -i 's/  bindIp: 127.0.0.1/  bindIp: 0.0.0.0/g' /etc/mongod.conf \
# # Shutdown mongod.
# && mongod --shutdown --dbpath "$MONGODATA"

##
# Install NodeJS and set Npm permissions.
##

# RUN NODE_VERSION=8.x \
# && curl -sL https://deb.nodesource.com/setup_"$NODE_VERSION" | bash - \
# && apt-get update && apt-get install -y --no-install-recommends nodejs \
# && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* \
# # Update Npm.
# && npm install --global npm

##
# Install PHP.
##

# RUN PHP_VERSION=7.2 \
# && add-apt-repository ppa:ondrej/php \
# && apt-get update && apt-get install -y --no-install-recommends \
#   php"$PHP_VERSION" \
#   php"$PHP_VERSION"-mbstring php"$PHP_VERSION"-mysql php"$PHP_VERSION"-xml php"$PHP_VERSION"-zip \ # Laravel dependencies.
# && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* \
# # Install Composer.
# && curl -sL https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

##
# Install PostgreSQL.
##

# RUN POSTGRESQL_VERSION=10 \
# && echo 'deb https://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' | tee -a /etc/apt/sources.list.d/pgdg.list \
# && curl -sL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
# && apt-get update && apt-get install -y --no-install-recommends \
#   postgresql-"$POSTGRESQL_VERSION" postgresql-contrib-"$POSTGRESQL_VERSION" libpq-dev \
# && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* \
# # Start PostgreSQL for the current session and wait to ensure the service is running.
# && service postgresql start && sleep 10 \
# # Set 'postgres' user password (USE FOR DEV MODE ONLY!).
# && su - postgres -c "psql -c \"ALTER USER postgres WITH PASSWORD 'docker';\"" \
# # Allow external connections for PostgreSQL (USE FOR DEV MODE ONLY!).
# && echo 'host all all all md5' | tee -a /etc/postgresql/"$POSTGRESQL_VERSION"/main/pg_hba.conf \
# && sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/"$POSTGRESQL_VERSION"/main/postgresql.conf \
# # Stop the PostgreSQL server.
# && service postgresql stop

##
# Install Python3.
##

# RUN PYTHON_VERSION=3.6 \
# && add-apt-repository ppa:jonathonf/python-"$PYTHON_VERSION" \
# && apt-get update && apt-get install -y --no-install-recommends \
#   python"$PYTHON_VERSION" python"$PYTHON_VERSION"-dev \
# && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* \
# # Set Python3 aliases.
# && echo "alias python3=python$PYTHON_VERSION" | tee -a ~/.bash_aliases \
# # Install Pip3 (autoset Pip3 aliases).
# && curl -sL https://bootstrap.pypa.io/get-pip.py | python"$PYTHON_VERSION"

##
# Install Ruby, rbenv and ruby-build.
##

ENV RUBY_VERSION=2.5.0 PATH=$PATH:~/.rbenv/bin:~/.rbenv/plugins/ruby-build/bin
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv \
&& git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build \
&& echo 'eval "$(rbenv init -)"' | tee -a ~/.bashrc | tee -a ~/.profile \
# Disable ruby docs.
&& echo 'gem: --no-document' | tee -a ~/.gemrc
# Install ruby and Bundler.
RUN /bin/bash -cl "rbenv install $RUBY_VERSION && rbenv global $RUBY_VERSION && gem install bundler && rbenv rehash"

# Set working directory.
WORKDIR /home/docker

# Default command to execute when container starts.
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
