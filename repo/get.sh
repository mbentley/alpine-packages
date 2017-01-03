#!/bin/sh

set -e

if [ "$(id -u)" -ne "0" ]
then
  echo "You must run as root"
  exit 1
fi

echo "Adding public key 'mbentley@mbentley.net-5865c989.rsa.pub'"
wget "http://alpine.mbentley.net/mbentley@mbentley.net-5865c989.rsa.pub" -O "/etc/apk/keys/mbentley@mbentley.net-5865c989.rsa.pub"
chmod 644 /etc/apk/keys/mbentley@mbentley.net-5865c989.rsa.pub

echo -e "\nAdding repository for 'alpine.mbentley.net'"
echo "@mbentley http://alpine.mbentley.net/main" | tee -a /etc/apk/repositories

echo -e "\nUpdating repository indexes"
apk update

echo -e "\ndone."
