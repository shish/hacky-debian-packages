FROM debian:trixie
RUN apt update && apt install -y wget xz-utils

ARG UV_VERSION=0.11.12

WORKDIR /app
RUN mkdir -p pkg/usr/bin

RUN wget -O - https://github.com/astral-sh/uv/releases/download/${UV_VERSION}/uv-x86_64-unknown-linux-gnu.tar.gz | tar xzf - && \
    mv uv*/* pkg/usr/bin/

COPY control /app/pkg/DEBIAN/control
RUN sed -i "s/Version: 0.0.0/Version: ${UV_VERSION}.$(date +%Y%m%d.%H%M%S)/" /app/pkg/DEBIAN/control
RUN dpkg-deb --build pkg uv.deb
