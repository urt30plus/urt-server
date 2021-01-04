#!/bin/bash
set -e
export LANG=C.UTF-8

PY_VER=${1?:"must provide a version, ex. 3.9.1"}

PY_BASE=/opt/python
PY_BUILD_DIR=${PY_BASE}/build
PY_HOME=${PY_BASE}/python${PY_VER}

if [[ ! -d $PY_BASE || ! -d $PY_BUILD_DIR ]]; then
	echo "Directories ${PY_BASE} and ${PY_BUILD_DIR} must exist"
	exit 1
fi
if [[ -d $PY_HOME ]]; then
	echo "${PY_HOME} directory already exists, aborting build"
	exit 1
fi

sudo apt-get update
sudo apt-get install build-essential \
	zlib1g-dev \
	libncurses5-dev \
	libgdbm-dev \
	libgdbm-compat-dev \
	libnss3-dev \
	libssl-dev \
	libreadline-dev \
	libffi-dev \
	libsqlite3-dev \
	wget \
	libbz2-dev \
	uuid-dev \
	lzma-dev \
	liblzma-dev

echo "Building Python v${PY_VER} at ${PY_HOME}"
cd ${PY_BUILD_DIR}
wget https://www.python.org/ftp/python/${PY_VER}/Python-${PY_VER}.tgz 
tar xzf Python-${PY_VER}.tgz
cd Python-${PY_VER}

mkdir ${PY_HOME}
./configure \
    --prefix=${PY_HOME} \
    --with-system-expat \
    --with-system-ffi \
    --without-ensurepip \
    --enable-optimizations

make -s -j4

make install

${PY_HOME}/bin/python3 -V
