#!/bin/bash
#
#	Zabbix Agent installer for RT use
#	Matthew M. Conley	June 16, 2014 v1.0.0
#	Updated: Jan 02, 2014 v1.0.1
#
#	Zabbix Client install and configure script. Change 127.0.0.1 and 127.0.0.2 to your Zabbix server IP's.

RHVER=/etc/redhat-release
DVER=/etc/debian_version
ETH0=127.0.0.1
ETH1=127.0.0.2

if [ -f $DVER ]; then
echo "Debian Installed"
	if grep "7." $DVER; then
	wget http://repo.zabbix.com/zabbix/2.4/debian/pool/main/z/zabbix-release/zabbix-release_2.4-1+wheezy_all.deb
	dpkg -i zabbix-release_2.4-1+wheezy_all.deb

	apt-get update
	apt-get install zabbix-agent -y
	echo "zabbix-agent has been installed"
	rm -rf ./zabbix-release_2.4-1+wheezy_all.deb
	fi
	if grep "6." $DVER; then
	dpkg -i http://repo.zabbix.com/zabbix/2.2/debian/pool/main/z/zabbix-release/zabbix-release_2.2-1+squeeze_all.deb	
	apt-get update
	apt-get install zabbix-agent -y
	echo "zabbix-agent has been installed"
	rm -rf ./zabbix-release_2.2-1+squeeze_all.deb
	fi
	### Ubuntu Release: http://repo.zabbix.com/zabbix/2.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_2.4-1+trusty_all.deb
fi


if [ -f $RHVER ]; then
echo "RHEL Installed"
	rpm --import http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX
	if grep -i "release 5." $RHVER; then
	echo "RHEL 5 Installed"
	rpm -Uvh http://repo.zabbix.com/zabbix/2.4/rhel/5/x86_64/zabbix-release-2.4-1.el5.noarch.rpm
	fi
	if grep -i "release 6." $RHVER; then
	echo "RHEL 6 installed"
	rpm -Uvh http://repo.zabbix.com/zabbix/2.4/rhel/6/x86_64/zabbix-release-2.4-1.el6.noarch.rpm
	fi

	if grep -i "release 7." $RHVER; then
	echo "RHEL 7 installed"
	rpm -Uvh http://repo.zabbix.com/zabbix/2.4/rhel/7/x86_64/zabbix-release-2.4-1.el7.noarch.rpm
	fi
yum install zabbix-agent -y
echo "Zabbix agent on RHEL has been installed"
chkconfig zabbix-agent on
fi

# Configure the agent
if [ -f /etc/zabbix/zabbix_agentd.conf ]; then
cp /etc/zabbix/zabbix_agentd.conf /root/zabbix_agentd.old
sed -i 's/^Hostname=.*/Hostname='$HOSTNAME'/g' /etc/zabbix/zabbix_agentd.conf

# Check to see which IP is available
	if ping -c 1 $ETH1; then
	echo "We can connect to 127.0.0.2."
	sed -i 's/^Server=.*/Server=127.0.0.2/g' /etc/zabbix/zabbix_agentd.conf
	else
	echo "Not the same network, will try public next"
	fi

	if ping -c 1 $ETH0; then
	echo "We can connect to the zabbix server"
	sed -i 's/^Server=.*/Server=127.0.0.1/g' /etc/zabbix/zabbix_agentd.conf
	else
	echo "Connections have failed. See Admin"
	fi

/etc/init.d/zabbix-agent restart
echo "Zabbix agent has been installed, and configured."
fi
