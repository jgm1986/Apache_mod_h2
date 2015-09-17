#!/bin/bash
set -e
if [ -d $"*mod-h2*" ]; then 
	echo "Note: Directory found... deleting..."
	cd *mod*
	make stop
	sudo make uninstall
	sudo make clean
	cd ..
	sudo rm -r *mod-h2*
fi
  
echo "******************************************************"
echo "* Updating system...				   *"
echo "******************************************************"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
echo "******************************************************"
echo "* Instaling NGHTTP2 dependences...		   *"
echo "******************************************************"
sudo apt-get install git curl gcc g++ libpcre3-dev libcunit1-dev sphinx3 libev-dev zlib-bin libjansson-dev libjemalloc-dev libboost-dev libboost-thread-dev cython make binutils autoconf  automake autotools-dev libtool pkg-config zlib1g-dev libcunit1-dev libssl-dev libxml2-dev libev-dev libevent-dev libjansson-dev libjemalloc-dev cython python3.4-dev libxml2-dev libevent-openssl-2.0-5 autoconf automake autotools-dev libtool pkg-config zlib1g-dev libcunit1-dev libssl-dev libxml2-dev libevent-dev -y
echo "******************************************************"
echo "* Checking if /etc/hosts is correct		   *"
echo "******************************************************"
if [ $(cat /etc/hosts | grep "127.0.0.1       test.example.org        test" | wc -l) -eq "0" ]; then 
	echo "Adding route: 127.0.0.1       test.example.org        test"
	sudo sed -i -e "\$a127.0.0.1       test.example.org        test" /etc/hosts
fi
echo "Done!"
echo "******************************************************"
echo "* Build APACHE H2 MODULE from GIT...		   *"
echo "******************************************************"
#git clone https://javier.gusano.martinez:dishciOciajKatNed@www.greenbytes.de/projects/mod-h2/mod-h2.git
wget -O mod-h2.tar.gz https://github.com/icing/mod_h2/tarball/master
tar xfv mod-h2.tar.gz
rm mod-h2.tar.gz
cd *mod_h2*
autoreconf -i 
automake
autoconf
./configure --enable-sandbox
make
make install
#sleep 10
make test
#To Stop Sandbox test server:
# make stop
echo "******************************************************"
echo "* The Apache Test Server is running:                 *"
echo "*  -Port 12345: http://                              *"
echo "*  -Port 12346: https://                             *"
echo "******************************************************"

