all: help

help:		## Show this help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

tag:		## Create a new git tag
	@./scripts/create_tag.sh

abuild-local:	## Build packages for local testing
	@cd ./docker &&\
		cd docker-engine &&\
		abuild checksum && abuild -r -P /home/mbentley/packages/local &&\
		cd - &&\
		cd docker-engine-cs &&\
		abuild checksum && abuild -r -P /home/mbentley/packages/local

abuild:		## Build packages for alpine.mbentley.net
	@cd ./docker &&\
		cd docker-engine &&\
		abuild checksum && abuild -r -P /home/mbentley/packages/alpine.mbentley.net &&\
		cd - &&\
		cd docker-engine-cs &&\
		abuild checksum && abuild -r -P /home/mbentley/packages/alpine.mbentley.net

rsyncrepo:	## rsync metadata files from ./repo to the alpine.mbentley.net directory
	@rsync --delete -avh -f"- */" -f"+ *" ./repo/ /home/mbentley/packages/alpine.mbentley.net/

rsync:		## rsync packages to athena
	@rsync --delete-after -avh /home/mbentley/packages/alpine.mbentley.net/ athena:/var/www/alpine.mbentley.net/

rsyncall: 	## Run both rsyncrepo and rsync
rsyncall: rsyncrepo rsync

index-local:	## Re-index and sign for local testing
	@cd ./docker/docker-engine &&\
	  REPODEST=/home/mbentley/packages/local abuild index

index:		## Re-index and sign for alpine.mbentley.net
	@cd ./docker/docker-engine &&\
	  REPODEST=/home/mbentley/packages/alpine.mbentley.net abuild index

.PHONY: all help tag abuild-local abuild rsyncrepo rsync rsyncall index-local index
