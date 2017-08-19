alpine-packages
===============

These are my own Alpine Linux packages.  The packages are available from http://alpine.mbentley.net.  For installation instructions, see http://alpine.mbentley.net/INSTRUCTIONS.txt.  My public key is also available [here](./repo/mbentley@mbentley.net-5865c989.rsa.pub).

## Available packages
  * Docker CE (`docker-ce`)
    * Engine versions: `17.06`, `17.03`, `edge`
    * Note: meant to be used with the `overlay2` storage driver due to statically compiled binaries
  * Docker EE (`docker-ee`)
    * Not available; binaries are only available via Docker Store for supported operating systems (see https://blog.docker.com/2017/03/docker-enterprise-edition/)

## Available packages (soon to be deprecated)
  * Docker CS Engine (`docker-engine-cs`)
    * Engine versions: `1.11`, `1.12`, `1.13`
    * Note: meant to be used with the `overlay2` storage driver due to statically compiled binaries
  * Docker OSS Engine (`docker-engine`)
    * Engine versions: `1.11`, `1.12`, `1.13`
    * Note: meant to be used with the `overlay2` storage driver due to statically compiled binaries

## Build instructions

### Update APKBUILD files as necessary

### Re-create checksums so they're in git
  * `VERSION=v17.03 make checksum`

### Commit and merge change branch

### Check out master and build (which takes care of the rest)
  * `VERSION=v17.03 make checksum build`

## Local testing

### local testing
  * `make checksum abuild-local`
