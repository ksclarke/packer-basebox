# A Packer built base box

## Introduction

To build just the VirtualBox base box, run:

    packer build -only=virtualbox-centos6 basebox.json

To build just the VMWare base box, run:

    packer build -only=vmware-centos6 basebox.json

To build just the RHEL base box:

* Go to [RHEL 6.8 download](https://access.redhat.com/downloads/content/69/ver=/rhel---6/6.8/x86_64/product-software) and download the DVD ISO
* Put the ISO in a /iso directory on your file system

Then run:

    RHN_USERNAME="YOUR_RHN_USERNAME" RHN_PASSWORD="YOUR_RHN_PASSWORD" packer build -only="virtualbox-rhel6" basebox.json
