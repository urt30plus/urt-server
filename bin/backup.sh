#!/bin/bash

backup_dir="${HOME}/backups/$(hostname)"
backup_dir_ctf="${backup_dir}/ctf"
backup_dir_ts="${backup_dir}/ts"

mkdir -p "${backup_dir_ctf}"
mkdir -p "${backup_dir_ts}"

cp --verbose ${HOME}/.profile "${backup_dir}/dot_profile"
cp --verbose ${HOME}/.ssh/* "${backup_dir}"
cp --verbose /etc/sysctl.conf "${backup_dir}"
crontab -l >"${backup_dir}/crontab.txt"

cp --verbose ~/.b3/b3_ctf.ini "${backup_dir_ctf}"
cp --verbose ~/.urt30t/env.ctf "${backup_dir_ctf}"
cp --verbose /game/servers/ctf/q3ut4/*.{cfg,txt} "${backup_dir_ctf}"

cp --verbose ~/.b3/b3_ts.ini "${backup_dir_ts}"
cp --verbose ~/.urt30t/env.ts "${backup_dir_ts}"
cp --verbose /game/servers/ts/q3ut4/*.{cfg,txt} "${backup_dir_ts}"

backup_file="/tmp/backup_$(date +'%W-%w').tar.gz"
tar cvzf ${backup_file} -C ${HOME} ${backup_dir}

sftp urt30web@urt30web.site.nfoservers.com <<SFTP_PUT
cd private/backups/$(hostname)
put ${backup_file}
bye
SFTP_PUT

rm -v ${backup_file}
