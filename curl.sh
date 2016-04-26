#!/bin/bash
set -e
echo "********************************************************"
echo "* cURL 7.48                                            *"
echo "********************************************************"

wget http://curl.haxx.se/download/curl-7.48.0.tar.gz --no-check-certificate
tar xfv curl-7.48.0.tar.gz
cd curl-7.48.0/
./buildconf
./configure --with-ssl=/usr
make
#make test
sudo make install
cd ..
echo "[ OK ]"

