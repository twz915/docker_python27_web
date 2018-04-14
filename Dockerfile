FROM python:2.7-alpine
RUN apk add --no-cache mariadb-dev g++ && \
    echo $'[global]\n\
timeout = 60\n\
index-url = http://mirrors.aliyun.com/pypi/simple\n\
[install]\n\
trusted-host = mirrors.aliyun.com' > /etc/pip.conf && \
    pip install --no-cache-dir mysqlclient MySQL-Python uWSGI && \
    apk del g++ mariadb-dev && \
    apk add --no-cache mariadb-client-libs
