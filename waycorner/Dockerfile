FROM debian:testing
RUN apt update && apt install -y \
    build-essential cargo git
RUN git clone https://github.com/AndreasBackx/waycorner /app

WORKDIR /app
RUN --mount=type=cache,target=/usr/local/cargo/registry \
    --mount=type=cache,target=/app/target \
    cargo build --release && cp target/release/waycorner ./
RUN install -D -m 0755 waycorner /app/pkg/usr/bin/waycorner

COPY control /app/pkg/DEBIAN/control
RUN sed -i "s/Version: 0.0.0/Version: 0.0.$(date +%Y%m%d.%H%M%S)/" /app/pkg/DEBIAN/control
#RUN find /app/pkg && false
RUN dpkg-deb --build pkg waycorner.deb
# && dpkg-name -o *.deb
