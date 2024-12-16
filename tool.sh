#!/bin/bash

function main(){
case $1 in
"feed")
	echo "update feed"
	feed
	echo "update feed finish"
	;;
*)
	echo "param invalid"
	;;
esac
}

function delete_dep(){
# 定义A和B文件夹的路径
A_DIR="./feeds/diy1"
B_DIR="./feeds/packages/net"

# 遍历A文件夹中的子文件夹
for subdir in "$A_DIR"/*; do
    if [ -d "$subdir" ]; then
        # 提取子文件夹的名字
        subdir_name=$(basename "$subdir")
        
        # 在B文件夹中查找并删除同名的文件夹
        if [ -d "$B_DIR/$subdir_name" ]; then
            rm -rf "$B_DIR/$subdir_name"
            echo "Deleted $B_DIR/$subdir_name"
        fi
    fi
done
}

function install_dep(){
# 定义A和B文件夹的路径
A_DIR="./feeds/diy1"

# 遍历A文件夹中的子文件夹
for subdir in "$A_DIR"/*; do
    if [ -d "$subdir" ]; then
        # 提取子文件夹的名字
        subdir_name=$(basename "$subdir")
        ./scripts/feeds install -p diy1 -f "$subdir_name"
        echo "install $subdir_name"
    fi
done
}

function feed(){
patchs=`pwd`
rm -rf ./feeds/*
./scripts/feeds update -a
delete_dep
rm -rf ./feeds/luci/applications/luci-app-passwall
rm -rf ./feeds/packages/net/v2ray-geodata
rm -rf ./feeds/packages/net/mosdns
./scripts/feeds install -a
./scripts/feeds install -p diy2 -f luci-app-passwall
./scripts/feeds install -p custom -f v2ray-geodata
./scripts/feeds install -p mosdns -f mosdns
install_dep
pushd ./feeds/luci
git apply $patchs/patchs/001-luci-status-network-ifaces.patch
popd
}


main $1