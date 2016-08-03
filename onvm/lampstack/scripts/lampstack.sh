#!/usr/bin/env bash

echo 'Installing mysql, apache2 and php 5...'
sudo apt-get -qqy update
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password pass'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password pass'

sudo apt-get -qqy install mysql-server
sudo apt-get -qqy install php5 php5-mysql

echo 'ServerName localhost' | sudo tee -a /etc/apache2/apache2.conf >/dev/null

echo 'Creating a database...'
echo "create database decision2016" | mysql -uroot -ppass
