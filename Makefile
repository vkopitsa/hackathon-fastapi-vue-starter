# Makefile for Docker commands based on provided bash scripts

# Variables
DOMAIN := backend
SMTP_HOST :=
TAG ?= Variable not set
FRONTEND_ENV := production

# Default goal
.DEFAULT_GOAL := help

# Clean up the environment
clean: ## Clean up files and Docker volumes
	docker-compose down -v --remove-orphans
	rm -rf .pytest_cache .mypy_cache .coverage
	if [ $(uname -s) = "Linux" ]; then \
		sudo find . -type d -name __pycache__ -exec rm -r {} \+; \
	fi

# Build and run the Docker environment
build-run: ## Build and run Docker containers
	docker-compose -f docker-compose.yml build
	docker-compose -f docker-compose.yml up -d
	docker-compose -f docker-compose.yml exec -T backend-test make test

# Down the Docker environment
down: ## Take down Docker containers
	docker-compose -f docker-compose.yml down -v --remove-orphans

# Push Docker images
push: ## Push Docker images
	TAG=$(TAG) \
	FRONTEND_ENV=$(FRONTEND_ENV) \
	docker-compose -f docker-compose.yml push

# Build Docker images
build: ## Build Docker images
	TAG=$(TAG) \
	FRONTEND_ENV=$(FRONTEND_ENV) \
	docker-compose -f docker-compose.yml build

initial-data: ## Initial db data
	docker-compose -f docker-compose.yml exec backend make prestart

deploy: ## Deploy
	docker-compose -f docker-compose.yml build base
	docker-compose -f docker-compose.yml up -d --build backend
	docker-compose -f docker-compose.yml up -d --build celeryworker
	docker-compose -f docker-compose.yml up -d --build frontend

migrate: ## Upgrade Migrates
	docker-compose -f docker-compose.yml build base
	docker-compose -f docker-compose.yml up -d --build backend-alembic

# Absolutely awesome: https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help