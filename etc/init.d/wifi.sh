#!/bin/sh
modprobe rt3070sta
ifconfig ra0 up
wpa_supplicant -B -Dwext -ira0 -c /etc/wpa_supplicant.conf -P /var/run/wpa_supplicant.pid
ifconfig ra0 192.168.0.110 netmask 255.255.255.0
route add default gw 192.168.0.1
