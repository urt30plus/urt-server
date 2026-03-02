# 30+ UrT Game Server

## Server daemon account

Run as the root user, all other commands should be run as the `urtadmin` user.

```bash
hostnamectl set-hostname game-{ctf,ts,promod}.urt-30plus.org \
  && useradd -m -s /bin/bash -c "UrT Server Daemon" urtadmin \
  && loginctl enable-linger urtadmin \
  && apt-get update \
  && apt-get -y install unzip git git-lfs sqlite3
```

## Daemon account home directory setup

Run the following as the `urtadmin` user in the home directory.

```bash
git config --global user.email urt30plus@gmail.com \
  && git config --global user.name "Urt ThirtyPlus" \
  && mkdir $HOME/temp \
  && cd $HOME/temp \
  && git clone git@github.com:urt30plus/urt-server.git \
  && cd $HOME \
  && mv $HOME/temp/* . \
  && mv $HOME/temp/.* . \
  && echo '. "$HOME/.config/urtadmin.env"' >> .profile \
  && git clone git@github.com:urt30plus/b3.git \ 
  && git clone git@github.com:urt30plus/urt30t.git \ 
  && curl -LsSf https://astral.sh/uv/install.sh | sh \
  && . $HOME/.profile
  && uv python install --compile-bytecode 3.14.3 \
  && cd $HOME/b3 \
  && uv venv \
  && uv pip install -r requirements.txt \
  && cd $HOME/urt30t \
  && uv sync
```

## Binaries

Various server binaries are kept in the `$HOME/share` directory. For example:

```
$HOME/share/UrbanTerror43
$HOME/share/urt-slim
```

To start the `urt43` server you must create a symlink to the server binary you
wish to run:

```bash
ln -s ~/share/UrbanTerror43/Quake3-UrT-Ded.x86_64 ~/share/UrT-Ded.x86_64
```

## Servers

The `$HOME/servers` directory contains the various game servers.

`$HOME/share/UrbanTerror43` - This is the base official install, directory is read-only.

_IMPORTANT_: do not add/modify files in this directory. Put configs and maps
in the other specific server directories. Also, game logs will be stored in
the server specific directories.

## Systemd services

The systemd service files are kept in `$HOME/.config/systemd/user`. The following
command are required in order to set up the services.

To configure the server binary and port, copy the `~/.config/urtserver.env.sample` file
to `~/.config/urtserver.env` and adjust the settings as needed.

```bash
systemctl --user daemon-reload
systemctl --user enable --now urt43
systemctl --user enable --now b3
systemctl --user enable --now urt30t
```

## Network Tuning

The network buffer default sizes are pretty small on Linux. Even though the
game packets are pretty small, on a busy server the default 200k buffers can
sometimes lead to packets being dropped.

### UDP Statistics/Errors

The following command will show send/receive buffer related errors:

    netstat -ansu

### UDP Settings

The following are just an example of suggested changes.

#### Before (Debian 13/Trixie)

```
net.core.netdev_max_backlog=1000
net.core.rmem_default=212992
net.core.rmem_max=212992
net.core.wmem_default=212992
net.core.wmem_max=212992
```

#### After (/etc/sysctl.d/local.conf)

```
net.core.netdev_max_backlog = 2000
net.core.rmem_default = 524288
net.core.rmem_max = 524288
net.core.wmem_default = 524288
net.core.wmem_max = 524288
```

#### Misc Notes

Start with small increases and if buffer errors are still significant
then use the values below to tune the sizes as needed.

```
1MB = 1048576 (1024x1024)
2MB = 2097152
4MB = 4194304
```
