# A Packer.io Built Basebox [![Build Status](https://travis-ci.org/ksclarke/packer-basebox.svg?branch=master)](https://travis-ci.org/ksclarke/packer-basebox)

## Introduction

This basebox is intended to be used by other projects not wanting to start from scratch. It installs:

* Ansible
* Javac
* Maven
* Vagrant (if using VirtualBox or VMWare)

The possible build artifacts are:

* VirtualBox Vagrant box
* VirtualBox OVA file
* VMWare Vagrant box
* VMWare OVA file
* Docker container

Different input sources can also be used:

* CentOS 6
* RHEL 6

The build can be run to store its artifacts in Atlas and/or DockerHub, or to leave them on the local file system. If it's desired to store the artifacts in Atlas, additional configuration information must be supplied in the form of system environmental variables. These can be put in a system configuration file (e.g., `~/.profile`) or can be supplied on the command line. These variables are:

    ATLAS_USERNAME="YOUR_ATLAS_USERNAME"
    ATLAS_TOKEN="YOUR_ATLAS_TOKEN"

If the desired input source is RHEL-based, RedHat Network credentials will also be needed to initialize the OS so that packages can be downloaded. These can be supplied through system configuration file or on the command line; they are:

    RHN_USERNAME="YOUR_RHN_USERNAME"
    RHN_PASSWORD="YOUR_RHN_PASSWORD"

You'll also need to download the [RHEL 6.8 DVD ISO](https://access.redhat.com/downloads/content/69/ver=/rhel---6/6.8/x86_64/product-software) ahead of time if you want to use the RHEL source. So that the Packer configuration can find it, please download it and put it in an `/iso` directory on your file system.

## Using the Basebox

If you're just interested in using the basebox, you don't have to build it yourself. You can use the [Vagrant boxes published on Atlas](docs/vagrant.md) or one of the [VirtualBox or VMWare OVA files](docs/ova.md). If you want to use a Docker image, that's [available from DockerHub](docs/dockerhub.md).

## Building the Basebox

#### Running the build locally on your machine

To build just the CentOS 6 VirtualBox basebox, run:

    scripts/packer virtualbox-centos6

To build just the CentOS 6 VMWare basebox, run:

    scripts/packer vmware-centos6

To build just the RHEL 6 VirtualBox basebox, run:

    scripts/packer virtualbox-rhel6

To build just the RHEL 6 VMWare basebox, run:

    scripts/packer vmware-rhel6

To build just the CentOS 6 Docker basebox and store it in your local Docker repo, run:

    scripts/packer docker-centos6 [YOUR_DOCKER_USERNAME]

#### Building and storing artifacts remotely in Atlas and/or DockerHub

To build just the CentOS 6 VirtualBox basebox, run:

    packer build -only="virtualbox-centos6" basebox.json

To build just the CentOS 6 VMWare basebox, run:

    packer build -only="vmware-centos6" basebox.json

To build just the RHEL 6 VirtualBox basebox, run:

    packer build -only="virtualbox-rhel6" basebox.json

To build just the RHEL 6 VMWare basebox, run:

    packer build -only="vmware-rhel6" basebox.json

To build just the CentOS 6 Docker basebox, run:

    DOCKER_USER="YOUR_DOCKER_USERNAME" packer build -only="docker-centos6" basebox.json

#### Testing VirtualBox and VMWare build artifacts

**A little wrapper script can be used to test new artifacts.**

To run just the CentOS 6 VirtualBox basebox:

    tests/vagrant virtualbox-centos6 up

To run just the CentOS 6 VMWare basebox:

    tests/vagrant vmware-centos6 up

To run just the RHEL 6 VirtualBox basebox:

    tests/vagrant virtualbox-rhel6 up

To run just the RHEL 6 VMWare basebox:

    tests/vagrant vmware-rhel6 up

**It's also possible to SSH in to the test instance to poke around.**

To SSH into the test CentOS 6 VirtualBox basebox:

    tests/vagrant virtualbox-centos6 ssh

To SSH into the test CentOS 6 VMWare basebox:

    tests/vagrant vmware-centos6 ssh

To SSH into the test RHEL 6 VirtualBox basebox:

    tests/vagrant virtualbox-rhel6 ssh

To SSH into the test RHEL 6 VMWare basebox:

    tests/vagrant vmware-rhel6 ssh
    
**Destroy the test instance to clean up its system resources.**

To destroy the test CentOS 6 VirtualBox basebox:

    tests/vagrant virtualbox-centos6 destroy

To destroy the test CentOS 6 VMWare basebox:

    tests/vagrant vmware-centos6 destroy

To destroy the test RHEL 6 VirtualBox basebox:

    tests/vagrant virtualbox-rhel6 destroy

To destroy the test RHEL 6 VMWare basebox:

    tests/vagrant vmware-rhel6 destroy

## License

BSD 3-Clause

## Contact

If you have questions about packer-basebox feel free to ask them on the FreeLibrary Projects [mailing list](https://groups.google.com/forum/#!forum/freelibrary-projects); or, if you encounter a problem, please feel free to [open an issue](https://github.com/ksclarke/packer-basebox/issues "GitHub Issue Queue") in the project's issue queue.
