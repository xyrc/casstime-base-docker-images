# AlpineLinux with a glibc-2.27-r0 And Oracle Java 8
FROM casstime/alpine-glibc:latest
MAINTAINER Jim Xu <jian.xu@casstime.com>

RUN apk add --no-cache --virtual=build-dependencies wget unzip && \
    mkdir -p "/skywalking/agent" && \
    cd "/tmp" && \
    wget "https://raw.githubusercontent.com/xyrc/casstime-base-docker-images/skywalking-agent-6.2.0/apache-skywalking-agent-6.2.0.zip" && \
    unzip -jo -d "/skywalking/agent" "apache-skywalking-agent-6.2.0.zip" && \
    chmod -R 666 "/skywalking/agent" && \
    \
    apk del build-dependencies && \
    rm -rf * && \
    \
    echo "成功了~"
