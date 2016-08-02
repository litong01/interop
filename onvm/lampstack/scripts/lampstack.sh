#!/usr/bin/env bash

echo 'Installing mysql, apache2 and php 5...'
sudo apt-get -qqy update
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password pass'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password pass'

sudo apt-get -qqy install mysql-server
sudo apt-get -qqy install php5 php5-mysql


# Setup wp command line tool
echo 'Setting up wp-cli...'
curl -s -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
sudo apt-get -qqy install php5-cli
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp


# Download WordPress core files

echo 'Setting up wordpress...'

mkdir ~/decision2016
cd ~/decision2016

wp core download

wp core config --dbname=decision2016 --dbuser=root --dbpass=pass

wp db create

wp core install --url="http://localhost/" \
                --title="Decision2016" --admin_user="admin" \
                --admin_password="pass" \
                --admin_email="user@example.org" --skip-email

echo 'Moving wordpress to the right place.'
sudo rm /var/www/html/index.html

sudo mv ~/decision2016/* /var/www/html

echo '<IfModule mod_dir.c>' > dir.conf
echo '    DirectoryIndex index.php' >> dir.conf
echo '</IfModule>' >> dir.conf

sudo cp dir.conf /etc/apache2/mods-available/dir.conf
sudo chown root:root /etc/apache2/mods-available/dir.conf

rm dir.conf
sudo service apache2 restart

