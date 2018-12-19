#!/bin/sh
sudo apt purge -y --force-yes xserver-xorg-video-voodoo xserver-xorg-video-vesa xserver-xorg-video-tseng xserver-xorg-video-trident xserver-xorg-video-tdfx xserver-xorg-video-sisusb xserver-xorg-video-sis xserver-xorg-video-siliconmotion xserver-xorg-video-savage xserver-xorg-video-s3virge xserver-xorg-video-s3 xserver-xorg-video-rendition xserver-xorg-video-radeon xserver-xorg-video-r128 xserver-xorg-video-neomagic xserver-xorg-video-mga xserver-xorg-video-mach64 xserver-xorg-video-i740 xserver-xorg-video-i128 xserver-xorg-video-cirrus xserver-xorg-input-all xserver-xorg-input-synaptics xserver-xorg-video-chips xserver-xorg-video-ati xserver-xorg-video-ark xserver-xorg-input-wacom xserver-xorg-video-all xserver-xorg-video-apm
echo "
xorg install
xorg-docs-core install
xorg-sgml-doctools install
xserver-xorg install
xserver-xorg-core install
xserver-xorg-input-evdev install
xserver-xorg-video-fbdev install
" |  sudo dpkg --set-selections 
