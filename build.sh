#!/bin/sh
if [ -z "$1" ]; then
  echo "Usage: $0 <package name>"
  exit 1
fi
PKG=$1
docker build $PKG
docker run --rm $(docker build -q $PKG) cat $PKG.deb > $PKG.deb
