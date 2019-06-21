#!/bin/bash
#
#	Zabbix Agent installer for RT use
#	Matthew M. Conley	June 16, 2014 v1.0.0
# 	Updated: June 20, 2019 v2.0.1
#
#	Zabbix Client install and configure script. Change 127.0.0.1 and 127.0.0.2 to your Zabbix server IP's.

OSVER=/etc/os-release
#/etc/os-release

#cat /etc/os-release |grep VERSION_ID

echo "What is the IP to your Zabbix Server?:"
read IP
	if grep -i "release 6.[0-9]" /etc/redhat-release; then
	echo "RHEL 6 installed"
	rpm --import http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX
	rpm -Uvh http://repo.zabbix.com/zabbix/4.2/rhel/6/x86_64/zabbix-release-4.2-1.el6.noarch.rpm
	yum -y install zabbix-agent
	/etc/init./d/zabbix-agent restart
	echo "Zabbix agent on RHEL has been installed"
	else
	echo "RHEL 6 Not Installed"
	fi

	if grep -i "release 7.[0-9]" /etc/redhat-release; then
	echo "RHEL 7 installed"
	rpm --import http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX
	rpm -Uvh http://repo.zabbix.com/zabbix/4.2/rhel/7/x86_64/zabbix-release-4.2-1.el7.noarch.rpm
	yum -y install zabbix-agent 
	systemctl enable zabbix-agent
	echo "Zabbix agent on RHEL has been installed"
	else
	echo "RHEL 7 Not Installed"
	fi

# Configure the agent
echo "Configuring the agent"
if [ -f /etc/zabbix/zabbix_agentd.conf ]; then
cp /etc/zabbix/zabbix_agentd.conf /root/zabbix_agentd.old
sed -i 's/^Hostname=.*/Hostname='$HOSTNAME'/g' /etc/zabbix/zabbix_agentd.conf

# Check to see which IP is available
	if ping -c 1 $IP; then
	echo "We can connect to $IP"
	sed -i 's/^Server=.*/Server=$IP/g' /etc/zabbix/zabbix_agentd.conf
	else
	echo "Cannot Connect to server"
	fi

systemctl restart zabbix-agent
echo "Zabbix agent has been installed, and configured."
fi
