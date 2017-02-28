VERSION ?= v1.13
HOME ?= /tmp

all: help

help:		## Show this help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

build-local:	## Run tag, abuild, syncfromrepo, and syncall
build-local: checksum abuild-local

build:          ## Run tag, abuild, syncfromrepo, and syncall
build: tag syncfromrepo checksum abuild syncall

tag:		## Create a new git tag
	@./scripts/create_tag.sh

checksum:	## Generate checksums for files in APKBUILD files
	@cd ./pkgs/docker/$(VERSION) &&\
		cd docker-engine &&\
		abuild checksum &&\
		cd - &&\
		cd docker-engine-cs &&\
		abuild checksum

abuild-local:	## Build packages for local testing
	@cd ./pkgs/docker/$(VERSION) &&\
		cd docker-engine &&\
		abuild -r -P $(HOME)/packages/local/docker &&\
		cd - &&\
		cd docker-engine-cs &&\
		abuild -r -P $(HOME)/packages/local/docker

abuild:		## Build packages for alpine.mbentley.net
	@cd ./pkgs/docker/$(VERSION) &&\
		cd docker-engine &&\
		abuild -r -P $(HOME)/packages/alpine.mbentley.net/docker &&\
		cd - &&\
		cd docker-engine-cs &&\
		abuild -r -P $(HOME)/packages/alpine.mbentley.net/docker

syncrepo:	## rsync metadata files from ./repo to the alpine.mbentley.net directory
	@rsync --delete -avh -f"- */" -f"+ *" ./repo/ $(HOME)/packages/alpine.mbentley.net/

syncfromrepo:   ## rsync from repository to local
	@rsync -avh alpine_repo:/var/www/alpine.mbentley.net/ $(HOME)/packages/alpine.mbentley.net/

sync:		## rsync packages to alpine.mbentley.net
	@rsync --delete-after -avh $(HOME)/packages/alpine.mbentley.net/ alpine_repo:/var/www/alpine.mbentley.net/

syncall: 	## Run both syncrepo and sync
syncall: syncrepo sync

index-local:	## Re-index and sign for local testing
	@cd ./pkgs/docker/$(VERSION)/docker-engine &&\
	  REPODEST=$(HOME)/packages/local/docker abuild index

index:		## Re-index and sign for alpine.mbentley.net
	@cd ./pkgs/docker/$(VERSION)/docker-engine &&\
	  REPODEST=$(HOME)/packages/alpine.mbentley.net/docker abuild index

.PHONY: all help build build-local checksum tag abuild-local abuild syncrepo syncfromrepo sync syncall index-local index
