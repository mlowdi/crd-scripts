#!/usr/bin/bash

# Need to run this script as a sudo/wheel group user!

# Install prerequisites if they don't exist
sudo apt install build-essential checkinstall git autoconf automake libtool-bin libssl-dev pkg-config cython libusb-1.0-0-dev

# Sync the repos

# libplist
if [ -d ./libplist ]; then
	rm -rf ./libplist
fi
git clone https://github.com/libimobiledevice/libplist

# libimobiledevice-glue
if [ -d ./libimobiledevice-glue ]; then
	rm -rf ./libimobiledevice-glue
fi
git clone https://github.com/libimobiledevice/libimobiledevice-glue

# libusbmuxd
if [ -d ./libusbmuxd ]; then
	rm -rf ./libplist
fi
git clone https://github.com/libimobiledevice/libusbmuxd

# libimobiledevice
if [ -d ./libimobiledevice ]; then
	rm -rf ./libplist
fi
git clone https://github.com/libimobiledevice/libimobiledevice

# usbmuxd
if [ -d ./usbmuxd ]; then
	rm -rf ./libplist
fi
git clone https://github.com/libimobiledevice/usbmuxd

# Start building
cd libplist
./autogen.sh
make && sudo make install
sudo ldconfig
cd ..

cd libplist
PKG_CONFIG_PATH=/usr/local/lib/pkgconfig ./autogen.sh
make && sudo make install
sudo ldconfig
cd ..

cd libusbmuxd
PKG_CONFIG_PATH=/usr/local/lib/pkgconfig ./autogen.sh
make && sudo make install
sudo ldconfig
cd ..

cd libimobiledevice
PKG_CONFIG_PATH=/usr/local/lib/pkgconfig ./autogen.sh --enable-debug
make && sudo make install
cd ..

cd usbmuxd
PKG_CONFIG_PATH=/usr/local/lib/pkgconfig ./autogen.sh --prefix=/usr --sysconfdir=/etc --localstatedir=/var --runstatedir=/run
make && sudo make install
sudo killall usbmuxd
cd ..
