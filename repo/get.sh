#!/bin/sh

set -e

VERSION="${VERSION:-18.06}"

if [ "$(id -u)" -ne "0" ]
then
  echo "You must run as root"
  exit 1
fi

echo "Adding public key 'mbentley@mbentley.net-5865c989.rsa.pub'"
wget "http://alpine.mbentley.net/mbentley@mbentley.net-5865c989.rsa.pub" -O "/etc/apk/keys/mbentley@mbentley.net-5865c989.rsa.pub"
chmod 644 /etc/apk/keys/mbentley@mbentley.net-5865c989.rsa.pub

printf "\\nAdding repository for 'alpine.mbentley.net'\\n"
echo "@docker-${VERSION} http://alpine.mbentley.net/docker/v${VERSION}" | tee -a /etc/apk/repositories

printf "\\nUpdating repository indexes\\n"
apk update

printf "\\ndone.\\n"
