# Makefile for managing Python code formatting, testing, and Docker operations

# Install Python dependencies
install:
	pip install -r requirements-dev.txt

# Clean up the environment
clean: ## Clean up files and remove coverage reports
	rm -rf .pytest_cache .mypy_cache .coverage

# Format code
format: ## Format code using autoflake, black, and isort
	autoflake --remove-all-unused-imports --recursive --remove-unused-variables --in-place app --exclude=__init__.py
	black app
	isort --recursive --apply app

# Lint code
lint: ## Lint code using flake8, isort, mypy, and black
	flake8 . && isort --check --diff . && mypy app/

# Run tests
test: ## Run tests using pytest
	pytest --cov=app --cov-report=term-missing app/tests

# Generate coverage report
coverage: ## Generate coverage report
	coverage run -m pytest && coverage report -m

# CI command to run lint, test, and coverage
ci: lint test coverage ## Run lint, test, and coverage report

prestart: ## Appy migrations, add first user
	python app/pre_start.py
	alembic upgrade head
	python app/initial_data.py

# Absolutely awesome: https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# Default goal
.DEFAULT_GOAL := help