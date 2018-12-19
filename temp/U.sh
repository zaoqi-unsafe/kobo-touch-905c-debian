#!/bin/sh
sudo apt update
sudo apt install -y  libreoffice-l10n-zh-cn g++ xfce4-terminal gcc node git emacs fcitx fcitx-googlepinyin fbreader python python3 apt-file aptitude atril thunar goldendict locales xfonts-wqy fonts-wqy-microhei fonts-wqy-zenhei leafpad libreoffice ntpdate midori
sudo apt-get autoremove -y
sudo apt-get clean
