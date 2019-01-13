#!/bin/bash

echo "$(date): stopping b3 service"
systemctl stop urt43_b3

echo "$(date): stopping game service"
systemctl stop urt43_game

echo "$(date): cleaning up games.log"
su - urtadmin -c /ssd/urt/bin/gameslog_cleanup.sh

echo "$(date): updating OS packages"
apt-get --yes --quiet update
apt-get --yes --quiet upgrade

echo "$(date): rebooting"
/sbin/reboot
