#!/bin/bash
#title           :configure.sh
#description     :This script configure the manga screen on RPI, you need to be root.

# screen setup
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

#eyes setup
mkdir $HOME/screen

wget -O $HOME/screen/eyes.jpg https://raw.githubusercontent.com/nicolas-rabault/screen_test/master/eyes.jpg

sed -i.bkp "/^exit/i #eyes print\nfbi --noverbose -T 2 $HOME/screen/eyes.jpg\n" /etc/rc.local

#fake splash screen setup

cat <<\EOF > /etc/init.d/asplashpopy
#! /bin/sh
### BEGIN INIT INFO
# Provides:          asplashpopy
# Required-Start:
# Required-Stop:
# Should-Start:
# Default-Start:     S
# Default-Stop:
# Short-Description: Show custom Poppy splashscreen
# Description:       Show custom Poppy splashscreen
### END INIT INFO


do_start () {

    /usr/bin/fbi -T 1 -noverbose $HOME/screen/alogo-poppy-800x480.jpg
    exit 0
}

case "$1" in
  start|"")
    do_start
    ;;
  restart|reload|force-reload)
    echo "Error: argument '$1' not supported" >&2
    exit 3
    ;;
  stop)
    # No-op
    ;;
  status)
    exit 0
    ;;
  *)
    echo "Usage: asplashscreen [start|stop]" >&2
    exit 3
    ;;
esac

:
EOF

wget -O $HOME/screen/alogo-poppy-800x480.jpg https://raw.githubusercontent.com/nicolas-rabault/screen_test/master/logo-poppy-800x480.jpg

chmod a+x /etc/init.d/asplashpopy
insserv /etc/init.d/asplashpopy
