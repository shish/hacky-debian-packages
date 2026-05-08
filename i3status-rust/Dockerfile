FROM debian:trixie
RUN apt update && apt install -y \
    build-essential git curl \
    pkg-config libssl-dev libpulse-dev libsensors-dev pandoc

# Install rustup and latest stable Rust toolchain
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable
ENV PATH="/root/.cargo/bin:${PATH}"

RUN git clone https://github.com/greshake/i3status-rust /app

WORKDIR /app
RUN --mount=type=cache,target=/root/.cargo/registry \
    --mount=type=cache,target=/app/target \
    cargo build --release && cargo xtask generate-manpage && cp target/release/i3status-rs ./
RUN install -D -m 0755 i3status-rs /app/pkg/usr/bin/i3status-rs
RUN install -D -m 0755 man/i3status-rs.1 /app/pkg/usr/share/man/man1/i3status-rs.1
RUN cp -rv files /app/pkg/usr/share/i3status-rust

COPY control /app/pkg/DEBIAN/control
RUN sed -i "s/Version: 0.0.0/Version: 0.0.$(date +%Y%m%d.%H%M%S)/" /app/pkg/DEBIAN/control
#RUN find /app/pkg && false
RUN dpkg-deb --build pkg i3status-rust.deb
