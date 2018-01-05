FROM ubuntu:16.04

RUN export DEBIAN_FRONTEND=noninteractive \

##
# Set software versions.
##

# GO_VERSION='1.9.2' \
# JAVA_VERSION='9' \
# MARIADB_VERSION='10.2' \
# MONGO_VERSION='3.6' \
# NODE_VERSION='8.x' \
# PHP_VERSION='7.2' \
# POSTGRESQL_VERSION='10' \
# PYTHON_VERSION='3.6' \
# RUBY_VERSION='2.5.0' \

# Install dependencies.
# && apt-get update -qq \
# && apt-get install -y --no-install-recommends \
#   apt-transport-https curl locales tzdata \
#   # software-properties-common \ # Required for Java, MariaDB, PHP, Python.
#   # debconf-utils \ # Required for Java.
#   # build-essential gettext \ # Required for Python.

# Generate required locales.
# && locale-gen ru_RU.UTF-8 en_US.UTF-8 \

# Set timezone.
# && echo Europe/Moscow > /etc/timezone \
# && ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime

# Set locales.
# ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# RUN echo 'Installing required software...' \





# Uncomment required software...

##
# Install Git.
##

# && apt-get install -y --no-install-recommends git \

##
# Install Go and set env variables.
##

# && curl -sL https://storage.googleapis.com/golang/go"$GO_VERSION".linux-amd64.tar.gz | \
#   tar -xz -C /usr/local \
# && echo 'export GOROOT=/usr/local/go' | tee -a ~/.profile \
# && echo 'export GOPATH=/home/docker/code' | tee -a ~/.profile \
# && echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' | tee -a ~/.profile \
# && source ~/.profile \

##
# Install Java.
##

# && add-apt-repository ppa:webupd8team/java \
# && apt-get update -qq \
# && echo 'oracle-java8-installer shared/accepted-oracle-license-v1-1 select true' | \
#   debconf-set-selections \
# && apt-get install -y --no-install-recommends oracle-java"$JAVA_VERSION"-installer \

##
# Install MariaDB.
##

# # Set MariaDB root password (USE FOR DEV MODE ONLY!).
# && debconf-set-selections <<< \
#   'mysql-server mysql-server/root_password password docker' \
# && debconf-set-selections <<< \
#   'mysql-server mysql-server/root_password_again password docker' \

# # Install MariaDB.
# && apt-key adv \
#   --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 \
# && add-apt-repository \
#   "deb [arch=amd64,i386,ppc64el] http://mirror.mephi.ru/mariadb/repo/$MARIADB_VERSION/ubuntu xenial main" \
# && apt-get update -qq \
# && apt-get install -y --no-install-recommends mariadb-server \

##
# Install MongoDB.
##

# && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
#   --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5 \
# && echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/$MONGO_VERSION multiverse" | \
#   tee /etc/apt/sources.list.d/mongodb-org-"$MONGO_VERSION".list \
# && apt-get update -qq \
# && apt-get install -y --no-install-recommends mongodb-org \

# Create a folder for databases.
# && mkdir -p /data/db \

# # Start mongod for the current session and wait 10 seconds to ensure the service is running.
# && mongod --fork --logpath /var/log/mongodb/mongodb.log \
# && sleep 10 \

# # Enable Mongo authentication (USE FOR DEV MODE ONLY!).
# && mongo admin \
#   --eval "db.createUser({ user: 'docker', pwd: 'docker', roles: [{ role: 'userAdminAnyDatabase', db: 'admin' }] })" \
# && sed -i 's/#security:/security:\n  authorization: enabled/g' \
#   /etc/mongod.conf \

# # Allow the remote connections (USE FOR DEV MODE ONLY!).
# && sed -i 's/  bindIp: 127.0.0.1/  bindIp: 0.0.0.0/g' /etc/mongod.conf \

# # Restart mongod to enable auth and start the service automatically at boot.
# && mongod --shutdown \

##
# Install NodeJS and set Npm permissions.
##

# && curl -sL https://deb.nodesource.com/setup_"$NODE_VERSION" | bash - \
# && apt-get install -y --no-install-recommends nodejs \
# && mkdir ~/.npm-global \
# && npm config set prefix '~/.npm-global' \
# && echo 'export PATH=$PATH:~/.npm-global/bin' | tee -a ~/.profile \
# && source ~/.profile \

# # Update Npm.
# && npm install --global npm \

##
# Install PHP.
##

# && add-apt-repository ppa:ondrej/php \
# && apt-get update -qq \
# && apt-get install -y --no-install-recommends \
#   php"$PHP_VERSION" \
#   php"$PHP_VERSION"-mbstring php"$PHP_VERSION"-mysql \
#   php"$PHP_VERSION"-xml php"$PHP_VERSION"-zip # Laravel dependencies. \

# # Install Composer.
# && curl -sL https://getcomposer.org/installer | \
#   php -- --install-dir=/usr/local/bin --filename=composer \

##
# Install PostgreSQL.
##

# && echo 'deb https://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' | \
#   tee -a /etc/apt/sources.list.d/pgdg.list \
# && curl -sL https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
#   apt-key add - \
# && apt-get update -qq \
# && apt-get install -y --no-install-recommends \
#   postgresql-"$POSTGRESQL_VERSION" postgresql-contrib-"$POSTGRESQL_VERSION" \
#   libpq-dev \

# # Set 'postgres' user password (USE FOR DEV MODE ONLY!).
# && su - postgres psql -c "ALTER USER postgres WITH PASSWORD 'docker';" \

# # Allow external connections for PostgreSQL (USE FOR DEV MODE ONLY!).
# && echo 'host all all all md5' | \
#   tee -a /etc/postgresql/"$POSTGRESQL_VERSION"/main/pg_hba.conf \
# && sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" \
#   /etc/postgresql/"$POSTGRESQL_VERSION"/main/postgresql.conf \

# # Restart the PostgreSQL server for the changes to take effect.
# && service postgresql restart \

##
# Install Python3.
##

# && add-apt-repository ppa:jonathonf/python-"$PYTHON_VERSION" \
# && apt-get update -qq \
# && apt-get install -y --no-install-recommends \
#   python"$PYTHON_VERSION" python"$PYTHON_VERSION"-dev \

# # Set Python3 aliases.
# && echo "alias python3=python$PYTHON_VERSION" | tee -a ~/.bash_aliases \
# && source ~/.bash_aliases \

# # Install Pip3 (autoset Pip3 aliases).
# && curl -sL https://bootstrap.pypa.io/get-pip.py | python"$PYTHON_VERSION" \

# # Install virtualenv.
# && pip3 install virtualenv \

##
# Install Ruby.
##

# # Install rbenv.
# && git clone https://github.com/rbenv/rbenv.git ~/.rbenv \
# && echo 'export PATH=$PATH:~/.rbenv/bin' | tee -a ~/.profile \
# && echo 'eval "$(rbenv init -)"' | tee -a ~/.profile \
# && source ~/.profile \

# # Install ruby-build.
# && git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build \
# && echo 'export PATH=$PATH:~/.rbenv/plugins/ruby-build/bin' | \
#   tee -a ~/.profile \
# && source ~/.profile \

# # Install ruby.
# && rbenv install "$RUBY_VERSION" \
# && rbenv global "$RUBY_VERSION" \

# # Disable ruby docs.
# && echo 'gem: --no-document' | tee -a ~/.gemrc \

# # Install Bundler.
# && gem install bundler \
# && rbenv rehash \

&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set working directory.
WORKDIR /home/docker

# Default command.
COPY docker-entrypoint.sh /usr/local/bin/
# RUN chmod +x /home/docker-entrypoint.sh
ENTRYPOINT ['docker-entrypoint.sh']
