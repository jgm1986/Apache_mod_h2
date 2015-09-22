#!/bin/bash
set -e
echo "********************************************************"
echo "* OpenSSL 1.0.2d                                       *"
echo "********************************************************"
wget https://www.openssl.org/source/openssl-1.0.2d.tar.gz --no-check-certificate
tar xfv openssl-1.0.2d.tar.gz
cd openssl-1.0.2d/
sudo aptitude remove openssl libssl-dev -y
./config --prefix=/usr
make
make test
sudo make install
cd ..
echo "[ OK ]"

