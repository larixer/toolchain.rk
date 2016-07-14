#!/bin/sh

abort()
{
    echo "An error occurred. Exiting..." >&2
    exit 1
}

trap 'abort' 0

set -e

DEST=/opt/arm-rk

mkdir -p $DEST
if [ ! -d $DEST ]; then
	echo "Failed to create $DEST"
	exit 1
fi

if [ ! -f $DEST/arm-linux-gnueabi/bin/ld ]; then
	if [ ! -f build/binutils/Makefile ]; then
		echo "Configuring binutils"
		mkdir -p build/binutils
		cd build/binutils
		../../src/binutils-2.20.1/configure --target=arm-linux-gnueabi \
			--prefix=$DEST \
			--program-prefix=arm-linux-gnueabi- \
			--with-abi=aapcs-linux --with-arch=armv4t \
			--disable-nls --disable-werror > config.log 2>&1
	else
		cd build/binutils
	fi

	if [ ! -f install.log ]; then
		echo "Building binutils"
		make CFLAGS="-O2 -Wno-error" -j16 MAKEINFO=true > build.log 2>&1
	fi

	echo "Installing binutils"
	make install MAKEINFO=true > install.log 2>&1

	echo "Done with binutils"
	cd ../..
fi

if [ ! -d $DEST/include/linux ]; then
	echo "Copyying LG Hom Bot Kernel Headers"
	mkdir -p $DEST/include
	cp -rf src/kernel-2.6.33/include/linux $DEST/include/
	cp -rf src/kernel-2.6.33/arch/arm/include/asm $DEST/include/
	cp -rf src/kernel-2.6.33/include/asm-generic $DEST/include/
	cp -rf src/kernel-2.6.33/arch/arm/mach-nxp2120/include/mach/ $DEST/include/
	cp -rf src/kernel-2.6.33/arch/arm/plat-nexell/include/* $DEST/include/
	echo "Done with LG Hom Bot Kernel Headers"
fi

if [ ! -f $DEST/arm-linux-gnueabi/bin/gcc ]; then
	if [ ! -f build/gcc-pass1/Makefile ]; then
		echo "Configuring GCC pass 1"
		mkdir -p build/gcc-pass1
		cd build/gcc-pass1
		../../src/gcc-4.4.3/configure --target=arm-linux-gnueabi \
			--prefix=$DEST \
			--without-headers --with-newlib --disable-shared --disable-threads --with-arch=armv4t \
			--disable-libmudflap --disable-libssp --disable-libgomp --enable-languages=c --disable-nls > config.log 2>&1
	else
		cd build/gcc-pass1
	fi

	if [ ! -f install.log ]; then
		echo "Building GCC pass 1"
		make -j16 CFLAGS="-fgnu89-inline" MAKEINFO=true > build.log 2>&1
	fi

	echo "Installing GCC pass 1"
	make install MAKEINFO=true > install.log 2>&1

	echo "Done with GCC pass 1"
	cd ../..
fi

trap : 0