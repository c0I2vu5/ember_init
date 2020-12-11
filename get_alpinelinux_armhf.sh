#!/bin/bash

${MAJOR}=3
${MINOR}=9
${BUILD}=2
${REVISION}=

rm -rf ./zw
curl -LO http://dl-cdn.alpinelinux.org/alpine/v${MAJOR}.${MINOR}/releases/armhf/alpine-rpi-${MAJOR}.${MINOR}.${BUILD}-armhf.tar.gz
mkdir zw
tar zxf alpine*.tar.gz -C zw
rm -f alpine*.tar.gz
echo "enable_uart=1" > ./zw/usercfg.txt
echo "microSD have to be formatted with FAT32 bootable."
echo "exec : cp -arp ./zw/* /path/to/microSD/root"
