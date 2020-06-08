branch = $(shell git rev-parse --abbrev-ref HEAD)
export SSL_CERT_FILE = /etc/ssl/certs/ca-certificates.crt
export CURL_CA_BUNDLE = /etc/ssl/certs/ca-certificates.crt

.ONESHELL .PHONY: build up
.DEFAULT_GOAL := build

custom_ca:
ifdef CUSTOM_CA
	cp -rf $(CUSTOM_CA)/* ca_certificates/ || cp -f $(CUSTOM_CA) ca_certificates/
endif

build: custom_ca
	docker build . -t local/hive:$(branch)
	docker tag  local/hive:$(branch) local/hive:latest
up:
	vagrant up
down:
	vagrant destroy

