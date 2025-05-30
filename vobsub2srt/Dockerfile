FROM debian:trixie
RUN apt update && apt install -y \
    build-essential git libtiff5-dev libtesseract-dev tesseract-ocr-eng cmake pkg-config
#RUN git clone https://github.com/ruediger/VobSub2SRT /app
#RUN git clone https://github.com/leonard-slass/VobSub2SRT /app
RUN git clone https://github.com/64kramsystem/VobSub2SRT-dev /app && cd /app && git checkout fix_linux_compilation

WORKDIR /app
RUN ./configure -DCMAKE_INSTALL_PREFIX:PATH=/usr && make
RUN install -D -m 0755 build/bin/vobsub2srt /app/pkg/usr/bin/vobsub2srt

COPY control /app/pkg/DEBIAN/control
RUN sed -i "s/Version: 0.0.0/Version: 0.0.$(date +%Y%m%d.%H%M%S)/" /app/pkg/DEBIAN/control
#RUN find /app/pkg && false
RUN dpkg-deb --build pkg vobsub2srt.deb
# && dpkg-name -o *.deb
