FROM debian:trixie
RUN apt update && apt install -y wget

ARG JJ_VERSION=0.41.0

WORKDIR /app
RUN mkdir -p pkg/usr/bin

RUN wget -O - https://github.com/jj-vcs/jj/releases/download/v${JJ_VERSION}/jj-v${JJ_VERSION}-x86_64-unknown-linux-musl.tar.gz | tar xzf - && \
    mv jj pkg/usr/bin/

COPY control /app/pkg/DEBIAN/control
RUN sed -i "s/Version: 0.0.0/Version: ${JJ_VERSION}.$(date +%Y%m%d.%H%M%S)/" /app/pkg/DEBIAN/control
RUN dpkg-deb --build pkg jujutsu.deb
