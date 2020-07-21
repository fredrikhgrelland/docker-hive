LAST_COMMIT_HASH = $(shell git rev-parse --verify HEAD)

.ONESHELL .PHONY: build up down test prereq
.DEFAULT_GOAL := build

custom_ca:
ifdef CUSTOM_CA
	cp -rf $(CUSTOM_CA)/* ca_certificates/ || cp -f $(CUSTOM_CA) ca_certificates/
endif

prereq:
	apt update -y && apt upgrade -y
	apt -y install virtualbox vagrant

build:
	docker build . -t fredrikhgrelland/hive:${LAST_COMMIT_HASH}
	docker tag fredrikhgrelland/hive:${LAST_COMMIT_HASH} fredrikhgrelland/hive:test

dev-mode:
	$(MAKE) -C ./template/test dev-mode

test:
	$(MAKE) -C ./template/test test

up: test

down:
	vagrant destroy -f