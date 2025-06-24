FROM debian:trixie
RUN apt update && apt install -y \
    build-essential git \
    libavformat-dev libswscale-dev libavfilter-dev \
    libsdl2-dev libsdl2-ttf-dev
RUN git clone https://github.com/pixop/video-compare /app

WORKDIR /app
RUN make
RUN install -D -m 0755 video-compare /app/pkg/usr/bin/video-compare

COPY control /app/pkg/DEBIAN/control
RUN sed -i "s/Version: 0.0.0/Version: 0.0.$(date +%Y%m%d.%H%M%S)/" /app/pkg/DEBIAN/control
RUN dpkg-deb --build pkg video-compare.deb
