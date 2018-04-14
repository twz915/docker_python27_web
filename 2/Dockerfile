FROM python:2.7-alpine
MAINTAINER WeizhongTu <tuweizhong@163.com>

ENV TENGINE_VERSION 2.2.2
RUN echo $'[global]\n\
timeout = 60\n\
index-url = http://mirrors.aliyun.com/pypi/simple\n\
[install]\n\
trusted-host = mirrors.aliyun.com' > /etc/pip.conf && \
    apk add --no-cache mariadb-dev openssl-dev pcre-dev g++ make && \
    apk add --no-cache supervisor uwsgi-python && \
    wget "http://tengine.taobao.org/download/tengine-$TENGINE_VERSION.tar.gz" -O /tmp/tengine.tar.gz && \
    tar -xvzf /tmp/tengine.tar.gz -C /tmp && cd /tmp/tengine-$TENGINE_VERSION && \
    ./configure && make -j2 && \
    make install && cd / && rm -rf /tmp/tengine* &&\
    ln -s /usr/local/nginx/sbin/nginx /usr/local/nginx/sbin/tengine && \
    ln -s /usr/local/nginx/sbin/nginx /usr/local/bin/tengine && \
    ln -s /usr/local/nginx /etc/nginx && \
    pip install --no-cache-dir mysqlclient && \
    apk del mariadb-dev openssl-dev pcre-dev g++ make && \
    apk add --no-cache mariadb-client-libs
