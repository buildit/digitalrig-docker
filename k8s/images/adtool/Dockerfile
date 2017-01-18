FROM buildpack-deps:jessie

RUN mkdir -p /root/work/ \
    && apt-get -y update \
    && apt-get -y -o Dpkg::Options::="--force-confnew"  --no-install-recommends install \
        libldap2-dev wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/?? /usr/share/man/??_*git --

RUN wget https://gp2x.org/adtool/adtool-1.3.3.tar.gz
RUN tar -zxvf adtool-1.3.3.tar.gz ; cd adtool-1.3.3; ./configure; make; make install; cp src/etc/adtool.cfg.dist /usr/local/etc/adtool.cfg; cd ..; rm -r adtool-1.3.3*
