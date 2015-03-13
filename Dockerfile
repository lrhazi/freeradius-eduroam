FROM ubuntu:latest

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y software-properties-common

RUN add-apt-repository -y ppa:freeradius/stable-3.0;\
  apt-get update;\
  apt-get -y install freeradius freeradius-ldap freeradius-utils freeradius-config freeradius-rest

# Optional packages
RUN apt-get -y install ldap-utils

# Clean up
RUN apt-get clean && apt-get purge

ADD files/etc/ /etc/
ADD files/eapol_test/eapol_test /usr/bin/eapol_test
ADD files/eapol_test/ca-bundle.crt /root/ca-bundle.crt
ADD files/eapol_test/test.conf.template /root/test.conf.template
ADD files/eapol_test/test.sh /root/test.sh
ADD files/eapol_test/radtest.sh /root/radtest.sh
ADD .bash_history /root/.bash_history
ADD run.sh /root/run.sh


EXPOSE 1812/udp
EXPOSE 1813/udp

WORKDIR /root
VOLUME /var/log/freeradius

CMD /root/run.sh

