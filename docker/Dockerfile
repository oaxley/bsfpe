# syntax=docker/dockerfile:1.4

# @author   Sebastien LEGRAND
# @licence  MIT License
#
# @brief    Dockerfile to test the library in a contained environment

# we use Ubuntu 24.04 by default
FROM ubuntu:jammy

# generic user (never run container as root)
ARG USER=genusr
ARG GROUP=genusr

# install default packages
ENV DEBIAN_FRONTEND=noninteractive
RUN : \
    && apt update \
    && apt install --quiet -y --no-install-recommends \
        python3 xxd \
        netcat iproute2 \
        vim

# add the generic user
RUN : \
    && addgroup ${GROUP} \
    && adduser --home /home/${USER} \
               --shell /bin/bash \
               --ingroup ${GROUP} \
               --gecos "" \
               --disabled-password \
               --quiet \
               ${USER}

# copy the source files in the generic user home
COPY --chown=${USER}:${GROUP} src/ /home/${USER}/.bsfpe

# last steps
WORKDIR /home/${USER}
USER ${USER}
