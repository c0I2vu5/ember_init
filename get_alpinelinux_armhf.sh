#!/bin/bash

${MM}=3.9
${BUILD}=2

rm -rf ./zw
curl -LO http://dl-cdn.alpinelinux.org/alpine/v${MM}/releases/armhf/alpine-rpi-${MM}.${BUILD}-armhf.tar.gz
mkdir zw
tar zxf alpine*.tar.gz -C zw
rm -f alpine*.tar.gz
echo "enable_uart=1" > ./zw/usercfg.txt
echo "microSD have to be formatted with FAT32 bootable."
echo "exec : cp -arp ./zw/* /path/to/microSD/root"
