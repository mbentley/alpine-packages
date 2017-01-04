#!/bin/sh

set -e

VER="${1:-}"
GIT_SHA="$(git rev-parse --short=6 HEAD)"
export GPG_TTY="$(tty)"

# check to see if a version was provided
if [ -z "${VER}" ]
then
  # show existing tags
  echo "Last 3 tags:"
  git tag | tail -n 3
  # prompt user for version
  echo -ne "\nProvide a version number (e.g. - 1.2.3-0): "
  read VER
fi

# create a new tag
git tag -s -a v${VER}-${GIT_SHA} -m "v${VER}-${GIT_SHA}"

# notify user of new tag
echo "Created tag '$(git tag | grep v${VER}-${GIT_SHA})'"
