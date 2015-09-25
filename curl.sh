#!/bin/bash
set -e
echo "********************************************************"
echo "* cURL 7.44                                            *"
echo "********************************************************"

wget http://curl.haxx.se/download/curl-7.44.0.tar.gz
tar xfv curl-7.44.0.tar.gz
cd curl-7.44.0/
./buildconf
./configure --with-ssl=/usr
make
make test
sudo make install
cd ..
echo "[ OK ]"

