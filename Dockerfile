FROM debian:bookworm AS build-stage

RUN sed -i /etc/apt/sources.list.d/debian.sources \
    -e 's|^Suites: bookworm bookworm-updates|Suites: bookworm bookworm-updates bullseye bullseye-updates buster buster-updates|' \
    -e 's|^Suites: bookworm-security|Suites: bookworm-security bullseye-security buster/updates|'

RUN apt-get update

COPY . /root/medit/src
WORKDIR /root/medit/src
RUN apt-get install -y --no-install-recommends build-essential \
    debhelper pkg-config intltool libxml-parser-perl libxml2-dev \
    python2 python2-dev python-gtk2-dev libgtk2.0-dev

RUN MAKEFLAGS="-j4" debian/rules binary



# To export only the build artifacts (build with '-o <path>' to save them)
FROM scratch AS export-stage

COPY --from=build-stage /root/medit/medit*.deb /
