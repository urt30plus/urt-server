#!/bin/bash
# Requires https://github.com/odeke-em/drive

gdrive_dir="${HOME}/gdrive/backups/$(hostname)"
config_dir="${gdrive_dir}/configs"

cp --verbose ${HOME}/.profile "${config_dir}/dot_profile"

cp --verbose /lib/systemd/system/urt43_* "${config_dir}"

cp --verbose /ssd/game/b3/b3/conf/b3.{ini,xml} "${config_dir}"
cp --verbose /ssd/game/logs/b3.log "${config_dir}"

cp --verbose /ssd/game/UrbanTerror43/q3ut4/*.cfg "${config_dir}"
cp --verbose /ssd/game/UrbanTerror43/q3ut4/*.txt "${config_dir}"

cp --verbose /opt/spunkybot/conf/*.conf "${gdrive_dir}/spunkybot/conf/"

crontab -l >"${config_dir}/crontab.txt"

timeout 5m drive push -verbose -depth 25 -no-prompt "${HOME}/gdrive/backups/$(hostname)"
