FROM debian:testing
RUN apt update && apt install -y \
    build-essential meson ninja-build \
    cargo git pkg-config libudev-dev \
    libgio-2.0-dev-bin sassc \
    libevdev-dev libglib2.0-dev libgdk-pixbuf-2.0-dev \
    libcairo2-dev libpango1.0-dev libgtk-4-dev libgtk4-layer-shell-dev \
    libpulse-dev libinput-dev
#RUN git clone https://github.com/ErikReider/SwayOSD /app
RUN git clone https://github.com/shish/SwayOSD /app && echo 1
WORKDIR /app
RUN git checkout ignore-caps-lock-backend

# meson's default settings put .service files in /usr/local/lib/x64_64-linux-gnu/systemd/
# but systemd looks in /usr/lib/systemd/
RUN meson setup --prefix=/usr --libdir=lib build
RUN --mount=type=cache,target=/usr/local/cargo/registry \
    --mount=type=cache,target=/app/target \
    ninja -C build
RUN meson install -C build --destdir=/app/pkg

COPY control /app/pkg/DEBIAN/control
COPY postinst /app/pkg/DEBIAN/postinst
RUN sed -i "s/Version: 0.0.0/Version: 0.0.$(date +%Y%m%d.%H%M%S)/" /app/pkg/DEBIAN/control
#RUN find /app/pkg && false
RUN dpkg-deb --build pkg swayosd.deb
# && dpkg-name -o *.deb
