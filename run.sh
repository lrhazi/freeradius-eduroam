#!/bin/sh


sed -i -e "s/EDUROAM_SERVER_1/$EDUROAM_SERVER_1/g" -e "s/EDUROAM_SERVER_2/$EDUROAM_SERVER_2/g" /etc/freeradius/proxy.conf
sed -i -e "s/EDUROAM_PASSWORD/$EDUROAM_PASSWORD/g" /etc/freeradius/proxy.conf

freeradius -f
