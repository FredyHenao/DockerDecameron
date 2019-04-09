# Toma como base la imagen ubunu:16.04
FROM ubuntu:16.04

# Nos da a conocer quien mantendrá la imagen
LABEL MAINTAINER="Miguel Ortiz"

# Actualiza los repositorios (1)
# Instala locales UTF-8 (Para poder instalar php) (2-3)
RUN apt-get update \
  && apt-get install -y locales \
  && locale-gen en_US.UTF-8

# Se configura UTF-8 con las variables de entorno
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Instalacion de php
# Actualiza los repositorios (1)
# Instalación de paquetes necesarios (2-7)
# Agrega al repositorio de php (8)
# Instalación de php (9-20)
# Instalación de Composer (21)
# Crea la ruta de php (22)
# Desístala software-properties-common (23)
# Limpia los archivos generados durante la instalación (25-26)
RUN apt-get update \
  && apt-get install -y \
    curl \
    git \
    software-properties-common \
    unzip \
    zip \
  && add-apt-repository -y ppa:ondrej/php \
  && apt-get update \
  && apt-get install -y \
    php7.2-cli \
    php7.2-curl \
    php7.2-fpm \
    php7.2-gd \
    php7.2-imap \
    php7.2-mbstring \
    php7.2-mysql \
    php7.2-pgsql \
    php7.2-xml \
    php7.2-zip \
    php7.2-bcmath \
    php-memcached \
  && php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
  && mkdir /run/php \
  && apt-get remove -y --purge software-properties-common \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copia los archivos de configuración
COPY php.ini /etc/php/7.2/fpm/php.ini
COPY php-fpm.conf /etc/php/7.2/fpm/php-fpm.conf
COPY www.conf /etc/php/7.2/fpm/pool.d/www.conf

# Expone el puerto 9000 para la comunicación entre contenedores
EXPOSE 9000

# Ejecuta el comando php-fpm7.2
CMD ["php-fpm7.2"]
