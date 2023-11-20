# Hackathon FastAPI Vue Starter

## Overview
An efficient FastAPI and Vue.js starter kit for hackathons, offering rapid setup, JWT authentication, RESTful APIs, and detailed documentation. Ready for quick, scalable web development. This project is dockerized and utilizes Docker Compose for easy setup and deployment.

## Prerequisites
- Docker and Docker Compose installed.
- Basic understanding of `make` command usage.

## Key Technologies
- FastAPI
- Vue.js
- Docker
- Docker Compose

## Docker Compose Configuration
This project includes a `docker-compose.yml` file with the following services:
- **Proxy**: Utilizing Traefik as a reverse proxy.
- **Database**: Postgres as the database service.
- **PgAdmin**: Web UI for database management.
- **Queue**: RabbitMQ for message queuing.
- **Flower**: Monitoring tool for Celery tasks.
- **Backend**: FastAPI backend service.
- **Celery Worker**: For handling background tasks.
- **Frontend**: Vue.js frontend service.


## Installation

- Clone the repository: `git clone [repository-url]`
- Navigate to the project directory: `cd [project-directory]`
- Run Docker Compose: `docker-compose up -d`
- `make initial-data`

## Makefile Commands
- **clean**: Cleans up the project directory and Docker volumes.
- **build-run**: Builds and runs the Docker containers.
- **down**: Takes down the Docker environment, removing containers and volumes.
- **push**: Pushes Docker images to the registry.
- **build**: Builds Docker images as per `docker-compose.yml`.
- **initial-data**: Initial first user.

## Usage
To use the Makefile commands, simply run `make [command]` in your terminal. For example, to build and run your Docker environment, you would execute:

  make build-run

This setup streamlines the process of managing Docker containers and images, ensuring a more efficient workflow for development and deployment.


## Contributing

Contributions are welcome! Please read our contributing guidelines for more information.

## License

This project is licensed under the MIT License - see the LICENSE file for details.