#!/bin/bash
set -e
echo "********************************************************"
echo "* OpenSSL 1.0.2e                                       *"
echo "********************************************************"
wget https://www.openssl.org/source/openssl-1.0.2e.tar.gz --no-check-certificate
sudo apt-get install zlib1g-dev
tar xfv openssl-1.0.2e.tar.gz
cd openssl-1.0.2e/
#sudo aptitude remove openssl libssl-dev -y
#./config --prefix=/usr
#./config --prefix=/usr         \
#         --openssldir=/etc/ssl \
#         --libdir=lib          \
#         shared                \
#         zlib-dynamic
./config shared                \
         zlib-dynamic

make
#make test
sudo make install
cd ..
echo "[ OK ]"

