#!/bin/sh

set -e

VER="${1:-}"
GIT_SHA="$(git rev-parse --short=6 HEAD)"
export GPG_TTY="$(tty)"

# check to see if a version was provided
if [ -z "${VER}" ]
then
  # prompt user for version
  echo -n "Provide a version number (e.g. - 1.2.3-0): "
  read VER
fi

# create a new tag
git tag -s -a v${VER}-${GIT_SHA} -m "v${VER}-${GIT_SHA}"

# notify user of new tag
echo "Created tag '$(git tag | grep v${VER}-${GIT_SHA})'"
