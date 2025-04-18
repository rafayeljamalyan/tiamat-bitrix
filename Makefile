.PHONY: up down build rebuild start stop restart logs app-logs db-logs shell db-shell clean help

# Default target
.DEFAULT_GOAL := help

# Variables
DOCKER_COMPOSE = docker compose
APP_CONTAINER = tiamat-app
DB_CONTAINER = tiamat-db


build: ## Rebuild the containers
	$(DOCKER_COMPOSE) build --no-cache

start: ## Start existing containers
	$(DOCKER_COMPOSE) up -d

stop: ## Stop running containers
	$(DOCKER_COMPOSE) down

restart: stop build start

app-logs: ## View app container logs
	$(DOCKER_COMPOSE) logs -f --tail 10 $(APP_CONTAINER)

db-logs: ## View database container logs
	$(DOCKER_COMPOSE) logs -f --tail 10 $(DB_CONTAINER)

app-shell: ## Access the app container shell
	$(DOCKER_COMPOSE) exec $(APP_CONTAINER) /bin/bash

db-shell: ## Access the MySQL shell
	$(DOCKER_COMPOSE) exec $(DB_CONTAINER) mysql -u$${MYSQL_USER:-tiamat_user} -p$${MYSQL_PASSWORD:-tiamat_password} $${MYSQL_DATABASE:-tiamat_db}

clean: ## Remove all containers, volumes, and images
	$(DOCKER_COMPOSE) down -v
	docker system prune -f

help: ## Display this help screen
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'
	