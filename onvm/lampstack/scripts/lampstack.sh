#!/usr/bin/env bash

echo 'Installing mysql, apache2 and php 5...'
sudo apt-get -qqy update
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password pass'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password pass'

sudo apt-get -qqy install mysql-server
sudo apt-get -qqy install php5 php5-mysql unzip

echo 'ServerName localhost' | sudo tee -a /etc/apache2/apache2.conf >/dev/null

# The following code is just to setup limesurvey application

echo "create database limesurvey" | mysql -uroot -ppass

sudo unzip -qq ~/onvm/lampstack/app/limesurvey.zip -d /var/www/html
sudo chown -R www-data:www-data /var/www/html/limesurvey
sudo cp /var/www/html/limesurvey/application/config/config-sample-mysql.php \
  /var/www/html/limesurvey/application/config/config.php

# Replace the password
cmdStr=$(echo "s/'password' => ''/'password' => 'pass'/g")
sudo sed -i -e "${cmdStr}" /var/www/html/limesurvey/application/config/config.php

cd /var/www/html/limesurvey/application/commands
php console.php install root pass Admin admin@interop.com
