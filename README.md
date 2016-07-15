## LG Hom Bot Cross-Compiler

This project contains scripts and patches for building cross compiler on Linux for any model of LG Hom Bot.

The quality of produced cross-compiler is sufficient for building working `strace` and `gdb`.

LG Hom Bot models contain glibc 2.4 in their firmware. This cross-compiler, however, is built with glibc 2.5 with 
manual version downgrade to 2.4. This was done due to compilation issues of glibc 2.4 with kernel 2.6.33 used on Hom Bot.
Too many patching to glibc 2.5 is needed to successfully compile glibc 2.4 with this kernel. Perhaps glibc 2.4 was compiled
with older linux kernel for the device and then the kernel was upgraded, but glibc 2.4 was kept.

### Prerequisites 

These packages need to be installed into the system, prior to building cross-compiler.

``` shell
sudo apt-get install libgmp-dev libmpfr-dev build-essentials
```

Cross-compiler is being built by default into `/opt/arm-rk`, this directory must be writable for the user, that runs build scripts.

### Building

``` shell
git clone https://github.com/vlasenko/toolchain.rk
cd toolchain.rk
./all.sh
```

This should produce working cross-compiler into `/opt/ark-rk`
