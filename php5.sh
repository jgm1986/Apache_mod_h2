#!/bin/bash
set -e
echo "********************************************************"
echo "* PHP 6.5.13                                           *"
echo "********************************************************"

wget http://es1.php.net/distributions/php-5.6.13.tar.gz
tar xfv php-5.6.13.tar.gz
cd php-5.6.13/
./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php --with-apxs2=~/apache2.5/bin/apxs --with-mysql --enable-ftp --disable-pdo --disable-ctype
make
#make test
sudo make install
cd ..
echo "[ OK ]"

