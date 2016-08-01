#!/usr/bin/env bash

# Setup Apache2
sudo apt-get -qqy install apache2

# Setup mysql
echo 'Installing mysql...'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password pass'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password pass'
sudo apt-get -y install mysql-server php5-mysql


# Setup wp command line tool
echo 'Setting up wp-cli...'
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
sudo apt-get -qqy install php5-cli
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp


# Download WordPress core files
wp core download

wp core config --dbname=decision2016 --dbuser=root --dbpass=pass

currentdirectory=${PWD##*/}

#password=$(LC_CTYPE=C tr -dc A-Za-z0-9_\!\@\#\$\%\^\&\*\(\)-+= < /dev/urandom | head -c 12)
password='pass'

wp db create

wp core install --url="http://localhost/$currentdirectory" \
                --title="Decision2016" --admin_user="admin" \
                --admin_password="$password" \
                --admin_email="user@example.org"

wp theme install https://github.com/Automattic/_s/archive/master.zip --activate
