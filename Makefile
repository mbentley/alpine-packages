all: help

help:							## Show this help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

build-local:					## Build local packages for testing
	@cd ./main &&\
		cd docker-engine &&\
		abuild checksum && abuild -r -P /home/mbentley/packages/local &&\
		cd - &&\
		cd docker-engine-cs &&\
		abuild checksum && abuild -r -P /home/mbentley/packages/local

build-mbentley:					## Build packages for alpine.mbentley.net
	@cd ./main &&\
		cd docker-engine &&\
		abuild checksum && abuild -r -P /home/mbentley/packages/mbentley &&\
		cd - &&\
		cd docker-engine-cs &&\
		abuild checksum && abuild -r -P /home/mbentley/packages/mbentley

rsync:							## Rsync packages to athena
	@rsync -avh /home/mbentley/packages/mbentley/ athena:/var/www/alpine.mbentley.net/

reindex-local:					## Re-create and sign the local index
	@cd /home/mbentley/packages/local/main/x86_64 &&\
		apk index -o APKINDEX.tar.gz *.apk &&\
		abuild-sign APKINDEX.tar.gz

reindex-mbentley:				## Re-create and sign the mbentley index
	@cd /home/mbentley/packages/mbentley/main/x86_64 &&\
		apk index -o APKINDEX.tar.gz *.apk &&\
		abuild-sign APKINDEX.tar.gz

release: build-mbentley rsync	## Create release for alpine.mbentley.net

.PHONY: all help build-local build-mbentley rsync reindex-local reindex-mbentley
