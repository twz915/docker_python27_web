FROM python:3.5-alpine
MAINTAINER WeizhongTu <tuweizhong@163.com>

ENV TENGINE_VERSION 2.2.2
ENV UWSGI_VERSION 2.0.17
RUN echo $'[global]\n\
timeout = 60\n\
index-url = http://mirrors.aliyun.com/pypi/simple\n\
[install]\n\
trusted-host = mirrors.aliyun.com' > /etc/pip.conf && \
    apk add --no-cache mariadb-dev openssl-dev pcre pcre-dev libc-dev \
    libuuid mailcap linux-headers curl gcc g++ make \
    supervisor && \
    curl "http://tengine.taobao.org/download/tengine-$TENGINE_VERSION.tar.gz" -o /tmp/tengine.tar.gz && \
    tar -xvzf /tmp/tengine.tar.gz -C /tmp && cd /tmp/tengine-$TENGINE_VERSION && \
    ./configure && make -j2 && \
    make install && cd / && rm -rf /tmp/tengine* &&\
    ln -s /usr/local/nginx/sbin/nginx /usr/local/nginx/sbin/tengine && \
    ln -s /usr/local/nginx/sbin/nginx /usr/local/bin/tengine && \
    ln -s /usr/local/nginx /etc/nginx && \
    echo $'
[program:tengine_proxy]
command=/usr/local/bin/tengine
' >> /etc/supervisord.conf && \
    pip install --no-cache-dir mysqlclient uWSGI==$UWSGI_VERSION && \
    apk del mariadb-dev openssl-dev pcre-dev g++ make \
    libc-dev linux-headers && \
    apk add --no-cache mariadb-client-libs && \
    supervisord && supervisorctl start tengine_proxy
