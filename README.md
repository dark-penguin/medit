Mooedit (also known as medit) is a lightweight but powerful text editor that was discontinued in 2014, and removed from Debian repositories since Debian 10 Bullseye.

Mooedit depends on Python2 that is becoming more of a problem as Python2 has reached EOL and was removed from Debian repositories.

This repository contains the latest known version of medit, with a `debian/` folder added for building .deb packages, and adapted to build packages that do not depend on Python2.


BUILDING
========
- You can use a modern distribution (e.g. Debian 12 Bookworm)
- Add APT sources for Buster (essential) and Bullseye (optional if you want some build dependencies to be more modern)
- `apt-get build-dep medit` - some dependencies will be picked up from Buster, and some from whatever more modern you have available
- Clone this repository and `cd` into it
- `MAKEFLAGS="-j4" fakeroot debian/rules binary` - build a Debian package *in the parent directory*

The resulting Bookworm package does not have any runtime dependencies you can't satisfy with Bookworm repositories, so you can simply install it on Bookworm without any trouble.
