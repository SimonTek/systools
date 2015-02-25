#!/bin/bash
#
# Matthew M. Conley SimonTek@gmail.com May 02, 2014
# v1.0.3 Jan 02, 2015
ARCH=`uname -i`

if [ -f /etc/debian_version ]; then
  echo "Error: Debian installed"
  exit 1
fi

if [ ! -f /etc/redhat-release ]; then
  echo "Error: /etc/redhat-release was not detected"
  exit 1
fi

if grep -i "release 6." /etc/redhat-release; then
echo "RHEL 6 is installed"
DIST="el6"
	if [ -f /etc/yum.repos.d/epel.repo ]; then
	echo "EPEL is already installed"
	else
	rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6
	rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
	fi
	if [ -f /etc/yum.repos.d/elrepo.repo ]; then
	echo "ELrepo is already installed"
	else
	rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
	rpm -Uvh http://www.elrepo.org/elrepo-release-6-6.el6.elrepo.noarch.rpm
	fi
	if [ -f /etc/yum.repos.d/rpmforge.repo ]; then
	echo "RPMForge is already installed"
	else
	rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt
	rpm -Uvh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
	fi
	#Zabbix	
	if [ -f /etc/yum.repos.d/zabbix.repo ]; then
	echo "Zabbix is already installed"
	else
	rpm --import http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX
	rpm -Uvh http://repo.zabbix.com/zabbix/2.2/rhel/6/x86_64/zabbix-release-2.2-1.el6.noarch.rpm
	fi
	#Puppet Labs	
	if [ -f /etc/yum.repos.d/puppet.repo ]; then
	echo "Puppet is already installed"
	else
	rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs
	rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-reductive
	rpm -Uvh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
	fi
yum update -y
	if rpm -qa |grep wget; then
	echo "wget installed"
	else
	yum install -y wget
	fi

	if [ -f /etc/yum.repo.d/atomic.repo ]; then
	echo "Atomic is installed"
	else
	#wget -q -O - http://www.atomicorp.com/installers/atomic |sh
	rpm -Uvh https://www6.atomicorp.com/channels/atomic/centos/6/x86_64/RPMS/atomic-release-1.0-19.el6.art.noarch.rpm
	fi

else
echo "RHEL 6 is not installed"
fi
	 
if grep -i "release 5." /etc/redhat-release; then
echo "RHEL 5 is installed"
DIST="el5"
	if [ -f /etc/yum.repos.d/epel.repo ]; then
	echo "EPEL is already installed"
	else
	rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-5
	rpm -Uvh http://dl.fedoraproject.org/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm
	fi

	if [ -f /etc/yum.repos.d/elrepo.repo ]; then
	echo "EPEL is already installed"
	else
	rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
	rpm -Uvh http://www.elrepo.org/elrepo-release-5-5.el5.elrepo.noarch.rpm
	fi
	#Zabbix
	if [ -f /etc/yum.repos.d/zabbix.repo ]; then
	echo "Zabbix is already installed"
	else
	rpm --import http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX
	rpm -Uvh http://repo.zabbix.com/zabbix/2.2/rhel/5/x86_64/zabbix-release-2.2-1.el5.noarch.rpm
	fi
	#RPMForge
	if [ -f /etc/yum.repos.d/rpmforge.repo ]; then
	echo "RPMForge is already installed"
	else
	rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt
	rpm -Uvh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el5.rf.$ARCH.rpm
	fi
	#Puppet Labs	
	if [ -f /etc/yum.repos.d/puppet.repo ]; then
	echo "Puppet is already installed"
	else
	rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs
	rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-reductive
	rpm -Uvh http://yum.puppetlabs.com/puppetlabs-release-el-5.noarch.rpm
	fi

yum update
else
echo "RHEL 5 is not installed"
fi

if grep -i "release 4." /etc/redhat-release; then
echo "RHEL 4 is installed"
DIST="el4"
#rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-4
rpm --import https://www.atomicorp.com/RPM-GPG-KEY.art.txt
rpm -Uvh http://dl.fedoraproject.org/pub/epel/4AS/x86_64/epel-release-4-10.noarch.rpm
rpm -Uvh http://www3.atomicorp.com/channels/atomic/centos/4/x86_64/RPMS/atomic-release-1.0-14.el4.art.noarch.rpm
yum update
else
echo "RHEL 4 is not installed"
fi

if grep -i "release 7." /etc/redhat-release; then
DIST="el7"
echo "RHEL 7 is installed"
	if [ -f /etc/yum.repos.d/epel.repo ]; then
	echo "EPEL is already installed"
	else
	rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7
	rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
	fi
	if [ -f /etc/yum.repos.d/elrepo.repo ]; then
	echo "ELrepo is already installed"
	else
	rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
	rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
	fi
	if [ -f /etc/yum.repos.d/puppet.repo ]; then
	echo "Puppet is already installed"
	else
	rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs
	rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-reductive
	rpm -Uvh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
	fi

	if [ -f /etc/yum.repo.d/atomic.repo ]; then
	echo "Atomic is installed"
	else
	rpm -Uvh https://www6.atomicorp.com/channels/atomic/redhat/7/x86_64/RPMS/atomic-release-1.0-19.el7.art.noarch.rpm	

fi

else
echo "RHEL 7 is not installed"
fi



# wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
# wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
# 
