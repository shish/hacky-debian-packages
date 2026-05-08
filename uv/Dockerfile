FROM debian:trixie
RUN apt update && apt install -y wget xz-utils

WORKDIR /app
RUN mkdir -p pkg/usr/bin

RUN wget -O - https://github.com/astral-sh/uv/releases/download/0.9.17/uv-x86_64-unknown-linux-gnu.tar.gz | tar xzf - && \
    mv uv*/* pkg/usr/bin/

COPY control /app/pkg/DEBIAN/control
RUN sed -i "s/Version: 0.0.0/Version: 0.0.$(date +%Y%m%d.%H%M%S)/" /app/pkg/DEBIAN/control
RUN dpkg-deb --build pkg uv.deb
