alpine-packages
===============

These are my own Alpine Linux packages.  The packages are available from http://alpine.mbentley.net.  For installation instructions, see http://alpine.mbentley.net/INSTRUCTIONS.txt.  My public key is also available [here](./repo/mbentley@mbentley.net-5865c989.rsa.pub).

## Available packages
  * Docker CS Engine (`docker-engine-cs`)
    * Engine versions: `1.11`, `1.12`, `1.13`
    * Note: meant to be used with the `overlay2` storage driver due to statically compiled binaries
  * Docker OSS Engine (`docker-engine`)
    * Engine versions: `1.11`, `1.12`, `1.13`
    * Note: meant to be used with the `overlay2` storage driver due to statically compiled binaries
  * Docker Engine CE (`docker-ce`)
    * Engine versions: `17.03`
    * Note: meant to be used with the `overlay2` storage driver due to statically compiled binaries

## Build instructions

### local testing
  * `make abuild-local`

### alpine.mbentley.net
  * `make build`
