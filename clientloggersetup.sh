#!/bin/bash
#
# Script to configure clients for logging
#	Matthew M. Conley 06-18-2014
#		Updated 01-02-2015. v1.0.1
# 
# Replace 127.0.0.1 with your remote server IP.
#
# This script is for setting up remote logs for clients to the server. This script supports both rsyslog and syslog-ng
echo "Which port have you chosen to send the files to the Log Server?:"
read PORT

echo "Which IP Address is your log server?:"
read IP

	if [ -f /etc/syslog-ng/syslog-ng.conf ]; then
	echo "Syslog-ng has been found"
	cp /etc/syslog-ng/syslog-ng.conf /root/syslog-ng.conf.bak
		if grep "^destination loghost"  /etc/syslog-ng/syslog-ng.conf; then
		echo "Destination Loghost already exists"
			if grep "$IP" /etc/syslog-ng/syslog-ng.conf; then
			echo "Configured as needed. Nothing else to do"
			else
			echo "Adding IP address to range"
			sed -i "s@destination loghost.*@destination loghost { tcp("$IP" port($PORT)); };@g"  /etc/syslog-ng/syslog-ng.conf
			fi
		else
		echo "Destination loghost not found, adding parameters now"
		echo "destination loghost { tcp("$IP" port($PORT)); };" >> /etc/syslog-ng/syslog-ng.conf
		echo 'log { source(s_sys); destination(loghost); };' >>  /etc/syslog-ng/syslog-ng.conf
		cat /etc/syslog-ng/syslog-ng.conf
			if [ -f /etc/redhat-release ]; then
			systemctl enable syslog-ng
			fi
		systemctl restart syslog-ng
		fi
	else
	echo "syslog-ng not found"
	fi
	if [ -f /etc/rsyslog.conf ]; then
	echo "Rsyslog has been found"
	cp /etc/rsyslog.conf /root/rsyslog.conf.bak
		if grep  $IP /etc/rsyslog.conf|grep -v '^#'; then
		echo "rsyslog has been setup"
		else
		echo "ryslog hasn't been setup"
		echo "*.* @@$IP:$PORT" >> /etc/rsyslog.conf
			if [ -f /etc/redhat-release ]; then
			chkconfig rsyslog on
			systemctl enable rsyslog	
		fi
		systemctl restart rsyslog
		fi
	else
	echo "rsyslog not found"		
	fi
