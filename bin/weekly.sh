#!/bin/bash

echo "$(date): stopping b3 service"
sudo systemctl stop b3_main
sudo systemctl stop b3_ts

echo "$(date): stopping urt30t service"
sudo systemctl stop urt30t_main
sudo systemctl stop urt30t_ts

echo "$(date): stopping game service"
sudo systemctl stop urt43_main
sudo systemctl stop urt43_ts
sudo systemctl stop urt43_private

echo "$(date): cleaning up games.log"
/game/bin/gameslog_cleanup.sh main
/game/bin/gameslog_cleanup.sh ts
/game/bin/gameslog_cleanup.sh private

echo "$(date): updating OS packages"
sudo apt-get --yes --quiet update
sudo apt-get --yes --quiet upgrade

echo "$(date): updates applied, please reboot"
