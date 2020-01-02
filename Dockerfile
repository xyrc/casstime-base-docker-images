# AlpineLinux 3.9 with a glibc-2.27-r0
FROM frolvlad/alpine-glibc:alpine-3.9
MAINTAINER Jim Xu <jian.xu@casstime.com>
# thanks to Vlad Frolov https://github.com/frol 
#       and cxiaolng <hailong.chang@casstime.com>

#制作镜像的脚本如下
#docker build --pull --rm -t casstime/alpine-glibc:latest .
#docker push casstime/alpine-glibc:latest

ENV MALLOC_ARENA_MAX=1 \
    TZ=GMT+08 \
    LANG=C.UTF-8

RUN apk add --no-cache --virtual=build-dependencies unzip tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh && \
    echo 3 > /proc/sys/net/ipv4/tcp_keepalive_probes && \
    echo 20 > /proc/sys/net/ipv4/tcp_keepalive_intvl && \
    echo 1200 > /proc/sys/net/ipv4/tcp_keepalive_time && \
    apk del build-dependencies && \
    apk update && \
    apk upgrade && \
    apk add --no-cache bash bash-doc bash-completion && \
    rm -rf /var/cache/apk/* && \
    /bin/bash
