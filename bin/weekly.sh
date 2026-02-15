#!/bin/bash

echo "$(date): stopping b3 service"
sudo systemctl stop b3_ctf
sudo systemctl stop b3_ts

echo "$(date): stopping urt30t service"
sudo systemctl stop urt30t_ctf
sudo systemctl stop urt30t_ts

echo "$(date): stopping game service"
sudo systemctl stop urt43_ctf
sudo systemctl stop urt43_ts

echo "$(date): cleaning up games.log"
/game/bin/gameslog_cleanup.sh ctf
/game/bin/gameslog_cleanup.sh ts

echo "$(date): updating OS packages"
sudo apt-get --yes --quiet update
sudo apt-get --yes --quiet upgrade

echo "$(date): updates applied, please reboot"
