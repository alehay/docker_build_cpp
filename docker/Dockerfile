FROM ${DOCKER_REGISTRY_MIRROR}ubuntu:20.04 AS builder


RUN echo " -------------------------->package install begin" \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y \
        ca-certificates \
        lsb-release \
   
    && apt-get update \
    && apt-get install -y \
        build-essential \
        cmake \
        gcc-10 \
        g++-10 \
        jq \
        libssl-dev \
        libzip-dev \
        moreutils \
    && echo "---------------------------------> install done!"

VOLUME /scr
WORKDIR /scr


ENTRYPOINT echo "START compilation" \
    && mkdir -p build \
    && cd build \
    && cmake .. \
    && cmake --build .  \
    && cpack \
    && echo "done compilation "
