# vim:set ft=dockerfile:
FROM debian:7.8

MAINTAINER Joan Llopis "jllopisg@gmail.com"
ENV DEBIAN_FRONTEND noninteractive

RUN deps='curl unzip apache2 php5 php5-mysql php5-ldap php5-mcrypt php5-cli php-soap php5-json graphviz'; \
    apt-get update -q \
    && apt-get install -qy $deps --no-install-recommends \
    && mkdir /tmp/itop \
    && cd /tmp/itop \
    && curl -kL -o itop.zip http://downloads.sourceforge.net/project/itop/itop/2.1.0/iTop-2.1.0-2127.zip \
    && rm /var/www/index.html \
    && unzip itop.zip \
    && mv web/* /var/www \
    && cd /var/www \
    && rm -rf /tmp/itop \
    && mkdir conf data env-production log \
    && chown www-data:www-data conf data env-production log

COPY itop-entrypoint.sh /

VOLUME ["/var/www/conf", "/var/www/data", "/var/www/env-production", "/var/www/log"]

ENTRYPOINT ["/itop-entrypoint.sh"]

EXPOSE 443
CMD ["itop"]

# docker build -t jllopis/itop:2.1.0 .
