#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
ENDCOLOR="\e[0m"

echo -e "${YELLOW}************ Tunneling ************"
echo -e "${RED}-----------------------------------\n"
echo -e "  ${CYAN}0)Exit"
echo -e "  1)Enable  Auto Port Forward"
echo -e "  2)Disable Auto Port Forward"

echo -ne "${GREEN}\nSelect Operation : ${ENDCOLOR}" ;read n

case $n in
  0) clear;exit;;
  1) 

echo -e "Enter IP Or Domain"
read IP ;

apt install socat -y ;

mkdir /etc/Tunneling

wget https://github.com/MiladMk/Tunnel/raw/main/port_forward.sh
wget https://github.com/MiladMk/Tunnel/raw/main/reboot.sh

mv port_forward.sh /etc/Tunneling/port_forward.sh
mv reboot.sh /etc/Tunneling/reboot.sh

echo > /etc/Tunneling/port_forward.sh
echo "socat TCP-LISTEN:8088,fork,reuseaddr TCP:$IP:8088 & disown" >>/etc/Tunneling/port_forward.sh

chmod 700 /etc/Tunneling/port_forward.sh
chmod 700 /etc/Tunneling/reboot.sh

echo > /etc/cron.d/port_forward_job
echo "# AutoPortForward" >>/etc/cron.d/port_forward_job
echo "@reboot root /etc/Tunneling/port_forward.sh" >>/etc/cron.d/port_forward_job
echo "0 1 * * * root /etc/Tunneling/reboot.sh" >>/etc/cron.d/port_forward_job
echo > /etc/cron.d/port_forward_job
echo -e ""
echo -e "======================================"
echo -e ""
echo -e "      Enable  Auto Port Forward       "
echo -e ""
echo -e "======================================"
exit
;;
  2) 
clear
echo > /etc/cron.d/port_forward_job
echo -e ""
echo -e "======================================"
echo -e ""
echo -e "      Disable  Auto Port Forward      "
echo -e ""
echo -e "======================================"
exit
;;
  *) echo -e "${RED}\nInvalid Option. ";;
exit
