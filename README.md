# 30+ UrT Game Server

## Server daemon account

Run as the root user, all other commands should be run as the `urtadmin` user.

```bash
useradd -m -s /bin/bash -c "UrT Server Daemon" urtadmin \
  && loginctl enable-linger urtadmin \
  && apt-get update \
  && apt-get -y install unzip git git-lfs
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
  && echo ". \$HOME/.config/urt30plus/env" >> .profile \
  && git clone git clone git@github.com:urt30plus/b3.git \ 
  && git clone git clone git@github.com:urt30plus/urt30t.git \ 
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

## Servers

The `$HOME/servers` directory contains the various game servers.

`$HOME/share/UrbanTerror43` - This is the base official install, directory is read-only.

_IMPORTANT_: do not add/modify files in this directory. Put configs and maps
in the other specific server directories. Also, game logs will be stored in
the server specific directories.

## Systemd services

The systemd service files are kept in `$HOME/.config/systemd/user`. The following
command are required in order to set up the services.

```bash
systemctl --user daemon-reload
systemctl --user enable --now urt43
systemctl --user enable --now b3
systemctl --user enable --now urt30t
```

