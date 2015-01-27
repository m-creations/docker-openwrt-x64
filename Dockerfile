## -*- docker-image-name: "mcreations/openwrt-x64" -*-

FROM scratch
MAINTAINER Kambiz Darabi <darabi@m-creations.net>

CMD ["/bin/bash"]

ADD image/openwrt-x86_64-rootfs.tar.gz /

# Don't add image/root here as it increases the image size.
# Instead, unpack the rootfs.tar.gz which is created by the
# openwrt build, add the dirs and files in image/root,
# delete the modules and tar them up again with
#
# cd image/root
# tar xfvz ../openwrt-x86_64-rootfs.tar.gz
# rm lib/modules/*/*
# tar --owner=root --group=root -cvzf ../openwrt-x86_64-rootfs.tar.gz .

