FROM debian:testing
RUN apt update && apt install -y \
    build-essential cargo git \
    pkg-config libpipewire-0.3-dev
RUN git clone https://github.com/rafaelrc7/wayland-pipewire-idle-inhibit /app

WORKDIR /app
RUN --mount=type=cache,target=/usr/local/cargo/registry \
    --mount=type=cache,target=/app/target \
    cargo build --release && cp target/release/wayland-pipewire-idle-inhibit ./
RUN install -D -m 0755 wayland-pipewire-idle-inhibit /app/pkg/usr/bin/wayland-pipewire-idle-inhibit

COPY control ./DEBIAN/
RUN mv ./DEBIAN/ /app/pkg
#RUN find /app/pkg && false
RUN dpkg-deb --build /app/pkg wayland-pipewire-idle-inhibit.deb
