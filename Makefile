#!make
include .env
export $(shell sed 's/=.*//' .env)

composer-install:
	cd webroot && docker-compose -f docker-compose-makefile.yml run main composer install

composer-dump-autoload:
	cd webroot && docker-compose -f docker-compose-makefile.yml run main composer dump-autoload

composer-require:
	cd webroot && docker-compose -f docker-compose-makefile.yml run main composer require ${PACKAGE}

bash:
	docker exec -it rossmoney_me_frankenphp bash

frankenphp-install:
	./frankenphp-install.sh

build:
	docker build -t rossmoney_me_frankenphp .

run:
	docker stop rossmoney_me_frankenphp && docker rm rossmoney_me_frankenphp && docker run --platform=linux/amd64 --name rossmoney_me_frankenphp -d -e RESOLVE_ROOT_SYMLINK=${RESOLVE_ROOT_SYMLINK} -e STARTUP=${STARTUP} -e SERVER_PORT=${SERVER_PORT} -e SERVER_NAME=${SERVER_NAME} -v ./:/home/container -p ${SERVER_PORT}:${SERVER_PORT} ghcr.io/rossmoney/pterodactyl-frankenphp:main

run-sail:
	cd webroot && ./vendor/bin/sail up -d

open:
	open http://localhost:${SERVER_PORT}