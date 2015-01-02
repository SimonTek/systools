#!/bin/bash
#
# Debian Repo Installer 
#	Matthew Conley 070214
#	updated 010215
#	Script to add Debian Repo's.
if [ ! -f /etc/debian_version ]; then
  echo "Error: /etc/debian_version was not detected"
  exit 1
fi
	# Zabbix repo
	if grep -i "wheezy" /etc/os-release; then
	echo "Debian 7 Wheezy"
	dpkg -i	http://repo.zabbix.com/zabbix/2.2/debian/pool/main/z/zabbix-release/zabbix-release_2.2-1+wheezy_all.deb
	fi

	if grep -i "squeeze" /etc/os-release; then
	echo "Debian 6 Squeeze"
	dpkg -i http://repo.zabbix.com/zabbix/2.2/debian/pool/main/z/zabbix-release/zabbix-release_2.2-1+squeeze_all.deb
	fi
done
