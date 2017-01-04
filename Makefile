all: help

help:		## Show this help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

tag:		## Create a new git tag
	@./scripts/create_tag.sh

abuild-local:	## Build packages for local testing
	@cd ./main &&\
		cd docker-engine &&\
		abuild checksum && abuild -r -P /home/mbentley/packages/local &&\
		cd - &&\
		cd docker-engine-cs &&\
		abuild checksum && abuild -r -P /home/mbentley/packages/local

abuild:		## Build packages for alpine.mbentley.net
	@cd ./main &&\
		cd docker-engine &&\
		abuild checksum && abuild -r -P /home/mbentley/packages/alpine.mbentley.net &&\
		cd - &&\
		cd docker-engine-cs &&\
		abuild checksum && abuild -r -P /home/mbentley/packages/alpine.mbentley.net

rsyncrepo:	## rsync metadata files from ./repo to the alpine.mbentley.net directory
	@rsync --delete -avh -f"- */" -f"+ *" ./repo/ /home/mbentley/packages/alpine.mbentley.net/

rsync:		## rsync packages to athena
	@rsync --delete -avh /home/mbentley/packages/alpine.mbentley.net/ athena:/var/www/alpine.mbentley.net/

rsyncall: 	## Run both rsyncrepo and rsync
rsyncall: rsyncrepo rsync

index-local:	## Re-index and sign for local testing
	@cd /home/mbentley/packages/local/main/x86_64 &&\
		apk index -o APKINDEX.tar.gz *.apk &&\
		abuild-sign APKINDEX.tar.gz

index:		## Re-index and sign for alpine.mbentley.net
	@cd /home/mbentley/packages/alpine.mbentley.net/main/x86_64 &&\
		apk index -o APKINDEX.tar.gz *.apk &&\
		abuild-sign APKINDEX.tar.gz

.PHONY: all help tag abuild-local abuild rsyncrepo rsync rsyncall index-local index
