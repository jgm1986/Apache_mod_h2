#!/bin/bash
set -e
sudo apt-get install build-essential subversion -y
echo "********************************************************"
echo "* Downloading data                                     *"
echo "********************************************************"
pwd_dir=$(pwd)
echo $pwd_dir
if [ -d downloads ] ; then
	echo " Deleting apache download folder..."
	sudo rm -r downloads
	echo "[ OK ]"
	echo "Continue downloading data..."
fi
mkdir downloads
cd downloads

# OpenSSL
openssl_sh="$pwd_dir/openssl.sh"
echo $openssl_sh
sh $openssl_sh

# NGHTTP2
nghttp2_sh="$pwd_dir/nghttp2.sh"
echo $nghttp2_sh
sh $nghttp2_sh

# cURL
curl_sh="$pwd_dir/curl.sh"
echo $curl_sh
sh $curl_sh

# Apache 2.5-DEV
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
#./configure --with-included-apr --prefix=/home/sysadmin/apache2.5 --enable-h2 --enable-http2 --with-nghttp2=/home/sysadmin/Apache_mod_h2/downloads/nghttp2-1.3.2/lib/.libs/libnghttp2.so.14
./configure --with-included-apr --prefix=/home/sysadmin/apache2.5 --enable-mpms-shared=all --with-crypto --enable-ssl --with-ssl=/usr --enable-h2 --with-nghttp2=/home/sysadmin/Apache_mod_h2/downloads/nghttp2-1.3.2/lib/.libs/libnghttp2.so.14
make
sudo make install

# PHP 5
php5_sh="$pwd_dir/php5.sh"
sh $php5_sh
sudo /home/sysadmin/apache2.5/bin/apachectl start
echo "Done!"
exit 0
