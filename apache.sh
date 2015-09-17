#!/bin/bash
set -e
sudo apt-get install build-essential subversion -y
echo "********************************************************"
echo "* Downloading data                                     *"
echo "********************************************************"
if [ -d downloads ] ; then
	echo " Deleting apache download folder..."
	rm -r downloads
	echo "[ OK ]"
	echo "Continue downloading data..."
fi
mkdir downloads
cd downloads
echo ">>Download Apache 2.5 trunk."
svn checkout http://svn.apache.org/repos/asf/httpd/httpd/trunk httpd-trunk
cd httpd-trunk
echo ">>Download APR."
svn co http://svn.apache.org/repos/asf/apr/apr/trunk srclib/apr
echo "[ OK ]"

echo "********************************************************"
echo "* Installing: Apache                                   *"
echo "********************************************************"
./buildconf
./configure --with-included-apr --prefix=/home/sysadmin/apache2.5
make
sudo make install
sudo /usr/local/apache2/bin/apachectl start
