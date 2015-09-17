#!/bin/bash
set -e
sudo apt-get install build-essential -y
echo "********************************************************"
echo "* Downloading data                                     *"
echo "********************************************************"
mkdir install
cd install
wget http://ftp.cixug.es/apache/apr/apr-1.5.2.tar.gz
wget http://ftp.cixug.es/apache//apr/apr-util-1.5.4.tar.gz
#wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre2-10.10.tar.gz
wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.36.tar.gz
wget http://ftp.cixug.es/apache//httpd/httpd-2.4.12.tar.gz
echo "[ OK ]"
echo "********************************************************"
echo "* Extracting                                           *"
echo "********************************************************"
tar zxvf httpd-2.4.12.tar.gz
#tar zxvf pcre2-10.10.tar.gz
tar zxvf pcre-8.36.tar.gz
tar zxvf apr-util-1.5.4.tar.gz
tar zxvf apr-1.5.2.tar.gz
echo "[ OK ]"
echo "********************************************************"
echo "* Installing: PCRE                                     *"
echo "********************************************************"
cd pcre-8.36
./configure --prefix=/home/sysadmin/pcre
sudo make
sudo make install
cd ..
echo "[ OK ]"
echo "********************************************************"
echo "* Copy: APR and APR-UTIL                               *"
echo "********************************************************"
mv apr-util-1.5.4 httpd-2.4.12/srclib/apr-util
mv apr-1.5.2 httpd-2.4.12/srclib/apr
echo "[ OK ]"
echo "********************************************************"
echo "* Installing: Apache                                   *"
echo "********************************************************"
cd httpd-2.4.12
./configure --prefix=/home/sysadmin/apache2.4 --with-included-apr --with-pcre=/home/sysadmin/pcre/bin/pcre-config
sudo make
sudo make install
cd ..
echo "[ OK ]"
echo "********************************************************"
echo "* Cloning Apache config file                           *"
echo "********************************************************"
cd /home/sysadmin/apache2.4/conf
sudo cp httpd.conf httpd.conf.orig
echo "[ OK ]"
echo "********************************************************"
echo "* Creating user and group                              *"
echo "********************************************************"
sudo useradd nobody
sudo groupadd nobody
echo "[ OK ]"
echo "********************************************************"
echo "* Modify the USER and GROUP from config file.          *"
echo "********************************************************"
echo "Now same user you have to configure in httpd.conf file:"
echo "      User nobody"
echo "      Group nobody"
echo "and the server IP and port parammeters:"
echo "      Listen 192.168.1.100:80"
echo "      ServerName 192.168.1.100:80"
read -rsp $'Press ENTER to continue...' -n1 key
sudo nano httpd.conf
echo "[ OK ]"
echo "********************************************************"
echo "* Testing config file.                                 *"
echo "********************************************************"
sudo /home/sysadmin/apache2.4/bin/apachectl -f /home/sysadmin/apache2.4/conf/httpd.conf -t
echo "[ OK ]"
echo "********************************************************"
echo "* Starting Apache                                      *"
echo "********************************************************"
sudo /home/sysadmin/apache2.4/bin/apachectl -f /home/sysadmin/apache2.4/conf/httpd.conf -k start
echo "[ OK ]"
exit 0
