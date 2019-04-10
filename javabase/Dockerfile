FROM registry.cn-shenzhen.aliyuncs.com/cassmall/javabase:v1
MAINTAINER hailong.chang@casstime.com
# 设置编码，解决中文日志乱码
ENV LC_ALL en_US.utf8
ENV LANG en_US.utf8
# 设置时区
RUN echo "Asia/Shanghai" > /etc/timezone && \
    \cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# 建立相关的目录
RUN mkdir -p /usr/icec
WORKDIR /usr/icec