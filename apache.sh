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

# Changes for old OpenSSL
cd /lib/x86_64-linux-gnu
sudo mv /usr/bin/openssl /usr/bin/openssl.old
sudo mv /usr/include/openssl /usr/include/openssl.old
sudo ln -s /usr/local/ssl/bin/openssl /usr/bin/openssl
sudo ln -s /usr/local/ssl/include/openssl /usr/include/openssl
sudo ldconfig -v
sudo mv -f libssl.so.1.0.0 libssl.so.1.0.0.old
sudo mv -f libcrypto.so.1.0.0 libcrypto.so.1.0.0.old
sudo ln -s /usr/local/ssl/lib/libssl.so.1.0.0 libssl.so.1.0.0
sudo ln -s /usr/local/ssl/lib/libcrypto.so.1.0.0 libcrypto.so.1.0.0
sudo sh -c "echo '/usr/local/ssl/lib' >> /etc/ld.so.conf"
sudo ldconfig -v
downloads_dir="$pwd_dir/downloads"
cd $downloads_dir

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
sudo apt-get install libpcre3-dev -y
./buildconf
./configure --with-included-apr --prefix=$HOME/apache2.5 --enable-mpms-shared=all --with-crypto --enable-ssl --with-ssl=/usr --enable-h2 --with-nghttp2
make
sudo make install

# PHP 5
php5_sh="$pwd_dir/php5.sh"
sh $php5_sh

# Starting Apache
sudo $HOME/apache2.5/bin/apachectl start
echo "Done!"
exit 0
