## -*- docker-image-name: "mcreations/openwrt-x64" -*-

FROM scratch
MAINTAINER Kambiz Darabi <darabi@m-creations.net>

ADD image/openwrt-x86_64-rootfs.tar.gz /

CMD ["/bin/bash"]
