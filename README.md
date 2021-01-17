# Packer templates for Ubuntu

This repository contains [Packer](https://packer.io/) templates for creating Ubuntu Vagrant boxes.

## Dependencies

- [Packer](https://packer.io/)
- [Vagrant](https://vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [VagrantCloud](https://app.vagrantup.com)

## Building the Vagrant box with Packer

We make use of JSON files containing user variables to build specific versions of Ubuntu.

You tell `packer` to use a specific user variable file via the `-var-file=` command line
option.

This will override the default options on the core `ubuntu.json` packer template,
which builds Ubuntu 20.04 by default.

For example, to build Ubuntu 20.04 desktop, use the following:

```sh
packer build -var-file=ubuntu2004-desktop.json ubuntu.json
```

to add the generated box to vagrant cache

```sh
vagrant box add --name opsbot/ubuntu2004-desktop dist/ubuntu2004-desktop-20210116.0-virtualbox.box --force
```
