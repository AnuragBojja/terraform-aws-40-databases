#!/bin/bash
set -e

service_name=$1
env=$2
#dnf install ansible -y
# python3 -m pip install boto3 botocore
# /usr/bin/python3 -m pip install boto3 botocore

REPO_URL=https://github.com/AnuragBojja/terraform-anisble-roboshop.git
REPO_DIR=/opt/terraform/ansible
VENV_DIR=$REPO_DIR/ansible-venv
ANSIBLE_DIR=terraform-anisble-roboshop

mkdir -p "$REPO_DIR"
mkdir -p /var/log/roboshoplogs
touch /var/log/roboshoplogs/ansible.log

dnf install python3 git -y

if [ ! -d "$VENV_DIR" ]; then
    python3 -m venv "$VENV_DIR"
fi

source $VENV_DIR/bin/activate
pip install ansible boto3 botocore

cd $REPO_DIR

if [ -d "$ANSIBLE_DIR" ]; then 
    cd "$ANSIBLE_DIR"
    git pull
else
    git clone "$REPO_URL"
    cd "$ANSIBLE_DIR"
fi 

$VENV_DIR/bin/ansible-playbook -e service_name=$service_name -e env=$env -e ansible_python_interpreter=$VENV_DIR/bin/python main.yaml