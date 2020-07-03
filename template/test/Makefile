.ONESHELL .PHONY: dev-mode test clean
.DEFAULT_GOAL := test

dev-mode:
	vagrant up --no-provision

test:
	vagrant destroy -f
	vagrant up --provision

clean:
	vagrant destroy -f
	rm -rf .vagrant