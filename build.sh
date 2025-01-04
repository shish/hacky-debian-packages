#!/bin/sh
if [ ! -d "$1" ]; then
  echo "Usage: $0 <package directory>"
  exit 1
fi
PKG=$1
docker build $PKG
docker run --rm $(docker build -q $PKG) cat $(basename $PKG).deb > $(basename $PKG).deb
