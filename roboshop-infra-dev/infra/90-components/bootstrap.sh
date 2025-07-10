#!/bin/bash

component=$1
env=$2
dnf install ansible -y
ansible-pull -U https://github.com/kkumar-2655/ansible-roboshop-roles-tf.git -e component=$1 -e env=$2 roles/main.yaml

# #!/bin/bash
# set -xe  # Debug mode: fail fast and print each command

# component=$1
# env=$2

# # Install Ansible
# dnf install ansible -y

# # Pull Ansible roles from GitHub
# ansible-pull -U https://github.com/kkumar-2655/ansible-roboshop-roles-tf.git -e component=$component -e env=$env main.yaml
