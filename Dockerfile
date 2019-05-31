# Jenkins Slave, Docker, Maven, Git
FROM casstime/alpine-glibc-server-jre:latest
MAINTAINER Jim Xu <jian.xu@casstime.com>

ENV JENKINS_HOME=/home/jenkins \
    JENKINS_REMOTNG_VERSION=2.53.1 \
    DOCKER_HOST=tcp://0.0.0.0:2375 \
    DOCKER_COMPOSE_VERSION=1.8.0

RUN apk add --no-cache --virtual=build-dependencies wget curl git && \
    curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    adduser -D -h $JENKINS_HOME -s /bin/sh jenkins jenkins && \
    chmod a+rwx $JENKINS_HOME && \
    echo "jenkins ALL=(ALL) NOPASSWD: /usr/local/bin/docker" > /etc/sudoers.d/00jenkins && \
    chmod 440 /etc/sudoers.d/00jenkins && \
    \
    curl --create-dirs -sSLo /usr/share/jenkins/slave.jar http://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/$JENKINS_REMOTNG_VERSION/remoting-$JENKINS_REMOTNG_VERSION.jar && \
    chmod 755 /usr/share/jenkins && \
    chmod 644 /usr/share/jenkins/slave.jar && \
    \
    wget http://mirrors.sonic.net/apache/maven/maven-3/3.5.3/binaries/apache-maven-3.5.3-bin.tar.gz && \
    tar -zxf apache-maven-3.5.3-bin.tar.gz && \
    mv apache-maven-3.5.3 /usr/local && \
    rm -f apache-maven-3.5.3-bin.tar.gz && \
    ln -s /usr/local/apache-maven-3.5.3/bin/mvn /usr/bin/mvn && \
    ln -s /usr/local/apache-maven-3.5.3 /usr/local/apache-maven && \
    \
    apk del build-dependencies

COPY jenkins-slave /usr/local/bin/jenkins-slave

VOLUME $JENKINS_HOME
WORKDIR $JENKINS_HOME

USER jenkins
ENTRYPOINT ["jenkins-slave"]