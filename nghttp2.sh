#!/bin/bash
set -e
echo "********************************************************"
echo "* NGHTTP2: 1.3.2                                       *"
echo "********************************************************"
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
wget https://github.com/tatsuhiro-t/nghttp2/releases/download/v1.3.2/nghttp2-1.3.2.tar.gz
tar xfv nghttp2-1.3.2.tar.gz
cd nghttp2-1.3.2/
autoreconf -i
automake
autoconf
./configure --enable-asio-lib
make
sudo make install
cd ..
