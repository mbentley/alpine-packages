VERSION ?= v1.13
HOME ?= /tmp

all: help

help:		## Show this help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

tag:		## Create a new git tag
	@./scripts/create_tag.sh

abuild-local:	## Build packages for local testing
	@cd ./pkgs/docker/$(VERSION) &&\
		cd docker-engine &&\
		abuild checksum && abuild -r -P $(HOME)/packages/local/docker &&\
		cd - &&\
		cd docker-engine-cs &&\
		abuild checksum && abuild -r -P $(HOME)/packages/local/docker

abuild:		## Build packages for alpine.mbentley.net
	@cd ./pkgs/docker/$(VERSION) &&\
		cd docker-engine &&\
		abuild checksum && abuild -r -P $(HOME)/packages/alpine.mbentley.net/docker &&\
		cd - &&\
		cd docker-engine-cs &&\
		abuild checksum && abuild -r -P $(HOME)/packages/alpine.mbentley.net/docker

rsyncrepo:	## rsync metadata files from ./repo to the alpine.mbentley.net directory
	@rsync --delete -avh -f"- */" -f"+ *" ./repo/ $(HOME)/packages/alpine.mbentley.net/

rsync:		## rsync packages to athena
	@rsync --delete-after -avh $(HOME)/packages/alpine.mbentley.net/ alpine_repo:/var/www/alpine.mbentley.net/

rsyncall: 	## Run both rsyncrepo and rsync
rsyncall: rsyncrepo rsync

index-local:	## Re-index and sign for local testing
	@cd ./pkgs/docker/$(VERSION)/docker-engine &&\
	  REPODEST=$(HOME)/packages/local/docker abuild index

index:		## Re-index and sign for alpine.mbentley.net
	@cd ./pkgs/docker/$(VERSION)/docker-engine &&\
	  REPODEST=$(HOME)/packages/alpine.mbentley.net/docker abuild index

.PHONY: all help tag abuild-local abuild rsyncrepo rsync rsyncall index-local index
