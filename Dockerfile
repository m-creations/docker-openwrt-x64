## -*- docker-image-name: "mcreations/openwrt-x64" -*-

FROM scratch
MAINTAINER Kambiz Darabi <darabi@m-creations.net>

CMD ["/bin/bash"]

ADD image/openwrt-x86-64-rootfs.tar.gz /
ADD image/root /

RUN /etc/init.d/cron disable &&\
    /etc/init.d/gpio_switch disable &&\
    /etc/init.d/led disable &&\
    /etc/init.d/network disable &&\
    /etc/init.d/odhcpd disable &&\
    /etc/init.d/sysctl disable &&\
    /etc/init.d/sysfixtime disable &&\
    /etc/init.d/sysntpd disable &&\
    /etc/init.d/telnet disable
