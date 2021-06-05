 #!/bin/bash
 
set -ex
tar -zxf /home/openwrt/openwrt.sources.tgz -C /home/openwrt
cd /home/openwrt/openwrt
cp /home/openwrt/targets/at91_config .config
make defconfig
make -j$(nproc) || make V=s
