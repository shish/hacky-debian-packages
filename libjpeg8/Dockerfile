FROM debian:trixie

WORKDIR /app
RUN mkdir -p pkg/usr/lib/x86_64-linux-gnu
RUN cd pkg/usr/lib/x86_64-linux-gnu
RUN ln -s libjpeg.so.62 libjpeg.so.8

COPY control /app/pkg/DEBIAN/control
RUN sed -i "s/Version: 0.0.0/Version: 0.$(date +%Y%m%d.%H%M%S)/" /app/pkg/DEBIAN/control
RUN dpkg-deb --build pkg libjpeg8.deb
