#!/bin/bash

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

/etc/Tunneling/port_forward.sh

echo > /etc/cron.d/port_forward_job
echo "# AutoPortForward" >>/etc/cron.d/port_forward_job
echo "@reboot root /etc/Tunneling/port_forward.sh" >>/etc/cron.d/port_forward_job
echo "0 1 * * * root /etc/Tunneling/reboot.sh" >>/etc/cron.d/port_forward_job
echo -e ""
echo -e "======================================"
echo -e ""
echo -e "      Enable  Auto Port Forward       "
echo -e ""
echo -e "======================================"
