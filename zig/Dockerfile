FROM debian:trixie
RUN apt update && apt install -y wget xz-utils

WORKDIR /app
RUN mkdir -p pkg/usr/lib pkg/usr/bin

RUN wget -O - https://ziglang.org/download/0.14.1/zig-x86_64-linux-0.14.1.tar.xz | tar xJf - && \
    mv zig-x86_64-linux-0.14.1/lib pkg/usr/lib/zig && \
    mv zig-x86_64-linux-0.14.1/zig pkg/usr/bin/zig

COPY control /app/pkg/DEBIAN/control
RUN sed -i "s/Version: 0.0.0/Version: 0.0.$(date +%Y%m%d.%H%M%S)/" /app/pkg/DEBIAN/control
RUN dpkg-deb --build pkg zig.deb
