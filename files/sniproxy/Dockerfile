FROM ubuntu:latest
MAINTAINER sebashwa, _tiii <_@tiii.de>

ENV VERSION 0.3.6
ENV ARCH amd64

USER root
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y wget autotools-dev cdbs debhelper dh-autoreconf dpkg-dev gettext libev-dev libpcre3-dev libudns-dev pkg-config
RUN apt-get clean

WORKDIR /tmp
RUN wget https://github.com/dlundquist/sniproxy/archive/$VERSION.tar.gz && tar fxz ${VERSION}.tar.gz
RUN cd sniproxy-$VERSION && ./autogen.sh && dpkg-buildpackage
RUN dpkg -i /tmp/sniproxy_*.deb

ADD ./sniproxy.conf /etc/sniproxy.conf

CMD sniproxy -f
EXPOSE 80 443