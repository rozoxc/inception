NAME		= inception
COMPOSE		= /home/ababdoul/Desktop/inception/docker-compose.yml
DATA_PATH	= /home/ababdoul/data


all: setup up

setup:
	@echo "Creating data directories..."
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p $(DATA_PATH)/wordpress

up: setup
	@echo "Building and starting containers..."
	docker compose -f $(COMPOSE) up --build -d


down:
	@echo "Stopping containers..."
	docker compose -f $(COMPOSE) down


clean: down
	@echo "Cleaning up containers and networks..."
	docker system prune -af


fclean: clean
	@echo "Performing deep clean and removing volumes..."
	docker compose -f $(COMPOSE) down -v
	@sudo rm -rf $(DATA_PATH)/mariadb/*
	@sudo rm -rf $(DATA_PATH)/wordpress/*
	@echo "Data successfully wiped."


re: fclean all

.PHONY: all setup up down clean fclean re
