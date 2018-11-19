#! /bin/bash
set -e
set -u
set -o pipefail

function prereqs_debian {
  apt-get -y install software-properties-common
  apt-get -y update
  apt-get -y upgrade
  apt-get -y install python-pip
}

function prereqs_centos {
  yum install -y epel-release
  yum update -y
  yum install -y python-pip
  mkdir -p /vagrant/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
  echo '%_topdir /vagrant/rpmbuild' > ~/.rpmmacros
}
if [ -f /etc/lsb-release ]
then
  prereqs_debian
else
  prereqs_centos
fi

pip install --upgrade pip
pip install ansible pyOpenSSL