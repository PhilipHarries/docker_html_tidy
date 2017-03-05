FROM alpine
MAINTAINER Philip Harries <philip.harries.unix.consulting@gmail.com>
RUN apk update && apk --no-cache add \
    curl \
    tar \
    alpine-sdk \
    cmake \
    bash && \
    latest_url="$(curl -sI https://github.com/htacg/tidy-html5/releases/latest|grep Location:|awk '{print $2}'|sed s/^M//g)" && \
    latest_semver="$(echo ${latest_url}|awk -F/ '{print $NF}')" && \
    curl -sL https://github.com/htacg/tidy-html5/archive/${latest_semver}.tar.gz | tar -xz -C /tmp  && \
    cd "/tmp/tidy-html5-${latest_semver}/build/cmake" \
    && cmake ../.. -DCMAKE_BUILD_TYPE=Release \
    && make \
    && make install
