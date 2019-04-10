# AlpineLinux with a glibc-2.27-r0 And Oracle Java 8 And Apache Tomcat
FROM casstime/alpine-glibc-server-jre-8:latest
MAINTAINER Jim Xu <jian.xu@casstime.com>

#制作镜像的脚本如下
#docker build --pull --rm -t casstime/alpine-glibc-server-jre-8-tomcat-8:latest .
#docker push casstime/alpine-glibc-server-jre-8-tomcat-8:latest

ENV TOMCAT_VERSION=8.0.21 \
    TOMCAT__HOME="/opt" \
    PATH="${PATH}:/opt/bin"

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
    apk del build-dependencies && \
    rm -rf * && \
    \
    java -version && \
    echo "成功了"