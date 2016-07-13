#!/bin/sh

mkdir -p downloads
mkdir -p src

if [ ! -d src/kernel-2.6.33 ]; then
	cd downloads
	echo "Downloading LG Hom Bot Linux Kernel Project"
	wget -qc --show-progress https://github.com/vlasenko/kernel.rk/archive/master.zip
	unzip -f master.zip
	cd kernel.rk-master
	./make_kernel.sh
	mv kernel-2.6.33 ../../src
	cd ../..
fi

if [ ! -d src/binutils-2.20.1 ]; then
	cd downloads
	echo "Downloading GNU Binutils"
	wget -qc --show-progress https://ftp.gnu.org/gnu/binutils/binutils-2.20.1a.tar.bz2
	tar xf binutils-2.20.1a.tar.bz2 -C ../src
	cd ..
fi

if [ ! -d src/glibc-2.5 ]; then
	cd downloads
	echo "Downloading Glibc"
	wget -qc --show-progress https://ftp.gnu.org/pub/gnu/glibc/glibc-2.5.tar.bz2
	wget -qc --show-progress https://ftp.gnu.org/pub/gnu/glibc/glibc-ports-2.5.tar.bz2
	tar xf glibc-2.5.tar.bz2 -C ../src
	tar xf glibc-ports-2.5.tar.bz2 -C ../src
	mv ../src/glibc-ports-2.5 ../src/glibc-2.5/ports
	cd ..
fi

if [ ! -d src/gcc-4.4.3 ]; then
	cd downloads
	echo "Downloading GCC"
	wget -qc --show-progress https://ftp.gnu.org/gnu/gcc/gcc-4.4.3/gcc-4.4.3.tar.bz2
	tar xf gcc-4.4.3.tar.bz2 -C ../src
	cd ..
fi

