#!/bin/bash
workdir=`pwd`
sudo mkdir -p -m 777 /mnt/openwrt
git clone https://github.com/immortalwrt/immortalwrt.git --single-branch --depth 1 /mnt/openwrt/immortalwrt
ln -s /mnt/openwrt/immortalwrt ./immortalwrt
cp $workdir/tool.sh /mnt/openwrt/immortalwrt/tool.sh
chmod +x /mnt/openwrt/immortalwrt/tool.sh
cd /mnt/openwrt/immortalwrt
df -h
cat << EOF >> feeds.conf.default
src-git diy1 https://github.com/xiaorouji/openwrt-passwall-packages.git;main
src-git diy2 https://github.com/xiaorouji/openwrt-passwall.git;main
src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2.git;main
EOF
rm target/linux/rockchip/files/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
cp $workdir/configs/rk3568-photonicat-usb30.dts target/linux/rockchip/files/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
./tool.sh feed
cp $workdir/configs/base_config .config
make defconfig
make download -j8 || make download -j1 V=s
df -h
make -j$(nproc) || make -j1 V=s