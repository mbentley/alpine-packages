#!/bin/sh

set -e

VER="${1:-}"
export GPG_TTY="$(tty)"

# fetch all tagsto make sure we have a lit of the latest
echo "Fetching all tags..."
git fetch --tags

# check to see if a version was provided
if [ -z "${VER}" ]
then
  # show existing tags
  echo "Last 3 tags:"
  git tag -l --sort=v:refname | tail -n 3
  # prompt user for version
  echo -ne "\nProvide a version number (e.g. - v1.2.3): "
  read VER
fi

# create a new tag
git tag -s -a ${VER} -m "${VER}"

# notify user of new tag
echo "Created tag '$(git tag | grep ${VER})'"

# push tags
echo "Pushing tags..."
git push origin --tags
