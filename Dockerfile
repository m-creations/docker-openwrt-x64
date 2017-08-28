## -*- docker-image-name: "mcreations/openwrt-x64" -*-

FROM scratch
MAINTAINER Kambiz Darabi <darabi@m-creations.net>

CMD ["/bin/bash"]

ADD image/openwrt-x86-64-rootfs.tar.gz /
ADD image/root /

RUN opkg remove kmod-e1000 kernel &&\
    pass=$(dd if=/dev/urandom bs=64 count=1 | tr -dc 'a-zA-Z0-9') &&\
    printf "$pass\n$pass\n" | passwd
