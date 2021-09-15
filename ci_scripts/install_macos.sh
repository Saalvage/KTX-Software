#!/bin/sh
# Copyright 2015-2020 The Khronos Group Inc.
# SPDX-License-Identifier: Apache-2.0

# exit if any command fails
set -e

#brew update > /dev/null
#brew install git-lfs
#git lfs install
#git lfs version
#brew install doxygen
#brew install sdl2
#brew link sdl2
gem install xcpretty

# Need to use macports because Brew does not support universal binaries
#curl -LO https://raw.githubusercontent.com/GiovanniBussi/macports-ci/master/macports-ci
#curl -LO https://raw.githubusercontent.com/MarkCallow/macports-ci/bigsur/macports-ci
#source ./macports-ci install
#source macports-ci ccache
# I can't find a way to programmatically check if a port is installed.
# `port installed openimageio` exits with 0 regardless of installation. So ...
#if [ -d /opt/local/var/macports/software/openimageio ]; then
#  port upgrade openimageio
#else
#  # m4 is a dependency of OIIO. Currently it needs patching to support +universal.
#  # See https://trac.macports.org/ticket/62991#comment:45. A was committed 9/4/2021.
#  # Watch for a mac ports release > 2.7.1.
#  sudo port install m4
#  find /opt/local -name m4 -type d
#  #pushd /opt/local/var/macports/sources/rsync.macports.org/release/tarballs/ports/devel/m4
#  pushd /opt/local/var/macports/sources/rsync.macports.org/macports/release/tarballs/ports/devel/m4
#  #sudo mv Portfile Portfile.orig
#  #sudo awk '/PortGroup/ { printf("%s\nPortGroup\t\tmuniversal 1.0\n",$0); } !/PortGroup/ {print $0}' Portfile.orig > Portfile
#  #popd
#  sudo port install openimageio +universal
#fi
#source macports-ci ccache --save

# Current directory is .../build/{KhronosGroup,msc-}/KTX-Software. cd to 'build'.
pushd ../..
wget -O vulkansdk-macos-$VULKAN_SDK_VER.dmg https://sdk.lunarg.com/sdk/download/$VULKAN_SDK_VER/mac/vulkansdk-macos-$VULKAN_SDK_VER.dmg?Human=true
hdiutil attach vulkansdk-macos-$VULKAN_SDK_VER.dmg
sudo /Volumes/vulkansdk-macos-$VULKAN_SDK_VER/InstallVulkan.app/Contents/macOS/InstallVulkan --root "$VULKAN_INSTALL_DIR" --accept-licenses --default-answer --confirm-command install
hdiutil detach /Volumes/vulkansdk-macos-$VULKAN_SDK_VER
rm vulkansdk-macos-$VULKAN_SDK_VER.dmg
popd
