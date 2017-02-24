FROM ubuntu:latest
MAINTAINER Roman Safronov <electroma@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
        samba winbind \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY samba_setup.sh samba_run.sh entry_point.sh /sbin/

VOLUME ["/var/lib/samba"]

CMD ["/sbin/entry_point.sh"]
