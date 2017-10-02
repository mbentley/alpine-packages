VERSION ?= v17.09
HOME ?= /tmp

all: help

help:		## Show this help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

build-local:	## Run checksum and abuild-local
build-local: checksum abuild-local

build:          ## Run tag, syncfromrepo, checksum, abuild, and syncall
build: tag syncfromrepo checksum abuild syncall

tag:		## Create a new git tag
	@./scripts/create_tag.sh

checksum:	## Generate checksums for files in APKBUILD files
	@./scripts/abuild_checksum.sh docker $(VERSION)

abuild-local:	## Build packages for local testing
	@./scripts/abuild_build.sh local docker $(VERSION)

abuild:		## Build packages for alpine.mbentley.net
	@./scripts/abuild_build.sh alpine.mbentley.net docker $(VERSION)

syncrepo:	## rsync metadata files from ./repo to the alpine.mbentley.net directory
	@rsync --progress --delete -avh -f"- */" -f"+ *" ./repo/ $(HOME)/packages/alpine.mbentley.net/

syncfromrepo:   ## rsync from repository to local
	@rsync --progress -avh alpine_repo:/var/www/alpine.mbentley.net/ $(HOME)/packages/alpine.mbentley.net/

sync:		## rsync packages to alpine.mbentley.net
	@rsync --progress --delete-after -avh $(HOME)/packages/alpine.mbentley.net/ alpine_repo:/var/www/alpine.mbentley.net/

syncall: 	## Run both syncrepo and sync
syncall: syncrepo sync

index-local:	## Re-index and sign for local testing
	@./scripts/abuild_index.sh local docker $(VERSION)

index:		## Re-index and sign for alpine.mbentley.net
	@./scripts/abuild_index.sh alpine.mbentley.net docker $(VERSION)

.PHONY: all help build build-local checksum tag abuild-local abuild syncrepo syncfromrepo sync syncall index-local index
