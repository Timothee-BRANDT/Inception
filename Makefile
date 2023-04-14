#!/bin/bash

all: volumes
	@docker-compose -f srcs/docker-compose.yml --env-file srcs/.env up -d

build: volumes
	@docker-compose -f srcs/docker-compose.yml --env-file srcs/.env up -d --build

stop: 
	@docker-compose -f srcs/docker-compose.yml --env-file srcs/.env stop

down:
	@docker-compose -f srcs/docker-compose.yml --env-file srcs/.env down

fclean:
	@docker stop $$(docker ps --all --quiet)
	@docker system prune --all --force --volumes

re:	fclean all

.PHONY:	all build volumes stop down fclean re
