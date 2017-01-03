all: help

help:		## Show this help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

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

repocopy:	## copies metadata files from ./repo to the alpine.mbentley.net directory
	@cp -av ./repo/* /home/mbentley/packages/alpine.mbentley.net/

rsync:		## rsync packages to athena
	@rsync --delete -avh /home/mbentley/packages/alpine.mbentley.net/ athena:/var/www/alpine.mbentley.net/

index-local:	## Re-index and sign for local testing
	@cd /home/mbentley/packages/local/main/x86_64 &&\
		apk index -o APKINDEX.tar.gz *.apk &&\
		abuild-sign APKINDEX.tar.gz

index:		## Re-index and sign for alpine.mbentley.net
	@cd /home/mbentley/packages/alpine.mbentley.net/main/x86_64 &&\
		apk index -o APKINDEX.tar.gz *.apk &&\
		abuild-sign APKINDEX.tar.gz

.PHONY: all help abuild-local abuild repocopy rsync index-local index
