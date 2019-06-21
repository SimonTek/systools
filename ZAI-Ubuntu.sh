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

#	if grep -i "jessie" $OSVER; then
	if cat /etc/os-release| grep -i "jessie"; then
	echo "Debian Jessie Installed"
	wget http://repo.zabbix.com/zabbix/4.2/debian/pool/main/z/zabbix-release/zabbix-release_4.2-1%2Bjessie_all.deb
	dpkg -i zabbix-release*
	apt-get update
	apt-get install zabbix-agent -y
	echo "zabbix-agent has been installed"
	else
	echo "Debian Jessie Not Installed"
	fi
	
#	if grep -i "stretch" $OSVER; then
	if cat /etc/os-release| grep -i "stretch"; then
	echo "Debian Stretch Installed"
	wget http://repo.zabbix.com/zabbix/4.2/debian/pool/main/z/zabbix-release/zabbix-release_4.2-1%2Bstretch_all.deb
	dpkg -i zabbix-release*
	apt-get update
	apt-get install zabbix-agent -y
	echo "zabbix-agent has been installed"
	else
	echo "Debian Stretch Not Installed"
	fi

	if cat /etc/os-release| grep -i "Bionic"; then
	echo " Bionic 18.04 Installed"
        wget http://repo.zabbix.com/zabbix/4.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_4.2-1%2Bbionic_all.deb
	dpkg -i zabbix-release*
        apt-get update
        apt-get install zabbix-agent -y
        echo "zabbix-agent has been installed"
	else
	echo "Ubuntu Bionic Not Installed"
        fi
        
	if cat /etc/os-release| grep -i "Xenial"; then
        echo "Xenial 16.04 running"
	wget http://repo.zabbix.com/zabbix/4.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_4.2-1%2Bxenial_all.deb
	dpkg -i zabbix-release*
        apt-get update
        apt-get install zabbix-agent -y
        echo "zabbix-agent has been installed"
	else
	echo "Ubuntu Xenial Not Installed"
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
