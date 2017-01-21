#!/bin/bash -eux

GREEN='\033[1;32m'
RED='\033[0;31m'
NC='\033[0m'

printf "${GREEN}Registering with RHN subscription manager${NC}\n"
subscription-manager register --auto-attach --username=${RHN_USERNAME} --password=${RHN_PASSWORD} --force

printf "${GREEN}Installing EPEL repository${NC}\n"
EL_VERSION={{ user `el-6x-version` }}
rpm -ivh http://dl.fedoraproject.org/pub/epel/6/$(uname -i)/epel-release-${EL_VERSION/./-}.noarch.rpm
yum --disablerepo=epel -y check-update ca-certificates; (($?==100)) && yum --disablerepo=epel -y update ca-certificates || yum --disablerepo=epel -y reinstall ca-certificates
yum -y repolist

printf "${GREEN}Installing Ansible and its dependencies${NC}\n"
yum -y install git python-setuptools gcc sudo libffi-devel python-devel openssl-devel ansible
