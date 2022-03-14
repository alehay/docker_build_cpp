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
    && echo "---------------------------------> install done!" \
    &&  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 10 \
    &&  update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 10 \
    && gcc --version \
    && g++ --version \
    && echo "^^^^^^^^^^^^^^^^ check the version gcc and g++ ^^^^^^^^^^^^^^^^^^^^^^^^^" \

VOLUME /scr
WORKDIR /scr


ENTRYPOINT echo " -------------- >START compilation" \
    && ls \
    && mkdir -p build \
    && cd build \
    && cmake .. \
    && cmake --build .  \
    && cpack \
    && echo "done compilation "
