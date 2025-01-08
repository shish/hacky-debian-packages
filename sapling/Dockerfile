FROM debian:testing
RUN apt update && apt install -y \
    build-essential cargo git yarnpkg nodejs \
    python3.12-full python3.12-dev python3-distutils-extra \
    procps pkg-config libssl-dev
WORKDIR /app
RUN git clone https://github.com/facebook/sapling

# try to make ISL build despite it depending on ancient yarn
#RUN ln -s /usr/bin/yarnpkg /usr/bin/yarn
#RUN sed -i 's/, "--prefer-offline"//' /app/sapling/addons/build-tar.py

# give up and skip the ISL completely
RUN grep -v build_interactive_smartlog sapling/eden/scm/Makefile > mf2 && mv mf2 sapling/eden/scm/Makefile

RUN --mount=type=cache,target=/usr/local/cargo/registry \
	--mount=type=cache,target=/root/.cargo \
	cd sapling/eden/scm && make oss
RUN cd sapling/eden/scm && ./sl --help && install -D -m 0755 ./sl /app/pkg/usr/bin/sl

COPY control /app/pkg/DEBIAN/control
RUN sed -i "s/Version: 0.0.0/Version: 0.0.$(date +%Y%m%d.%H%M%S)/" /app/pkg/DEBIAN/control
#RUN find /app/pkg && false
RUN dpkg-deb --build pkg sapling.deb
# && dpkg-name -o *.deb
