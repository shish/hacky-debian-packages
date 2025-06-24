
I gave up on Arch and went back to Debian, but I miss a couple of
packages from the AUR, so let's make some ugly .deb packages

I don't like to have my day-to-day laptop full of development tools
which only get used once, so each package here has its own Docker
script to install relevant tools / build the package / copy the
package out of the container and onto the host

These are very much minimum-viable-packages, in most cases only
containing the bare minimum of debian metadata (package name +
version) and a file in `/usr/bin`

Example
```
./build.sh sapling
sudo apt install ./repo/sapling.deb
```
