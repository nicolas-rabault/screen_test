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

#todo : find something downloadable
#wget http://vector-magz.com/wp-content/uploads/2013/09/googly-eyes-clip-art.jpg


sed -i.bkp "/^exit/i #eyes print\nfbi --noverbose -T 2 /home/poppy/screen/eyes.jpg\n" /etc/rc.local
