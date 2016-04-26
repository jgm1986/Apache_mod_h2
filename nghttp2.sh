#!/bin/bash
set -e

echo "********************************************************"
echo "* NGHTTP2: 1.9.2                                       *"
echo "********************************************************"
sudo apt-get install 	gcc			\
			sphinx3			\
			libjansson-dev		\
			libboost-dev		\
			libboost-thread-dev	\
			g++			\
			make 			\
			binutils 		\
			autoconf 		\
			automake		\
			autotools-dev 		\
			libtool 		\
			pkg-config 		\
			zlib1g-dev		\
			libcunit1-dev 		\
			libssl-dev 		\
			libxml2-dev 		\
			libev-dev 		\
			libevent-dev 		\
			libjansson-dev 		\
			libjemalloc-dev 	\
			cython 			\
			python3-dev 		\
			python-setuptools	\
			-y
wget https://github.com/nghttp2/nghttp2/releases/download/v1.9.2/nghttp2-1.9.2.tar.gz --no-check-certificate
tar xfv nghttp2-1.9.2.tar.gz
cd nghttp2-1.9.2/
export PKG_CONFIG_PATH=/usr/local/ssl/lib/pkgconfig
export LD_LIBRARY_PATH=/usr/local/ssl/lib
autoreconf -i
automake
autoconf
./configure --disable-examples
make
sudo make install
cd ..
echo "[ OK ]"

