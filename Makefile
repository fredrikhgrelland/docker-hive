branch = $(shell git rev-parse --abbrev-ref HEAD)

.ONESHELL .PHONY: build up down test prereq
.DEFAULT_GOAL := build

custom_ca:
ifdef CUSTOM_CA
	cp -rf $(CUSTOM_CA)/* ca_certificates/ || cp -f $(CUSTOM_CA) ca_certificates/
endif

prereq:
	apt update -y && apt upgrade -y
	apt -y install virtualbox vagrant

build: custom_ca
	docker build . -t local/hive:$(branch)
	docker tag  local/hive:$(branch) local/hive:latest

dev-mode:
	$(MAKE) -C ./template/test dev-mode

test:
	$(MAKE) -C ./template/test test

up: test

down:
	vagrant destroy -f