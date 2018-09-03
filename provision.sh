#! /bin/bash
set -e
set -u
set -o pipefail

function install_ansible {
  apt-get -y install software-properties-common
  apt-get -y update
  apt-get -y upgrade
  apt-get -y install python-pip
  pip install ansible pyOpenSSL
}

install_ansible
