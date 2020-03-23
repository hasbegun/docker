FROM alpine:3.9.4

LABEL maintainer="hasbegun hasbegun@gmail.com"

# RUN echo -e '@edgunity http://nl.alpinelinux.org/alpine/edge/community\n\
#     @edge http://nl.alpinelinux.org/alpine/edge/main\n\
#     @testing http://nl.alpinelinux.org/alpine/edge/testing\n\
#     @community http://dl-cdn.alpinelinux.org/alpine/edge/community'\
#     >> /etc/apk/repositories

RUN apk add --update \
    build-base \
    clang \
    clang-dev \
    openssl \
    python3-dev \
    libpng \
    libwebp \
    libjpeg \
    openjpeg \
    curl \
    wget \
    freetype \
    jpeg \
    zlib \
    unzip \
    cmake \
    git \
    linux-headers

RUN apk add --update --no-cache --virtual build-deps \
    clang-dev \
    openssl-dev \
    python3-dev \
    openblas-dev \
    openjpeg-dev \
    libpng-dev \
    libwebp-dev \
    jpeg-dev \
    tiff-dev \
    zlib-dev

# Add python3
RUN apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi 

# Add symbolic links to for Python3
 RUN ln -s /usr/bin/python3 /usr/local/bin/python && \
     ln -s /usr/bin/pip3 /usr/local/bin/pip && \
     pip install --upgrade pip

# Clean Up
RUN rm -r /root/.cache && \
    rm -rf /var/cache/apk/* && \
    apk del build-deps
