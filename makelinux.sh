#!/bin/bash

echo "User: $(whoami) UID: $(id -u) GID: $(id -g)"
gcc --version
# an echo that will stand out in the logs
function announce () {
    echo "##########################################################################################"
    echo "##############################  $*  #################################"
    echo "##########################################################################################"
}

set -e

export PATH=/opt/gcc-arm-10.3-2021.07-aarch64-arm-none-linux-gnueabihf/bin:$PATH
#  CC=arm-none-linux-gnueabihf-gcc
cd /workspace

git clone --branch solidrun-imx_4.9.x_1.0.0_ga https://github.com/SolidRun/linux-fslc.git

cd ./linux-fslc

export CROSS_COMPILE="arm-none-linux-gnueabihf-"
export ARCH="arm"

# export UBOOT_CONFIG="mx6cuboxi_defconfig"
which cc
announce "Building linux"
# make mrproper
make imx_v7_cbi_hb_defconfig
make -j8 zImage dtbs modules
announce "linux build appears to have been successful"
announce "copying files"
install -v -m644 -D ./arch/arm/zImage /dist/zImage
install -v -m644 -D ./arch/arm/boot/dts/*.dtb /dist


# for file in $(find source -type f -name *.py); do
#     install -m 644 -D ${file} dest/${file#source/}
# done
announce "files copied"
