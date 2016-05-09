#!/bin/bash
#title           :configure.sh
#description     :This script configure the manga screen on RPI, you need to be root.

cat <<\EOF >> /boot/config.txt

# Manga screen Settings:
hdmi_force_hotplug=1
config_hdmi_boost=4
display_rotate=1
hdmi_cvt=480 800 60 6
hdmi_group=2
hdmi_mode=87
hdmi_drive=2
EOF

mkdir $HOME/screen

wget -O $HOME/screen/eyes.jpg https://raw.githubusercontent.com/nicolas-rabault/screen_test/master/eyes.jpg

sed -i.bkp "/^exit/i #eyes print\nfbi --noverbose -T 2 $HOME/screen/eyes.jpg\n" /etc/rc.local
