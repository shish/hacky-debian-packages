FROM debian:trixie
RUN apt update && apt install -y wget xz-utils

ARG ZIG_VERSION=0.14.1

WORKDIR /app
RUN mkdir -p pkg/usr/lib pkg/usr/bin

RUN wget -O - https://ziglang.org/download/${ZIG_VERSION}/zig-x86_64-linux-${ZIG_VERSION}.tar.xz | tar xJf - && \
    mv zig-x86_64-linux-${ZIG_VERSION}/lib pkg/usr/lib/zig && \
    mv zig-x86_64-linux-${ZIG_VERSION}/zig pkg/usr/bin/zig

COPY control /app/pkg/DEBIAN/control
RUN sed -i "s/Version: 0.0.0/Version: ${ZIG_VERSION}.$(date +%Y%m%d.%H%M%S)/" /app/pkg/DEBIAN/control
RUN dpkg-deb --build pkg zig.deb
