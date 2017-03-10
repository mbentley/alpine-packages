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

# calculate checksums for all packages found
echo "Re-creating index for ${PKG_DIR}/${VERSION}"
cd "$(find . -mindepth 1 -type d -print -quit)"
REPODEST="${HOME}/packages/${TARGET}/${PKG_DIR}" abuild index
printf "done\n\n"
