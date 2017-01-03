alpine-packages
===============

These are my own Alpine Linux packages.  The packages are available from https://alpine.mbentley.net.  For installation instructions, see https://alpine.mbentley.net/INSTRUCTIONS.txt.  My public key is also available [here](mbentley@mbentley.net-5865c989.rsa.pub).

## Available packages
  * Docker CS Engine (`docker-engine-cs`)
    * Note: meant to be used with the `overlay2` storage driver due to statically compiled binaries
  * Docker OSS Engine (`docker-engine`)
    * Note: meant to be used with the `overlay2` storage driver due to statically compiled binaries

## Build instructions

### local testing
  * `make abuild-local`

### alpine.mbentley.net
  * `make abuild`
  * `make rsyncrepo`
  * `make rsync`
