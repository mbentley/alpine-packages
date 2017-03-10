#!/bin/sh

set -e

PKG_DIR="${1:-}"
VERSION="${2:-}"

if [ -z "${PKG_DIR}" ] || [ -z "${VERSION}" ]
then
  echo "Error: missing PKG_DIR or VERSION"
  exit 1
fi

# move to package directory for the specified version
cd ./pkgs/"${PKG_DIR}"/"${VERSION}"

# calculate checksums for all packages found
for PKG in *
do
  echo "Calculating checksums for ${PKG}"
  (cd "${PKG}" &&\
    abuild checksum)
  printf "done\n\n"
done
