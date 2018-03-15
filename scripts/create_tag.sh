#!/bin/bash

set -e

VER="${1:-}"
export GPG_TTY
GPG_TTY="$(tty)"

# fetch all tagsto make sure we have a lit of the latest
echo "Fetching all tags..."
git fetch --tags

# check to see if a version was provided
if [ -z "${VER}" ]
then
  # show existing tags
  GIT_TAGS="$(git tag -l --sort=v:refname)"
  echo "Last 3 tags:"
  echo "${GIT_TAGS}" | tail -n 3
  # prompt user for version
  echo -ne "\\nProvide a version number (e.g. - v1.2.3): "
  read -r VER
fi

# check to see if tag provided is identical to an existing tag
if echo "${GIT_TAGS}" | grep "${VER}" > /dev/null
then
  # in ver; skip create tag
  echo "Using existing tag (${VER})"
else
  # not in ver; create tag
  echo "Creating new tag"
  # create a new tag
  git tag -s -a "${VER}" -m "${VER}"

  # notify user of new tag
  echo "Created tag '$(git tag | grep "${VER}")'"

  # push tags
  echo "Pushing tags..."
  git push origin --tags
fi
