#!/bin/bash

gdrive_dir="${HOME}/gdrive/backups/$(hostname)"
config_dir="${gdrive_dir}/configs"
config_dir_ts="${gdrive_dir}/configs_ts"

mkdir -p "${config_dir_ts}"

cp --verbose ${HOME}/.profile "${config_dir}/dot_profile"
cp --verbose ${HOME}/.ssh/authorized_keys "${config_dir}"

cp --verbose /lib/systemd/system/urt43_* "${config_dir}"

cp --verbose ~/.b3/*.* "${config_dir}"
cp --verbose /game/logs/b3.log "${config_dir}"

cp --verbose /game/servers/main/q3ut4/*.cfg "${config_dir}"
cp --verbose /game/servers/main/q3ut4/*.txt "${config_dir}"

cp --verbose /game/servers/ts/q3ut4/*.cfg "${config_dir_ts}"
cp --verbose /game/servers/ts/q3ut4/*.txt "${config_dir_ts}"

cp --verbose /etc/sysctl.conf "${config_dir}"

crontab -l >"${config_dir}/crontab.txt"


backup_file="/tmp/gdrive_$(date +'%W-%w').tar.gz"
tar cvzf ${backup_file} -C ${HOME} gdrive

sftp urt30web@urt30web.site.nfoservers.com <<SFTP_PUT
cd private/backups/$(hostname)
put ${backup_file}
bye
SFTP_PUT

rm -v ${backup_file}
