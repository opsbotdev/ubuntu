#!/bin/bash

if [[ ! "$DESKTOP" =~ ^(true|yes|on|1|TRUE|YES|ON])$ ]]; then
  exit
fi

SSH_USER=${SSH_USERNAME:-vagrant}

echo "==> Checking version of Ubuntu"
. /etc/lsb-release

# echo "==> Installing missing apt packages"
# echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
# sudo apt-get -qq install -y --fix-broken

echo "==> Installing apt packages"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"
sudo apt-get -qq update
sudo apt-get -qq install -y ubuntu-desktop 

# sudo apt-get -qq install -y \
#     apt-transport-https \
#     ca-certificates \
#     curl \
#     gnupg-agent \
#     software-properties-common \
#     ubuntu-desktop \
#     wget \
#     xdg-utils

echo "==> Post install config"
echo "==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>==>"

USERNAME=${SSH_USER}
LIGHTDM_CONFIG=/etc/lightdm/lightdm.conf
GDM_CUSTOM_CONFIG=/etc/gdm3/custom.conf

if [ -f $GDM_CUSTOM_CONFIG ]; then
    mkdir -p "$(dirname ${GDM_CUSTOM_CONFIG})"
    > $GDM_CUSTOM_CONFIG
    {
        echo "[daemon]"
        echo "# Enabling automatic login"
        echo "AutomaticLoginEnable = true"
        echo "AutomaticLogin = ${USERNAME}"
    } >> $GDM_CUSTOM_CONFIG
fi

if [ -f $LIGHTDM_CONFIG ]; then
    echo "==> Configuring lightdm autologin"
    {
        echo "[SeatDefaults]"
        echo "autologin-user=${USERNAME}"
        echo "autologin-user-timeout=0"
    } >> $LIGHTDM_CONFIG
fi

if [ -d /etc/xdg/autostart/ ]; then
    echo "==> Disabling screen blanking"
    {
        echo "[Desktop Entry]" 
        echo "Type=Application" 
        echo "Exec=xset -dpms s off s noblank s 0 0 s noexpose" 
        echo "Hidden=false" 
        echo "NoDisplay=false" 
        echo "X-GNOME-Autostart-enabled=true" 
        echo "Name[en_US]=nodpms" 
        echo "Name=nodpms" 
        echo "Comment[en_US]=" 
        echo "Comment=" 
    } >> /etc/xdg/autostart/nodpms.desktop
fi
