DOCKER_COMPOSE_FILE=srcs/docker-compose.yaml

all:
	docker compose -f $(DOCKER_COMPOSE_FILE) up 
re:
	docker compose -f $(DOCKER_COMPOSE_FILE) up --build
re:
stop: 
	docker compose -f $(DOCKER_COMPOSE_FILE) stop
clean:
	docker compose -f $(DOCKER_COMPOSE_FILE) down
