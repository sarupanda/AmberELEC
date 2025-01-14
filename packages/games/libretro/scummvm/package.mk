# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present AmberELEC (https://github.com/AmberELEC)

PKG_NAME="scummvm"
PKG_VERSION="45d494876a0f7d9a488ee8a755043174a30d86f0"
PKG_SHA256="ae0350e233b9b25302da6f615b196dc3ca15e7128c50b2001852be7ff3d1ac79"
PKG_REV="1"
PKG_LICENSE="GPL2"
PKG_SITE="https://github.com/scummvm/scummvm"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="Script Creation Utility for Maniac Mansion Virtual Machine"
PKG_LONGDESC="ScummVM is a program which allows you to run certain classic graphical point-and-click adventure games, provided you already have their data files."

pre_configure_target() {
  cd ..
  rm -rf .$TARGET_NAME
  cd ${PKG_BUILD}/backends/platform
  rm -rf libretro
  git clone https://github.com/diablodiab/libretro-scummvm-backend libretro
}

configure_target() {
  :
}

make_target() {
  make -C ${PKG_BUILD}/backends/platform/libretro/build
  cd ${PKG_BUILD}/backends/platform/libretro/aux-data
  ./bundle_aux_data.bash
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp ${PKG_BUILD}/backends/platform/libretro/build/scummvm_libretro.so $INSTALL/usr/lib/libretro/
  mkdir -p $INSTALL/usr/share/scummvm
  unzip ${PKG_BUILD}/backends/platform/libretro/aux-data/scummvm.zip -d $INSTALL/usr/share/
}
