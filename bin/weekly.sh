#!/bin/bash

echo "$(date): stopping b3 service"
sudo systemctl stop urt43_b3

echo "$(date): stopping game service"
sudo systemctl stop urt43_game

echo "$(date): cleaning up games.log"
/game/bin/gameslog_cleanup.sh

echo "$(date): updating OS packages"
sudo apt-get --yes --quiet update
sudo apt-get --yes --quiet upgrade

echo "$(date): rebooting"
sudo /sbin/reboot
