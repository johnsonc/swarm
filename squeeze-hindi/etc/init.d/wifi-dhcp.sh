#!/bin/sh
ifconfig ra0 up
wpa_supplicant -B -Dwext -ira0 -c /etc/wpa_supplicant.conf -P /var/run/wpa_supplicant.pid
dhcpd ra0
#ifconfig ra0 192.168.0.114 netmask 255.255.255.0
#route add default gw 192.168.0.1
