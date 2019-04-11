# AlpineLinux with a glibc-2.27-r0 And Oracle Java 8 And Apache Tomcat 8
FROM casstime/alpine-glibc-server-jre-8:latest
MAINTAINER Jim Xu <jian.xu@casstime.com>

ENV TOMCAT_VERSION=8 \
    TOMCAT_HOME="/opt" \
    PATH="${PATH}:/opt/bin"

RUN apk add --no-cache --virtual=build-dependencies wget ca-certificates unzip && \
    cd "/tmp" && \
    wget "http://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_VERSION}/v${TOMCAT_VERSION}.0.21/bin/apache-tomcat-${TOMCAT_VERSION}.0.21.tar.gz" && \
    tar -xzf "apache-tomcat-${TOMCAT_VERSION}.0.21.tar.gz" && \
    mkdir -p "${TOMCAT_HOME}" && \
    mv /tmp/apache-tomcat-${TOMCAT_VERSION}.0.21/* ${TOMCAT_HOME} && \
    \
    apk del build-dependencies && \
    rm -rf * && \
    cd "${TOMCAT_HOME}/webapps" && \
    rm -rf * && \
    echo "完成了"
