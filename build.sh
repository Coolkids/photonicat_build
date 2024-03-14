#!/bin/bash
git clone https://github.com/immortalwrt/immortalwrt.git
cd immortalwrt
cat << EOF >> feeds.conf.default
src-git diy1 https://github.com/xiaorouji/openwrt-passwall-packages.git;main
src-git diy2 https://github.com/xiaorouji/openwrt-passwall.git;main
src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2.git;main
EOF
rm target/linux/rockchip/files/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
cp ../configs/rk3568-photonicat-usb30.dts target/linux/rockchip/files/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
./scripts/feeds update -a
./scripts/feeds install -a
cp ../configs/base_config .config
make defconfig
make download -j8 || make download -j1 V=s
rm -rf $(find ./dl/ -size -1024c)
make -j$(nproc) || make -j1 V=s