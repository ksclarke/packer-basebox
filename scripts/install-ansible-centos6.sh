#!/bin/bash -eux

GREEN='\033[1;32m'
RED='\033[0;31m'
NC='\033[0m'

printf "${GREEN}Installing EPEL repository${NC}\n"
yum -y install epel-release

printf "${GREEN}Installing Ansible and its dependencies${NC}\n"
yum -y install git python-setuptools gcc sudo libffi-devel python-devel openssl-devel ansible
