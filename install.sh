#/bin/bash

sudo apt-get update
sudo apt-get -y install git apache2 php php-gd ffmpeg motion
cd /var/www
sudo rm -r html/
sudo git clone https://github.com/kcinnayste/photobooth html
cd /var/www/html/resources/lib
sudo git clone https://github.com/PHPMailer/PHPMailer
cd /var/www/html
sudo cp config.inc.php my.config.php
sudo mkdir -p /var/www/html/images
sudo mkdir -p /var/www/html/keying
sudo mkdir -p /var/www/html/print
sudo mkdir -p /var/www/html/qrcodes
sudo mkdir -p /var/www/html/thumbs
sudo mkdir -p /var/www/html/tmp
sudo chown -R pi: /var/www/
sudo chmod -R 777 /var/www
cd ~

#Install libphoto2
wget https://raw.githubusercontent.com/gonzalo/gphoto2-updater/master/gphoto2-updater.sh && sudo bash gphoto2-updater.sh -s

#Sudo rights to webserver
sudo echo "www-data ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

#Add MouseHide
sudo apt-get -y install unclutter

#Autostart LXDE
echo "@xset s off" >> /etc/xdg/lxsession/LXDE-pi/autostart
echo "@xset -dpms" >> /etc/xdg/lxsession/LXDE-pi/autostart
echo "@xset s noblank" >> /etc/xdg/lxsession/LXDE-pi/autostart
echo "@chromium-browser --incognito --kiosk http://localhost/ --touch-events=enabled" >> /etc/xdg/lxsession/LXDE-pi/autostart
echo "@unclutter -idle 0" >> /etc/xdg/lxsession/LXDE-pi/autostart

echo "Die IP-Adresse lautet:"
ifconfig | grep eth0 -A 1 | grep -P -o "(?<=inet )\d+\.\d+\.\d+\.\d+"^C

echo "System startet nun neu"

sudo shutdown -r now
