FROM ruby:2.7.8-bullseye

SHELL ["/bin/bash", "--login", "-c"]

RUN apt-get update && apt-get install -y \
  wget \
  curl \
  telnet \
  vim

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# NODE.JS
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

ENV NVM_DIR="/opt/.nvm"
RUN mkdir /opt/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
RUN nvm install 18.12.1

# Update NPM and Yarn versions
RUN npm install -g npm@9.6.0
RUN npm install yarn -g
RUN yarn set version berry

# source /opt/.nvm/nvm.sh

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# RAILS
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

RUN gem install rails -v 6.1.7.4 --no-document
RUN gem install rails -v 7.0.6   --no-document

RUN gem install pg      -v 1.5.3 --no-document
RUN gem install mysql2  -v 0.5.5 --no-document
RUN gem install sqlite3 -v 1.6.3 --no-document

RUN gem install bundler -v 2.4.15 --no-document

RUN mkdir /home/the_role_dev
RUN mkdir /home/the_role_dev/rails-versions
WORKDIR /home/the_role_dev/rails-versions

RUN /usr/local/bundle/bin/rails _6.1.7.4_ new rails6-psql   --minimal -d postgresql
RUN /usr/local/bundle/bin/rails _6.1.7.4_ new rails6-mysql  --minimal -d mysql
RUN /usr/local/bundle/bin/rails _6.1.7.4_ new rails6-sqlite --minimal -d sqlite3

RUN /usr/local/bundle/bin/rails _7.0.6_ new rails7-psql   --minimal -d postgresql
RUN /usr/local/bundle/bin/rails _7.0.6_ new rails7-mysql  --minimal -d mysql
RUN /usr/local/bundle/bin/rails _7.0.6_ new rails7-sqlite --minimal -d sqlite3

WORKDIR /home/the_role_dev
