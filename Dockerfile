FROM debian:12.11
# OTYyOWQ5
ARG OLS_VERSION=1.8.2
ARG PHP_VERSION=8.3.13

ENV DEPEND="wget ca-certificates procps g++ make pkg-config libxml2-dev libssl-dev zlib1g-dev openssl libcurl4-openssl-dev libpng-dev libonig-dev libsodium-dev libzip-dev"

COPY scripts/ /usr/local/src

RUN set -eux; \
    apt update && \
    apt install --no-install-recommends ${DEPEND} -y && \
    apt clean && rm -rf /var/lib/apt/lists/*; \
    cd /tmp; \
    wget -q https://openlitespeed.org/packages/openlitespeed-$OLS_VERSION.tgz; \
    tar xzf openlitespeed-$OLS_VERSION.tgz; \
    cd openlitespeed; \
    ./install.sh; \
    # Replace config
    cd ..; \
    wget -q https://www.php.net/distributions/php-${PHP_VERSION}.tar.gz; \
    tar zxf php-${PHP_VERSION}.tar.gz; \
    cd php-${PHP_VERSION}; \
    prefix="/usr/local/lsws/lsphp83"; \
    CFLAGS="-g -O2 -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -ffile-prefix-map=/build/php8.3-8.3.10=. -flto=auto -ffat-lto-objects -fstack-protector-strong -fstack-clash-protection -Wformat -Werror=format-security -fcf-protection -fdebug-prefix-map=/build/php8.3-8.3.10=/usr/src/php8.3-8.3.10-1+noble -O2 -Wall -fsigned-char -fno-strict-aliasing -fno-lto -g"; \
    ./configure \
        --prefix="${prefix}" \
        --with-mysqli=mysqlnd \
        --with-pdo-mysql=mysqlnd \
        --with-openssl \
        --with-iconv \
        --with-curl \
        --with-zlib \
        --with-libxml \
        --with-zip \
        --with-sodium \
        --enable-filter \
        --enable-ctype \
        --enable-xml \
        --enable-tokenizer \
        --enable-dom \
        --enable-simplexml \
        --enable-calendar \
        --enable-pdo \
        --enable-phar \
        --enable-session \
        --enable-mbstring \
        --enable-bcmath \
        --enable-exif \
        --enable-fileinfo \
        --enable-gd \
        --enable-intl \
        --enable-zts \
        --enable-ipv6 \
        --enable-fpm \
        --enable-litespeed \
        --disable-cgi \
        --disable-phpdbg \
        --disable-all; \
    make -j "$(nproc)"; \
    make -j "$(nproc)" install; \
    rm -rf /tmp/*; \
    ln -s /usr/local/lsws/lsphp83/bin/php /usr/bin/php; \
    ln -sf /usr/local/lsws/lsphp83/bin/lsphp /usr/local/lsws/fcgi-bin/lsphp8; \
    ln -sf /usr/local/lsws/fcgi-bin/lsphp8 /usr/local/lsws/fcgi-bin/lsphp; \
    mv /usr/local/src/docker.conf /usr/local/lsws/conf/templates/docker.conf; \
    mv /usr/local/src/httpd_config.xml /usr/local/lsws/conf/httpd_config.xml; \
    cp -RP /usr/local/src/httpd_config.conf /usr/local/lsws/conf/httpd_config.conf; \
    cp -RP /usr/local/lsws/conf/ /usr/local/lsws/.conf/; \
    mv /usr/local/src/htpasswd /usr/local/lsws/admin/conf/htpasswd; \
    mv /usr/local/src/entrypoint.sh /entrypoint.sh; \
    chown -R lsadm:lsadm /usr/local/lsws/admin/conf/htpasswd; \
    chmod 644 /usr/local/lsws/admin/conf/htpasswd; \
    chmod 755 /usr/local/lsws/admin/conf; \
    chmod +x /entrypoint.sh; \
    rm -rf /usr/local/src/*; \
    mkdir -p /var/www/html; \
    chown www-data:www-data /var/www -R; \
    wget -O /tmp/composer-setup.php https://getcomposer.org/installer; \
    php -n /tmp/composer-setup.php --install-dir=/usr/local/bin --quiet; \
    rm -rf /tmp/composer-setup.php;

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 7080 80 443

WORKDIR /var/www/html/