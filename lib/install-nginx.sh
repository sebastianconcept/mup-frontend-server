#!/bin/sh
set -e

BUILD_DIR=/tmp/nginx
NGINX_VERSION=1.9.4
PREFIX=/opt/nginx
NGINX_USER=nginx

# creating a non-privileged user
useradd $NGINX_USER || :

# install dependencies
apt-get update
#apt-get -y install libpcre3-dev libssl-dev build-essential wget
apt-get -y install openssl build-essential zlib1g-dev libpcre3 libpcre3-dev libbz2-dev libssl-dev tar unzip wget


# start building process

rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR
mkdir -p $PREFIX
cd $BUILD_DIR

# download nginx
wget http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz
tar xvzf nginx-$NGINX_VERSION.tar.gz

# building
cd nginx-$NGINX_VERSION
./configure \
  --prefix=$PREFIX --user=$NGINX_USER --group=$NGINX_USER \
  --with-http_ssl_module --without-http_scgi_module \
  --without-http_uwsgi_module --without-http_fastcgi_module \
  --without-http_memcached_module \
  --with-http_gzip_static_module

make -j8 install

# remove build specific libraries
apt-get -y remove build-essential wget
apt-get -y autoremove

# Generate fresh DH parameters
openssl dhparam -out /dhparam.pem 2048
