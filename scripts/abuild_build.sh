#!/bin/sh

set -e

TARGET="${1:-}"
PKG_DIR="${2:-}"
VERSION="${3:-}"

if [ -z "${TARGET}" ] || [ -z "${PKG_DIR}" ] || [ -z "${VERSION}" ]
then
  echo "Error: missing TARGET, PKG_DIR or VERSION"
  exit 1
fi

# move to package directory for the specified version
cd ./pkgs/"${PKG_DIR}"/"${VERSION}"

# build all packages found
for PKG in *
do
  echo "Building ${PKG}"
  (cd "${PKG}" &&\
    abuild -r -P "${HOME}"/packages/"${TARGET}"/"${PKG_DIR}")
  printf "done\n\n"
done
