FROM debian:testing
RUN apt update && apt install -y \
    build-essential meson ninja-build \
    cargo git pkg-config libudev-dev \
    libgio-2.0-dev-bin sassc \
    libevdev-dev libglib2.0-dev libgdk-pixbuf-2.0-dev \
    libcairo2-dev libpango1.0-dev libgtk-4-dev libgtk4-layer-shell-dev \
    libpulse-dev libinput-dev
RUN git clone https://github.com/ErikReider/SwayOSD /app
WORKDIR /app
# meson's default settings put .service files in /usr/local/lib/x64_64-linux-gnu/systemd/
# but systemd looks in /usr/lib/systemd/
RUN meson setup --prefix=/usr --libdir=lib build
RUN --mount=type=cache,target=/usr/local/cargo/registry \
    --mount=type=cache,target=/app/target \
    ninja -C build
RUN meson install -C build --destdir=/app/swayosd
COPY control /app/swayosd/DEBIAN/control
COPY postinst /app/swayosd/DEBIAN/postinst
RUN dpkg-deb --build swayosd
# && dpkg-name -o swayosd.deb
