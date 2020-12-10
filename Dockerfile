FROM       ubuntu:latest
MAINTAINER binge "https://github.com/binge8/ubuntu-sshd-cron"

ENV LANGC.UTF-8

RUN apt-get update && \
apt-get install -y --no-install-recommends \
openssh-server cron wget curl git vim sudo

RUN mkdir /var/run/sshd \
mkdir /var/run/cron

ADD init.sh /

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

CMD    ["/init.sh"]
