FROM debian:testing
RUN apt update && apt install -y \
    build-essential cargo git \
    pkg-config libssl-dev libpulse-dev libsensors-dev pandoc
RUN git clone https://github.com/greshake/i3status-rust /app

WORKDIR /app
RUN --mount=type=cache,target=/usr/local/cargo/registry \
    --mount=type=cache,target=/app/target \
    cargo build --release && cargo xtask generate-manpage && cp target/release/i3status-rs ./
RUN install -D -m 0755 i3status-rs /app/pkg/usr/bin/i3status-rs
RUN install -D -m 0755 man/i3status-rs.1 /app/pkg/usr/share/man/man1/i3status-rs.1
RUN cp -rv files /app/pkg/usr/share/i3status-rust

COPY control /app/pkg/DEBIAN/control
#RUN find /app/pkg && false
RUN dpkg-deb --build pkg i3status-rust.deb
