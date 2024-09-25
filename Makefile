# @author	Sebastien LEGRAND
# @license	MIT License
#
# @brief	Makefile to build and run the docker container

.PHONY: docker-build docker-run docker-clean manpages install

# build a new image
docker-build:
	@docker build -f docker/Dockerfile -t bsfpe:latest .

# create a new interactive container from the image
docker-run:
	@docker run -it --rm bsfpe:latest

# clean docker system (dangling images + cache)
docker-clean:
	@docker system prune

# create the manpages
manpages:
	@cd scripts && ./manpages.sh ../distrib/lib

# install script
install:
	@cd scripts && ./install.sh