branch = $(shell git rev-parse --abbrev-ref HEAD)

.ONESHELL .PHONY: build
.DEFAULT_GOAL := build

custom_ca:
ifdef CUSTOM_CA
	cp -rf $(CUSTOM_CA)/* ca_certificates/ || cp -f $(CUSTOM_CA) ca_certificates/
endif

build: custom_ca
	docker build . -t local/hive:$(branch)
	docker tag  local/hive:$(branch) local/hive:latest

