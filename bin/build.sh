#!/bin/bash

release=15.05
target=x86
subtarget=64

wget https://openwrt.m-creations.net/$release/$target/$subtarget/openwrt-${release}-${target}-${subtarget}-rootfs.tar.gz

mv -f openwrt-$release-x86-64-rootfs.tar.gz image/

rm -rf image/tmp

mkdir image/tmp

tar xzv -C image/tmp -f image/openwrt-$release-x86-64-rootfs.tar.gz

rm -rf image/tmp/lib/modules/*/*

cat <<EOF>> image/tmp/root/.bashrc
source /etc/profile

alias ll='ls -al'
alias po=popd
alias pu=pushd
alias md=mkdir
EOF
chown root:root image/tmp/root/.bashrc

sed -ie 's/^tty.*//g' image/tmp/etc/inittab
sed -ie "s#http.*#https://openwrt.m-creations.net/${release}/${target}/${subtarget}#" image/tmp/etc/opkg/distfeeds.conf

ln -rs image/tmp/dev/tty image/tmp/dev/kmsg
chown root:root image/tmp/dev/kmsg

rm -f image/openwrt-x86-64-rootfs.tar.gz

tar czv -C image/tmp -f image/openwrt-x86-64-rootfs.tar.gz .

rm -rf image/tmp/

docker build -t mcreations/openwrt-x64:$release .

docker run -it --rm mcreations/openwrt-x64:$release opkg update

git add -u

git commit -m "Updating rootfs to release $release"

git tag -f -m "Tagging $release" -a $release
