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
    \
    mkdir -p "/usr/lib/sysctl.d" && \
    echo "net.ipv4.tcp_keepalive_probes=3\nnet.ipv4.tcp_keepalive_intvl=20\nnet.ipv4.tcp_keepalive_time=1200\nnet.netfilter.nf_conntrack_tcp_timeout_time_wait=30" > /usr/lib/sysctl.d/10-casstime.conf && \
    \
    apk del build-dependencies && \
    apk update && \
    apk upgrade && \
    apk add --no-cache bash bash-doc bash-completion && \
    rm -rf /var/cache/apk/* && \
    /bin/bash
