#!/bin/bash

rm -rf ./zw
curl -LO http://dl-cdn.alpinelinux.org/alpine/v3.9/releases/armhf/alpine-rpi-3.9.2-armhf.tar.gz
mkdir zw
tar zxf alpine*.tar.gz -C zw
rm -f alpine*.tar.gz
echo "enable_uart=1" > ./zw/usercfg.txt
echo "microSD have to be formatted with FAT32 bootable."
echo "exec : cp -arp ./zw/* /path/to/microSD/root"
