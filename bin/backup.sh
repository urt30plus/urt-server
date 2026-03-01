#!/bin/bash

backup_dir="${HOME}/backups/$(hostname)"

mkdir -p "${backup_dir}"

cp --verbose ${HOME}/.profile "${backup_dir}/dot_profile"
cp --verbose ${HOME}/.ssh/* "${backup_dir}"
cp --verbose /etc/sysctl.conf "${backup_dir}"
crontab -l >"${backup_dir}/crontab.txt"

cp --verbose -R ~/.config/ "${backup_dir}/config/"
cp --verbose $HOME/server/q3ut4/*.{cfg,txt} "${backup_dir}"

backup_file="/tmp/backup_$(date +'%W-%w').tar.gz"
tar cvzf ${backup_file} -C ${HOME} ${backup_dir}

sftp urt30web@urt30web.site.nfoservers.com <<SFTP_PUT
cd private/backups/$(hostname)
put ${backup_file}
bye
SFTP_PUT

rm -v ${backup_file}
