#!/bin/sh

USERNAME=$1
PASSWORD=$2

sed -e "s/USERNAME/$USERNAME/" -e "s/PASSWORD/$PASSWORD/" test.conf.template > test.conf

eapol_test -a freeradius  -p1812 -stesting123 -c test.conf 

