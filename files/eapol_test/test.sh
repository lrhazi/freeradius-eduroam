#!/bin/sh

USERNAME=$1
PASSWORD=$2

server=$(grep freeradius /etc/hosts|awk '{print $1}')

sed -e "s/USERNAME/$USERNAME/" -e "s/PASSWORD/$PASSWORD/" test.conf.template > test.conf

eapol_test -a $server  -p1812 -stesting123 -c test.conf 

