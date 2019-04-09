# Toma como base la imagen nginx:alpine
FROM nginx:alpine

# Nos da a conocer quien mantendrá la imagen
LABEL MAINTAINER="Miguel Ortiz"

# Copiamos el archivo de configuracion nginx.conf
COPY nginx.conf /etc/nginx/

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash \
    && adduser -D -H -u 1000 -s /bin/bash www-data

ARG PHP_UPSTREAM_CONTAINER=php
ARG PHP_UPSTREAM_PORT=9000

# Set upstream conf and remove the default conf
RUN echo "upstream php-upstream { server ${PHP_UPSTREAM_CONTAINER}:${PHP_UPSTREAM_PORT}; }" > /etc/nginx/conf.d/upstream.conf \
    && rm /etc/nginx/conf.d/default.conf

# Expone el puerto 80 para la comunicación entre contenedores
ARG NGINX_PORT_EXPOSE=80
ARG NGINX_HOST_HTTPS_EXPOSE=443
EXPOSE ${NGINX_PORT_EXPOSE} ${NGINX_HOST_HTTPS_EXPOSE}

# Ejecuta el comando nginx
CMD ["nginx"]
