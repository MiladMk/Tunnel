#!/bin/bash

date=`date +"%Y-%m-%d %X"`;
echo "reboot at $date" >> /root/log-reboot.txt;
/sbin/shutdown -r ;
