#!/bin/bash

service_name=$1
env=$2
dnf install ansible -y
# python3 -m pip install boto3 botocore
/usr/bin/python3 -m pip install boto3 botocore

REPO_URL=https://github.com/AnuragBojja/terraform-anisble-roboshop.git
REPO_DIR=/opt/terraform/ansible
ANSIBLE_DIR=terraform-anisble-roboshop

mkdir -p $REPO_DIR
mkdir -p /var/log/roboshoplogs
touch /var/log/roboshoplogs/ansible.log

cd $REPO_DIR

if [ -d $ANSIBLE_DIR ]; then 
    cd $ANSIBLE_DIR
    git pull
else
    git clone $REPO_URL
    cd $ANSIBLE_DIR
fi 

ansible-playbook -e service_name=$service_name -e env=$env main.yaml