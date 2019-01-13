#!/bin/bash

echo "$(date): stopping b3 service"
systemctl stop urt43_b3

echo "$(date): stopping game service"
systemctl stop urt43_game

echo "$(date): cleaning up games.log"
su - urtadmin -c /ssd/urt/bin/gameslog_cleanup.sh

echo "$(date): updating OS packages"
apt-get --yes --quit update
apt-get --yes --quit upgrade

echo "$(date): rebooting"
reboot
