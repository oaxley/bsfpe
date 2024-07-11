# @author	Sebastien LEGRAND
# @license	MIT License
#
# @brief	Makefile to build and run the docker container

.PHONY: build run clean manpages install

# build a new image
build:
	@docker build -f docker/Dockerfile -t linuxvm:latest .

# create a new interactive container from the image
run:
	@docker run -it --rm linuxvm:latest

# clean docker system (dangling images + cache)
clean:
	@docker system prune

# create the manpages
manpages:
	@cd scripts && ./manpages.sh ../distrib/lib

# install script
install:
	@cd scripts && ./install.sh