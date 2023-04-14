#!/bin/bash

all:
	@docker-compose -f srcs/docker-compose.yml --env-file srcs/.env up -d

build:
	@docker-compose -f srcs/docker-compose.yml --env-file srcs/.env up -d --build

stop: 
	@docker-compose -f srcs/docker-compose.yml --env-file srcs/.env stop

down:
	@docker-compose -f srcs/docker-compose.yml --env-file srcs/.env down

fclean:
	@docker stop $$(docker ps --all --quiet)
	@docker system prune --all --force

re:	fclean all

.PHONY:	all build stop down fclean re
