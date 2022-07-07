#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

curPath=`pwd`
rootPath=$(dirname "$curPath")
rootPath=$(dirname "$rootPath")
serverPath=$(dirname "$rootPath")
sourcePath=${serverPath}/source
sysName=`uname`
install_tmp=${rootPath}/tmp/mw_install.pl


#获取信息和版本
# bash /www/server/mdsever-web/scripts/getos.sh
bash ${rootPath}/scripts/getos.sh
OSNAME=`cat ${rootPath}/data/osname.pl`
VERSION_ID=`cat /etc/*-release | grep VERSION_ID | awk -F = '{print $2}' | awk -F "\"" '{print $2}'`

version=8.1.x
PHP_VER=81


Install_php()
{
#------------------------ install start ------------------------------------#
apt -y install php8.1 php8.1-fpm
if [ "$?" == "0" ];then
	mkdir -p $serverPath/php-apt/${PHP_VER}
fi

#------------------------ install end ------------------------------------#
}

Uninstall_php()
{
#------------------------ uninstall start ------------------------------------#
apt -y remove php8.1 php8.1-fpm
rm -rf $serverPath/php-apt/${PHP_VER}
echo "卸载php-${version}..." > $install_tmp
#------------------------ uninstall start ------------------------------------#
}

action=${1}
if [ "${1}" == 'install' ];then
	Install_php
else
	Uninstall_php
fi
