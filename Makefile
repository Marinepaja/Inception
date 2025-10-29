SRC_DIR = srcs
SRC_FILES = docker-compose.yml
SRC = $(addprefix $(SRC_DIR)/,$(SRC_FILES))

# Execute the Docker Compose command to build and start the containers
# up: create and start the containers --build: rebuild the images if necessary -d: detach (run in the background) to avoid blocking the terminal
all:
	docker compose -f ${SRC} up --build -d

# Clean up the Docker environment by stopping the containers and removing the network
clean:
	docker container stop nginx mariadb wordpress
	docker network rm inception

# Clean up the Docker environment by also removing persistent data
# --rf: remove directories and their contents recursively and forcefully
# system prune -af: remove all unused resources (containers, networks, images, volumes) without asking for confirmation
fclean: clean
	@sudo rm -rf /home/mlaporte/data/mariadb/*
	@sudo rm -rf /home/mlaporte/data/wordpress/*
	@docker system prune -af

# Rebuild the Docker environment from scratch
re: fclean all

# Special targets that do not correspond to real files
.PHONY: all clean fclean re