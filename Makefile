
BOX_VERSION ?= $(shell cat VERSION)

all: build install

build: 
	packer build -var-file=ubuntu2004-desktop.json ubuntu.json

install:
	vagrant box add --name opsbot/ubuntu2004-desktop dist/ubuntu2004-desktop-$(BOX_VERSION)-virtualbox.box --force

clean:
	rm -rf dist/*

