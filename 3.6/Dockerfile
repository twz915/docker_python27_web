FROM python:3.6-alpine
MAINTAINER WeizhongTu <tuweizhong@163.com>

ENV LUAJIT_LIB /usr/local/lib/luajit
ENV LUAJIT_INC /usr/local/include/luajit-2.0
ENV TENGINE_PREFIX /usr/local/tengine

RUN echo $'[global]\n\
timeout = 60\n\
index-url = http://mirrors.aliyun.com/pypi/simple\n\
[install]\n\
trusted-host = mirrors.aliyun.com' > /etc/pip.conf && \
    apk add --no-cache mariadb-dev openssl-dev pcre pcre-dev libc-dev \
    libuuid mailcap linux-headers gcc g++ make \
    supervisor curl && \
    curl http://tengine.taobao.org/download/tengine-2.2.2.tar.gz -o /tmp/tengine.tar.gz && \
    curl http://luajit.org/download/LuaJIT-2.0.5.tar.gz -o /tmp/LuaJIT-2.0.5.tar.gz && \
    curl https://codeload.github.com/openresty/lua-nginx-module/tar.gz/v0.10.11 -o /tmp/lua-nginx-module-0.10.11.tar.gz && \
    curl https://codeload.github.com/simpl/ngx_devel_kit/tar.gz/v0.3.0 -o /tmp/ngx_devel_kit-0.3.0.tar.gz && \
    tar -xvzf /tmp/tengine.tar.gz -C /tmp && \
    tar -xvzf /tmp/LuaJIT-2.0.5.tar.gz -C /tmp && \
    tar -xvzf /tmp/lua-nginx-module-0.10.11.tar.gz -C /tmp && \
    tar -xvzf /tmp/ngx_devel_kit-0.3.0.tar.gz -C /tmp && \
    cd /tmp/LuaJIT-2.0.5 && make -j2 && make install && \
    cd /tmp/tengine-2.2.2 && \
    ./configure --prefix=$TENGINE_PREFIX --add-module=/tmp/lua-nginx-module-0.10.11 --add-module=/tmp/ngx_devel_kit-0.3.0 && \
    make -j2 && make install &&\
    ln -s $TENGINE_PREFIX/sbin/nginx $TENGINE_PREFIX/sbin/tengine && \
    ln -s $TENGINE_PREFIX/sbin/nginx /usr/local/bin/tengine && \
    ln -s $TENGINE_PREFIX /etc/nginx && \
    echo $'\n\
[program:tengine_proxy]\n\
command=/usr/local/bin/tengine\n\
' >> /etc/supervisord.conf && \
    pip install --no-cache-dir mysqlclient uWSGI==2.0.17 && \
    apk del mariadb-dev openssl-dev pcre-dev libc-dev g++ gcc make \
    libc-dev linux-headers && \
    cd / && rm -rf /tmp/* && \
    apk add --no-cache mariadb-client-libs && \
    supervisord && supervisorctl start tengine_proxy

EXPOSE 80 443
CMD ["sh"]
