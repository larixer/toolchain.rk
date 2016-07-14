#!/bin/sh
DEST=/opt/arm-rk

mkdir -p $DEST
if [ ! -d $DEST ]; then
	echo "Failed to create $DEST"
	exit 1
fi

if [ ! -f build/binutils/success ]; then
	echo "Configuring binutils"
	rm -rf build/binutils/success
	mkdir -p build/binutils
	cd build/binutils
	../../src/binutils-2.20.1/configure --target=arm-linux-gnueabi \
		--prefix=$DEST \
		--program-prefix=arm-linux-gnueabi- \
		--with-abi=aapcs-linux --with-arch=armv4t \
		--disable-nls --disable-werror > build.log 2>&1
	echo "Building binutils"
	make CFLAGS="-O2 -Wno-error" -j16 MAKEINFO=true >> build.log 2>&1
	echo "Installing binutils"
	sudo env PATH=$PATH make install MAKEINFO=true >> build.log 2>&1
	touch success
	echo "Done with binutils"
	cd ../..
fi

