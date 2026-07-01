# Variables
NAME		= inception
COMPOSE		= /home/ababdoul/Desktop/inception
DATA_PATH	= /home/ababdoul/data

# Default target
all: setup up

# Create the physical volume directories on the host machine
setup:
	@echo "Creating data directories..."
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p $(DATA_PATH)/wordpress

# Build and start the containers in the background
up: setup
	@echo "Building and starting containers..."
	docker compose -f $(COMPOSE) up --build -d

# Stop the containers
down:
	@echo "Stopping containers..."
	docker compose -f $(COMPOSE) down

# Stop containers and remove images/networks (Clean)
clean: down
	@echo "Cleaning up containers and networks..."
	docker system prune -af

# Deep clean: Stop everything, remove volumes, and delete physical data (Factory Reset)
fclean: clean
	@echo "Performing deep clean and removing volumes..."
	docker compose -f $(COMPOSE) down -v
	@sudo rm -rf $(DATA_PATH)/mariadb/*
	@sudo rm -rf $(DATA_PATH)/wordpress/*
	@echo "Data successfully wiped."

# Restart everything from a completely clean slate
re: fclean all

# Phony targets to prevent conflicts with actual files
.PHONY: all setup up down clean fclean re