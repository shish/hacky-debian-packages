#!/bin/sh
docker build .
docker run --rm $(docker build -q .) cat swayosd.deb > swayosd_0.0.0_amd64.deb
