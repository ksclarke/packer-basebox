#!/bin/bash -eux

GREEN='\033[1;32m'
RED='\033[0;31m'
NC='\033[0m'

printf "${GREEN}Updating installed packages${NC}\n"
yum -y update

printf "${GREEN}Clean system${NC}\n"
yum -y clean all
