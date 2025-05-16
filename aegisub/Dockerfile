FROM debian:testing
RUN apt update && apt install -y \
    git build-essential pkg-config meson ninja-build \
	gettext intltool \
	libfontconfig1-dev libass-dev \
	libboost-chrono-dev libboost-locale-dev libboost-regex-dev libboost-system-dev libboost-thread-dev \
	zlib1g-dev \
	wx3.2-headers libwxgtk3.2-dev \
	icu-devtools libicu-dev \
	libpulse-dev libasound2-dev libopenal-dev libffms2-dev libfftw3-dev libhunspell-dev \
	libuchardet-dev libcurl4-gnutls-dev libgl1-mesa-dev libgtest-dev libgmock-dev
RUN git clone https://github.com/TypesettingTools/Aegisub /app

WORKDIR /app

RUN meson setup build --prefix=/usr/local --buildtype=release --strip -Dsystem_luajit=false
RUN meson compile -C build
RUN meson install -C build --skip-subprojects luajit
#RUN find -name aegisub && false
RUN install -D -m 0755 build/aegisub /app/pkg/usr/bin/aegisub

COPY control /app/pkg/DEBIAN/control
RUN sed -i "s/Version: 0.0.0/Version: 0.0.$(date +%Y%m%d.%H%M%S)/" /app/pkg/DEBIAN/control
#RUN find /app/pkg && false
RUN dpkg-deb --build pkg aegisub.deb
# && dpkg-name -o *.deb
