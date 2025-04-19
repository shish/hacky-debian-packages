#!/bin/sh
set -eux

cd repo
rm -rf Packages Release InRelease

apt-ftparchive packages . > Packages
apt-ftparchive release . > Release
# gpg --armor --export shish+deb@shishnet.org > shish-deb.asc
cat Release | gpg -a -s --clearsign --default-key shish+deb@shishnet.org - > InRelease
