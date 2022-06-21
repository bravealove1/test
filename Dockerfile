FROM centos:7
LABEL maintainer="chenshunli <123@qq.com>"

ENV PACKAGE_NAME="nginx-1.20.2"

ADD ${PACKAGE_NAME}.tar.gz /usr/local/src/

WORKDIR /usr/local/src/${PACKAGE_NAME}

RUN yum -y install gcc gcc-c++ make zlib-devel pcre-devel openssl-devel \
    && useradd -s/bin/nologin nginx

RUN ./configure \
    --prefix=/usr/local/nginx \
    --user=nginx \
    --group=nginx \
    --with-ld-opt=-Wl,-rpath,$LUAJIT_LIB \
    --with-http_stub_status_module\
    --with-http_gzip_static_module\
    --with-http_realip_module\
    --with-http_ssl_module \
    && make \
    && make install

ENV PATH="/usr/local/nginx/sbin:${PATH}"
EXPOSE 80/tcp
CMD ["/bin/sh","-c","nginx -g 'daemon off;'"]
