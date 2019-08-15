# AlpineLinux with a glibc-2.27-r0 And Oracle Java 8
FROM casstime/alpine-glibc:latest
MAINTAINER Jim Xu <jian.xu@casstime.com>

#制作镜像的脚本如下
#docker build --pull --rm -t casstime/alpine-glibc-server-jre-8:latest .
#docker push casstime/alpine-glibc-server-jre-8:latest

ENV JAVA_VERSION=8 \
    JAVA_UPDATE=202 \
    JAVA_BUILD=08 \
    JAVA_PATH=1961070e4c9b4e26a04e7f5a083f551e \
    JAVA_HOME="/usr/lib/java" \
    PATH="${PATH}:/usr/lib/java/bin"

RUN apk add --no-cache --virtual=build-dependencies wget ca-certificates unzip && \
    cd "/tmp" && \
    wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
        "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/${JAVA_PATH}/server-jre-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" && \
    tar -xzf "server-jre-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" && \
    mkdir -p "${JAVA_HOME}" && \
    mv /tmp/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}/* ${JAVA_HOME} && \
    \
    mkdir -p "${JAVA_HOME}/jre/lib/security" && \
    wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" "http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION}/jce_policy-${JAVA_VERSION}.zip" && \
    unzip -jo -d "${JAVA_HOME}/jre/lib/security" "jce_policy-${JAVA_VERSION}.zip" && \
    rm "${JAVA_HOME}/jre/lib/security/README.txt" && \
    \
    wget "https://raw.githubusercontent.com/xyrc/casstime-base-docker-images/master/jdk-tools.zip" && \
    unzip -jo -d "${JAVA_HOME}/bin" "jdk-tools.zip" && \
    chmod -R 755 "${JAVA_HOME}/bin" && \
    \
    mkdir -p "/skywalking/agent" && \
    wget "https://raw.githubusercontent.com/xyrc/casstime-base-docker-images/master/apache-skywalking-agent-6.2.0.zip" && \
    unzip -jo -d "/skywalking/agent" "apache-skywalking-agent-6.2.0.zip" && \
    chmod -R 666 "/skywalking/agent" && \
    \
    apk del build-dependencies && \
    rm -rf * && \
    \
    java -version && \
    echo "成功了~"
