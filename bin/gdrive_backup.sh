#!/bin/bash
# Requires https://github.com/odeke-em/drive

gdrive_dir="${HOME}/gdrive/backups/$(hostname)"
config_dir="${gdrive_dir}/configs"

cp --verbose ${HOME}/.profile "${config_dir}/dot_profile"
cp --verbose /ssd/urt/UrbanTerror43/q3ut4/server.cfg "${config_dir}"
cp --verbose /ssd/urt/UrbanTerror43/q3ut4/q3config.cfg "${config_dir}"
cp --verbose /ssd/urt/UrbanTerror43/q3ut4/banlist.txt "${config_dir}"
cp --verbose /ssd/urt/b3/b3/conf/b3.xml "${config_dir}"

crontab -l >"${config_dir}/crontab.txt"

drive push -verbose -no-prompt "${HOME}/gdrive/backups/$(hostname)"
