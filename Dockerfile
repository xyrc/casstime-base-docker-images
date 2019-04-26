FROM node:10.15.3-stretch-slim

# 替换镜像，修改时区
ENV TZ=Asia/Shanghai
RUN set -eux; \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime; \
    echo $TZ > /etc/timezone;

# 换源
RUN echo "deb http://mirrors.163.com/debian/ stretch main non-free contrib\n\
deb http://mirrors.163.com/debian/ stretch-updates main non-free contrib\n\
deb http://mirrors.163.com/debian/ stretch-backports main non-free contrib\n\
deb-src http://mirrors.163.com/debian/ stretch main non-free contrib\n\
deb-src http://mirrors.163.com/debian/ stretch-updates main non-free contrib\n\
deb-src http://mirrors.163.com/debian/ stretch-backports main non-free contrib\n\
deb http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib\n\
deb-src http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib\n\
" > /etc/apt/sources.list

# 通用依赖 构建工具，python ifconfig ping ip
RUN  apt-get update -y && apt-get install -y apt-utils build-essential python net-tools iputils-ping iproute2

# npm 加速
RUN npm config set registry https://registry.npm.taobao.org/ && \
npm install yarn -g && \
npm config set @casstime:registry http://dev.casstime.com/nexus/repository/npm/ && \
npm config set sass_binary_site https://npm.taobao.org/mirrors/node-sass && \
npm config set electron_mirror https://npm.taobao.org/mirrors/electron/ && \
npm config set puppeteer_download_host https://npm.taobao.org/mirrors && \
npm config set chromedriver_cdnurl https://npm.taobao.org/mirrors/chromedriver  && \
npm config set operadriver_cdnurl https://npm.taobao.org/mirrors/operadriver  && \
npm config set phantomjs_cdnurl https://npm.taobao.org/mirrors/phantomjs && \
npm config set selenium_cdnurl https://npm.taobao.org/mirrors/selenium && \
npm config set node_inspector_cdnurl https://npm.taobao.org/mirrors/node-inspector && \
yarn config set registry https://registry.npm.taobao.org/ && \
yarn config set @casstime:registry http://dev.casstime.com/nexus/repository/npm/ && \
yarn config set sass_binary_site https://npm.taobao.org/mirrors/node-sass && \
yarn config set electron_mirror https://npm.taobao.org/mirrors/electron/ && \
yarn config set puppeteer_download_host https://npm.taobao.org/mirrors && \
yarn config set chromedriver_cdnurl https://npm.taobao.org/mirrors/chromedriver && \
yarn config set operadriver_cdnurl https://npm.taobao.org/mirrors/operadriver && \
yarn config set phantomjs_cdnurl https://npm.taobao.org/mirrors/phantomjs && \
yarn config set selenium_cdnurl https://npm.taobao.org/mirrors/selenium && \
yarn config set node_inspector_cdnurl https://npm.taobao.org/mirrors/node-inspector

CMD ["node"]
