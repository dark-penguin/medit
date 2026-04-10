FROM debian:trixie AS build-stage

COPY *.sources /etc/apt/sources.list.d/

RUN apt-get update

COPY . /root/medit/src
WORKDIR /root/medit/src
RUN apt-get install -y --no-install-recommends build-essential \
    debhelper pkg-config intltool libxml-parser-perl libxml2-dev \
    python2 python2-dev python-gtk2-dev libgtk2.0-dev

RUN MAKEFLAGS="-j$(nproc)" debian/rules binary



# To export only the build artifacts (build with '-o <path>' to save them)
FROM scratch AS export-stage

COPY --from=build-stage /root/medit/medit*.deb /
