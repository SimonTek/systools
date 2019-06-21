#!/bin/bash
ARCH=`uname -i`

if [ -f /etc/debian_version ]; then
  echo "Error: Debian installed"
  exit 1
fi

if [ ! -f /etc/redhat-release ]; then
  echo "Error: /etc/redhat-release was not detected"
  exit 1
fi

if grep -i "release 7." /etc/redhat-release; then
DIST="el7"
echo "RHEL 7 is installed"
	if [ -f /etc/yum.repos.d/epel.repo ]; then
	echo "EPEL is already installed"
	else
	rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7
	rpm -Uvh https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
	fi

	if [ -f /etc/yum.repos.d/elrepo.repo ]; then
	echo "ELrepo is already installed"
	else
	rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
	rpm -Uvh https://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
	fi

	if [ -f /etc/yum.repos.d/remi.repo ]; then
	echo "Remi is already installed"
	else
	rpm --import https://rpms.remirepo.net/RPM-GPG-KEY-remi
	rpm --import https://rpms.remirepo.net/RPM-GPG-KEY-remi2018
	rpm -Uvh http://repo1.sea.innoscale.net/remi/enterprise/remi-release-7.rpm
	fi
	if [ -f /etc/yum.repos.d/puppet.repo ]; then
	echo "Puppet is already installed"
	else
	rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs
	rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-reductive
#	rpm -Uvh http://yum.puppetlabs.com/puppet6-release-el-7.noarch.rpm
	rpm -Uvh http://yum.puppetlabs.com/puppet-release-el-7.noarch.rpm
	fi

	if [ -f /etc/yum.repo.d/atomic.repo ]; then
	echo "Atomic is installed"
	else
	rpm -Uvh https://www6.atomicorp.com/channels/atomic/redhat/7/x86_64/RPMS/atomic-release-1.0-21.art.noarch.rpm
	fi
else
echo "RHEL 7 is not installed"
fi


