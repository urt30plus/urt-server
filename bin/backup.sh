#!/bin/bash

server=${1:?must provide the server to back up}

backup_dir="${HOME}/backups/${GAME_HOSTNAME}/${server}"

mkdir -p "${backup_dir}"

cp --verbose ${HOME}/.profile "${backup_dir}/dot_profile"
cp --verbose ${HOME}/.ssh/* "${backup_dir}"
cp --verbose /etc/sysctl.conf "${backup_dir}"
crontab -l >"${backup_dir}/crontab.txt"

cp --verbose ~/.config/b3/${server}.ini "${backup_dir}"
cp --verbose ~/.config/urt30t/env.${server} "${backup_dir}"
cp --verbose $HOME/servers/${server}/q3ut4/*.{cfg,txt} "${backup_dir}"

backup_file="/tmp/backup_$(date +'%W-%w').tar.gz"
tar cvzf ${backup_file} -C ${HOME} ${backup_dir}

sftp urt30web@urt30web.site.nfoservers.com <<SFTP_PUT
cd private/backups/${GAME_HOSTNAME}
put ${backup_file}
bye
SFTP_PUT

rm -v ${backup_file}
