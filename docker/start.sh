#!/usr/bin/env bash

# Exportar variables para poder utilizarlas con docker-compose
export APP_PORT=${APP_PORT:-8080}
export APP_ENV=${APP_ENV:-local}
export DB_PORT=${DB_PORT:-3306}
export DB_ROOT_PASSWORD=${DB_ROOT_PASSWORD:-root}
export DB_NAME=${DB_NAME:-default}
export DB_USER=${DB_USER:-default}
export DB_PASSWORD=${DB_PASSWORD:-secret}

COMPOSE="docker-compose"

# Verificamos si estamos enviando argumentos
if [ $# -gt 0 ]; then
  #Guardamos el nombre del proyecto
  path="$1"
  # Verificamos que el segundo argumento no este vacio
  if [ -n "$2" ]; then
    # Ejecutar comandos de artisan
    if [ "$2" == "artisan" ]; then
        # Ignora el primer argumento
        shift 2
        $COMPOSE run --rm \
            -w /var/www/html/"$path" \
            php \
            php artisan "$@"
    # Ejecutar tareas de composer
    elif [ "$2" == "composer" ]; then
        # Ignora el primer argumento
        shift 2
        $COMPOSE run --rm \
            -w /var/www/html/"$path" \
            php \
            composer "$@"
    # Ejecutar tareas de node
    elif [ "$2" == "node" ]; then
        port="$3"
        # Ignora el primer argumento
        shift 3
        $COMPOSE run --rm \
            -w /var/www/html/"$path" \
            -p "$port" \
            -p 3443:3443 \
            -p 4443:4443 \
            node \
            "$@"
    # Ejecutar pruebas de phpunit
    elif [ "$2" == "test" ]; then
        # Ignora el primer argumento
        shift 2
        $COMPOSE run --rm \
            -w /var/www/html/"$path" \
            php \
            ./vendor/bin/phpunit "$@"
    fi
  else
     # Si los argumentos son diferentes se pasarán a docker-compose
     $COMPOSE "$@"
  fi
else
    # Si no se indica ningún parámetro se mostrarán los contenedores
    docker-compose ps
fi