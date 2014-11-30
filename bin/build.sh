#!/bin/bash

release=$1

wget https://github.com/m-creations/openwrt/releases/download/$release/openwrt-x86_64-rootfs.tar.gz

mv -f openwrt-x86_64-rootfs.tar.gz image/

rm -rf image/tmp

mkdir image/tmp

tar xzv -C image/tmp -f image/openwrt-x86_64-rootfs.tar.gz 

mkdir image/tmp/tmp/{log,lock}

rm image/tmp/lib/modules/*/*

cat <<EOF>> image/tmp/root/.bashrc
source /etc/profile

alias ll='ls -al'
alias po=popd
alias pu=pushd
alias md=mkdir
EOF

rm image/openwrt-x86_64-rootfs.tar.gz

tar czv -C image/tmp -f image/openwrt-x86_64-rootfs.tar.gz .

rm -rf image/tmp/

docker build -t mcreations/openwrt-x64:$release .

docker run -it --rm mcreations/openwrt-x64:$release opkg update

git add -u

git commit -m "Updating rootfs to release $release"

git tag -f -m "Tagging $release" -a $release
