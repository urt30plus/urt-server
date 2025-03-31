#!/bin/bash

backup_dir="${HOME}/backups/$(hostname)"
backup_dir_main="${backup_dir}/main"
backup_dir_ts="${backup_dir}/ts"
backup_dir_priv="${backup_dir}/private"

mkdir -p "${backup_dir_main}"
mkdir -p "${backup_dir_ts}"
mkdir -p "${backup_dir_priv}"

cp --verbose ${HOME}/.profile "${backup_dir}/dot_profile"
cp --verbose ${HOME}/.ssh/* "${backup_dir}"
cp --verbose /etc/sysctl.conf "${backup_dir}"
crontab -l >"${backup_dir}/crontab.txt"

cp --verbose ~/.b3/b3_main.ini "${backup_dir_main}"
cp --verbose ~/.urt30t/env.main "${backup_dir_main}"
cp --verbose /game/servers/main/q3ut4/*.{cfg,txt} "${backup_dir_main}"

cp --verbose ~/.b3/b3_ts.ini "${backup_dir_ts}"
cp --verbose ~/.urt30t/env.ts "${backup_dir_ts}"
cp --verbose /game/servers/ts/q3ut4/*.{cfg,txt} "${backup_dir_ts}"

cp --verbose /game/servers/private/q3ut4/*.{cfg,txt} "${backup_dir_priv}"

backup_file="/tmp/backup_$(date +'%W-%w').tar.gz"
tar cvzf ${backup_file} -C ${HOME} ${backup_dir}

sftp urt30web@urt30web.site.nfoservers.com <<SFTP_PUT
cd private/backups/$(hostname)
put ${backup_file}
bye
SFTP_PUT

rm -v ${backup_file}
