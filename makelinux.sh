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

# CC=arm-none-linux-gnueabihf-gcc
# make mrproper

export PATH="/opt/gcc-linaro-7.5.0-2019.12-i686_arm-linux-gnueabihf/bin:$PATH" && \
arm-linux-gnueabihf-gcc --version && \
cd /workspace && \
git clone --branch solidrun-imx_4.9.x_1.0.0_ga https://github.com/SolidRun/linux-fslc.git && \
cd ./linux-fslc && \
git checkout "3b4f1a2b7c57f198641c0a45e23fe7255a164daf" && \
export CROSS_COMPILE="arm-linux-gnueabihf-" && \
export ARCH="arm" && \
announce "Building linux" && \
announce "make imx_v7_cbi_hb_defconfig" && \
make imx_v7_cbi_hb_defconfig && \
announce "make zImage dtbs modules" && \
make zImage dtbs modules && \
announce "linux build appears to have been successful" && \
ls -R ./arch/arm && \
announce "copying files" && \
install -v -m644 -D ./arch/arm/boot/zImage /dist/zImage && \
mkdir -p /dist/dts && \
install -v -m644 -D ./arch/arm/boot/dts/*.dtb /dist/dts/ && \
announce "files copied"

# for file in $(find source -type f -name *.py); do
#     install -m 644 -D ${file} dest/${file#source/}
# done

