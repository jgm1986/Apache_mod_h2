#!/bin/bash
set -e

echo "********************************************************"
echo "* OPENSSL: 1.0.2g                                      *"
echo "********************************************************"
sudo apt-get install 	perl			\
			zlib1g-dev		\
			-y
wget https://www.openssl.org/source/openssl-1.0.2g.tar.gz --no-check-certificate
tar xfv openssl-1.0.2g.tar.gz
cd openssl-1.0.2g
./config shared                \
         zlib-dynamic
make depend
make
make test
sudo make install

cd ..
echo "[ OK ]"

