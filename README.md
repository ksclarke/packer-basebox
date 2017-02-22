# A Packer built base box

## Introduction

A Packer.io build for my baseboxes. Currently artifacts are pushed to Atlas, so the following login information needs to be in the system environment:

    ATLAS_USERNAME="YOUR_ATLAS_USERNAME"
    ATLAS_TOKEN="YOUR_ATLAS_TOKEN"

It can be supplied on the command line or put into a `.profile` file. I'll fix the build soon to make the push to Atlas optional. This is a work in progress.

## Building the Basebox

To build just the CentOS 6 VirtualBox basebox, run:

    packer build -only=virtualbox-centos6 basebox.json

To build just the CentOS 6 VMWare basebox, run:

    packer build -only=vmware-centos6 basebox.json

To build just the RHEL 6 VirtualBox basebox:

* Go to [RHEL 6.8 download](https://access.redhat.com/downloads/content/69/ver=/rhel---6/6.8/x86_64/product-software) and download the DVD ISO
* Put the ISO in a /iso directory on your file system

Then run:

    RHN_USERNAME="YOUR_RHN_USERNAME" RHN_PASSWORD="YOUR_RHN_PASSWORD" \
    packer build -only="virtualbox-rhel6" basebox.json
