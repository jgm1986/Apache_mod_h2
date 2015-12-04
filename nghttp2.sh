#!/bin/bash
set -e
echo "********************************************************"
echo "* NGHTTP2: 1.5.0                                       *"
echo "********************************************************"
sudo apt-get install make binutils autoconf  automake autotools-dev libtool pkg-config \
  zlib1g-dev libcunit1-dev libssl-dev libxml2-dev libev-dev libevent-dev libjansson-dev \
  libjemalloc-dev cython python3.4-dev python-setuptools -y
sudo apt-get install    gcc         \
            sphinx3         \
            libev-dev       \
            libjansson-dev      \
            libjemalloc-dev     \
            libboost-dev        \
            libboost-thread-dev \
            cython          \
            python3.4-dev       \
            -y
wget https://github.com/tatsuhiro-t/nghttp2/releases/download/v1.5.0/nghttp2-1.5.0.tar.gz --no-check-certificate
tar xfv nghttp2-1.5.0.tar.gz
cd nghttp2-1.5.0/
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

