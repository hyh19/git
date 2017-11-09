#!/usr/bin/env bash

yum install epel-release -y
yum install wget tar autoconf automake libtool -y
yum install dh-autoreconf libcurl-devel expat-devel gettext-devel openssl-devel perl-devel zlib-devel -y
yum install asciidoc xmlto docbook2X -y

ln -s /usr/bin/db2x_docbook2texi /usr/bin/docbook2x-texi

# 工作目录
WORKING_DIR="/tmp"
# 安装版本
GIT_VERSION="git-2.15.0"
# 源码包名字
ARCHIVE_NAME="${GIT_VERSION}.tar.gz"
# 源码包下载地址
DOWNLOAD_URL="https://www.kernel.org/pub/software/scm/git/${ARCHIVE_NAME}"
# 源码包下载到本地后的路径
ARCHIVE_FILE="${WORKING_DIR}/${ARCHIVE_NAME}"
# 源码目录，源码解压后所在的目录。
SOURCE_DIR="${WORKING_DIR}/${GIT_VERSION}"
# 安装目录的根目录
INSTALL_ROOT="/usr/local/git"
# 安装目录
INSTALL_DIR="/${INSTALL_ROOT}/${GIT_VERSION}"

cd $WORKING_DIR

if [ ! -e "$ARCHIVE_FILE" ]; then
    wget $DOWNLOAD_URL
fi

if [ -d "$SOURCE_DIR" ]; then
    rm -rf $SOURCE_DIR
fi

tar -zxf $ARCHIVE_FILE

if [ -d "$INSTALL_DIR" ]; then
    rm -rf $INSTALL_DIR
fi

cd $SOURCE_DIR

make configure
./configure --prefix=$INSTALL_DIR
make all doc info
make install install-doc install-html install-info
