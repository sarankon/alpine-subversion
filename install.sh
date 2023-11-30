#!/bin/sh

apk add openrc
openrc boot

apk add subversion
apk add apache2 apache2-utils apache2-webdav mod_dav_svn

cd /etc/apache2/conf.d/
wget https://raw.githubusercontent.com/sarankon/alpine-subversion/main/etc/apache2/conf.d/subversion.conf

cd /home
wget https://raw.githubusercontent.com/sarankon/alpine-subversion/main/utils.sh

mv utils.sh svn-utils.sh
chmod +x svn-utils.sh

