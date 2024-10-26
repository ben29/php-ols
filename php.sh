#!/usr/bin/env bash

./configure \
  --build=x86_64-linux-gnu \
  --datadir=${prefix}/share/php/8.3 \
  --disable-all \
  --disable-debug \
  --disable-dtrace \
  --disable-rpath \
  --disable-static \
  --enable-bcmath \
  --enable-calendar \
  --enable-cgi \
  --enable-cli \
  --enable-dom \
  --enable-exif \
  --enable-fileinfo \
  --enable-filter \
  --enable-ftp \
  --enable-gd \
  --enable-intl=shared \
  --enable-mbregex \
  --enable-mbstring \
  --enable-mysqlnd \
  --enable-mysqlnd-compression-support \
  --enable-pcntl \
  --enable-phar \
  --enable-posix \
  --enable-session \
  --enable-simplexml \
  --enable-soap \
  --enable-sockets \
  --enable-sysvmsg \
  --enable-sysvsem \
  --enable-sysvshm \
  --enable-tokenizer \
  --enable-xml \
  --enable-xmlreader \
  --enable-xmlwriter \
  --host=x86_64-linux-gnu \
  --libdir=${prefix}/lib/php \
  --libexecdir=${prefix}/lib/php \
  --prefix=/usr/local/lsws/lsphp83 \
  --program-suffix=8.3 \
  --with-curl=shared,/usr \
  --with-freetype \
  --with-gettext \
  --with-gmp \
  --with-iconv \
  --with-imap=shared,/usr \
  --with-imap-ssl=yes \
  --with-jpeg \
  --with-kerberos \
  --with-ldap=shared,/usr \
  --with-ldap-sasl=/usr \
  --with-libedit \
  --with-libxml \
  --with-mhash=yes \
  --with-mysql-sock=/var/run/mysqld/mysqld.sock \
  --with-mysqli=shared,mysqlnd \
  --with-password-argon2 \
  --with-pdo-mysql=shared,mysqlnd \
  --with-pdo-pgsql=shared,/usr \
  --with-pdo-sqlite=shared,/usr \
  --with-pspell=shared,/usr \
  --with-pgsql=shared,/usr \
  --with-sodium \
  --with-tidy=shared,/usr \
  --with-xsl \
  --with-xpm \
  --with-zip \
  --with-layout=GNU \
  --with-pic \
  --without-pear \
  CFLAGS="-g -O2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -ffile-prefix-map=/build/php8.3-8.3.10=. -flto=auto -ffat-lto-objects -fstack-protector-strong -fstack-clash-protection -Wformat -Werror=format-security -fcf-protection -fdebug-prefix-map=/build/php8.3-8.3.10=/usr/src/php8.3-8.3.10-1+noble -O2 -Wall -fsigned-char -fno-strict-aliasing -fno-lto -g" \
  build_alias=x86_64-linux-gnu \
  host_alias=x86_64-linux-gnu