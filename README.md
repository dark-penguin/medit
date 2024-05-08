About
-----
Mooedit (also known as medit) is a lightweight but powerful text editor that was discontinued in 2014, and removed from Debian repositories since Debian 10 Bullseye.

Mooedit depends on Python2, which is becoming more and more of a problem as Python2 has reached EOL and was removed from Debian repositories.

This repository contains the latest known official version of medit, with a `debian/` folder added for building .deb packages, and adapted to build packages that do not depend on Python2.


Building
--------
- You can build on a modern distribution (e.g. Debian 12 Bookworm)
- Add APT sources for Buster (essential) and Bullseye (optional if you want some build dependencies to be more modern)
- Clone this repository and `cd` into it
- Install dependencies - some dependencies will be picked up from Buster, and some from whatever more modern you have available:
  - The easy way: `apt-get build-dep medit`
  - Manually: `apt-get install debhelper pkg-config libxml-parser-perl libxml2-dev intltool libgtk2.0-dev python python-dev python-gtk2-dev`
  - The Debian Maintainer way: `apt-get install devscripts`, then `mk-build-deps -ir` to install build-deps specified in the package
  - You also need `fakeroot` to build packages without being root (and you should NOT build stuff as root!)
- `MAKEFLAGS="-j4" fakeroot debian/rules binary` - build a Debian package *in the parent directory*

The resulting Bookworm package does not have any runtime dependencies you can't satisfy with Bookworm repositories, so you can simply install it on Bookworm without any trouble.


Notes
-----
For some reason, `MAKEFLAGS="-j4"` does not have an effect, so don't be surprised that it only uses one CPU core to build.

Details
-------
Here's which dependencies were picked up from which repositories when I was building the Bookworm release (as described above):

#### Buster:
```
libffi6 amd64 3.2.1-9 [20.8 kB]
python-cairo amd64 1.16.2-1+b1 [58.4 kB]
python-gobject-2 amd64 2.28.6-13+b1 [288 kB]
python-gobject-2-dev all 2.28.6-13 [307 kB]
python-numpy amd64 1:1.16.2-1 [2,101 kB]
python-gtk2 amd64 2.24.0-5.1+b1 [633 kB]
python-gtk2-dev all 2.24.0-5.1 [146 kB]
```

#### Bullseye:
```
libpython2.7-minimal amd64 2.7.18-8+deb11u1 [397 kB]
python2.7-minimal amd64 2.7.18-8+deb11u1 [1,301 kB]
python2-minimal amd64 2.7.18-3 [34.2 kB]
libssl1.1 amd64 1.1.1w-0+deb11u1 [1,566 kB]
libffi7 amd64 3.3-6 [23.1 kB]
libpython2.7-stdlib amd64 2.7.18-8+deb11u1 [1,864 kB]
python2.7 amd64 2.7.18-8+deb11u1 [311 kB]
libpython2-stdlib amd64 2.7.18-3 [21.2 kB]
python2 amd64 2.7.18-3 [24.5 kB]
libpython2.7 amd64 2.7.18-8+deb11u1 [1,023 kB]
libpython2.7-dev amd64 2.7.18-8+deb11u1 [2,354 kB]
libpython2-dev amd64 2.7.18-3 [21.3 kB]
python-is-python2 all 2.7.18-9 [2,940 B]
python2.7-dev amd64 2.7.18-8+deb11u1 [291 kB]
python2-dev amd64 2.7.18-3 [1,216 B]
python-dev-is-python2 all 2.7.18-9 [1,528 B]
python-pkg-resources all 44.1.1-1 [182 kB]
```

The rest of them were from Bookworm.

I don't know why it pulled both `libffi6` from Buster, `libffi7` from Bullseye, and `libffi-dev` from Bookworm.
