        if [ -f /etc/yum.repos.d/epel.repo ]; then
        echo "EPEL is already installed"
        else
	echo "EPEL 8 Does not exist yet"
        rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-8
        rpm -Uvh https://dl.fedoraproject.org/pub/epel/8/x86_64/Packages/e/epel-release-8.noarch.rpm
	fi

        if [ -f /etc/yum.repos.d/elrepo.repo ]; then
        echo "ELrepo is already installed"
        else
        rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
	rpm -Uvh https://www.elrepo.org/elrepo-release-8.0-1.el8.elrepo.noarch.rpm
        fi

        if [ -f /etc/yum.repos.d/remi.repo ]; then
        echo "Remi is already installed"
        else
        rpm --import https://rpms.remirepo.net/RPM-GPG-KEY-remi
        rpm -Uvh http://repo1.sea.innoscale.net/remi/enterprise/remi-release-8.rpm
        fi
        
	if [ -f /etc/yum.repos.d/puppet.repo ]; then
        echo "Puppet is already installed"
        else
        rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs
        rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-reductive
        rpm -Uvh http://yum.puppetlabs.com/puppet-enterprise-tools-release-el-8.noarch.rpm
	rpm -Uvh http://yum.puppetlabs.com/puppet-release-el-8.noarch.rpm
        fi

        if [ -f /etc/yum.repo.d/atomic.repo ]; then
        echo "Atomic is installed"
        else
	rpm -Uvh https://www6.atomicorp.com/channels/atomic/redhat/8/x86_64/RPMS/atomic-release-1.0-21.el8.art.noarch.rpm
        fi


