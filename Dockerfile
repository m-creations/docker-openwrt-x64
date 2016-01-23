## -*- docker-image-name: "mcreations/openwrt-x64" -*-

FROM scratch
MAINTAINER Kambiz Darabi <darabi@m-creations.net>

CMD ["/bin/bash"]

ADD image/openwrt-x86-64-rootfs.tar.gz /
ADD image/root /
