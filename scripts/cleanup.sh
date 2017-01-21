#!/bin/bash -eux

GREEN='\033[1;32m'
RED='\033[0;31m'
NC='\033[0m'

printf "${GREEN}Updating installed packages${NC}\n"
yum -y update

printf "${GREEN}Clean system${NC}\n"
yum -y clean all

printf "${GREEN}Zeroing out free space on the device${NC}\n"
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

printf "${GREEN}Synchronizing so Packer doesn't quit before cleanup is finished${NC}\n"
sync
