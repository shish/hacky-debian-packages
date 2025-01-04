FROM debian:testing
RUN apt update && apt install -y \
    build-essential cargo git \
    pkg-config libssl-dev libpulse-dev libsensors-dev
RUN git clone https://github.com/greshake/i3status-rust /app
RUN apt update && apt install -y \
    pandoc
WORKDIR /app
RUN --mount=type=cache,target=/usr/local/cargo/registry \
    --mount=type=cache,target=/app/target \
    cargo build --release && cargo xtask generate-manpage
RUN --mount=type=cache,target=/app/target \
    install -D -m 0755 target/release/i3status-rs /app/i3status-rust/usr/bin/i3status-rs
RUN install -D -m 0755 man/i3status-rs.1 /app/i3status-rust/usr/share/man/man1/i3status-rs.1
RUN cp -rv files /app/i3status-rust/usr/share/i3status-rust
COPY control /app/i3status-rust/DEBIAN/control
#RUN find /app/i3status-rust && false
RUN dpkg-deb --build i3status-rust
