 #!/bin/bash
 
set -ex
tar -zxf /home/openwrt/openwrt.sources.tgz -C /home/openwrt
cd /home/openwrt/openwrt
cp /home/openwrt/devices/at91sama5d3_xplain/.config ./
make defconfig
make -j$(nproc) || make V=s
