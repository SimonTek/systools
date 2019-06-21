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
	if [ -f /etc/syslog-ng/syslog-ng.conf ]; then
	echo "Syslog-ng has been found"
	cp /etc/syslog-ng/syslog-ng.conf /root/syslog-ng.conf.bak
		if grep "^destination loghost"  /etc/syslog-ng/syslog-ng.conf; then
		echo "Destination Loghost already exists"
			if grep "127.0.0.1" /etc/syslog-ng/syslog-ng.conf; then
			echo "Configured as needed. Nothing else to do"
			else
			echo "Adding IP address to range"
			sed -i "s@destination loghost.*@destination loghost { tcp("127.0.0.1" port($PORT)); };@g"  /etc/syslog-ng/syslog-ng.conf
			fi
		else
		echo "Destination loghost not found, adding parameters now"
		echo "destination loghost { tcp("127.0.0.1" port($PORT)); };" >> /etc/syslog-ng/syslog-ng.conf
		echo 'log { source(s_sys); destination(loghost); };' >>  /etc/syslog-ng/syslog-ng.conf
		cat /etc/syslog-ng/syslog-ng.conf
			if [ -f /etc/redhat-release ]; then
			chkconfig syslog-ng on
			fi
		/etc/init.d/syslog-ng restart
		fi
	else
	echo "syslog-ng not found"
	fi
	if [ -f /etc/rsyslog.conf ]; then
	echo "Rsyslog has been found"
	cp /etc/rsyslog.conf /root/rsyslog.conf.bak
		if grep '*.* @@' /etc/rsyslog.conf|grep -v '^#'; then
		echo "rsyslog has been setup"
		else
		echo "ryslog hasn't been setup"
		echo "*.* @@127.0.0.1:$PORT" >> /etc/rsyslog.conf
			if [ -f /etc/redhat-release ]; then
			chkconfig rsyslog on
			fi
		/etc/init.d/rsyslog restart
		fi
	else
	echo "rsyslog not found"		
	fi
