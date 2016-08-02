#!/usr/bin/env bash

source /onvm/ini-config
eval $(parse_yaml '/onvm/conf/nodes.conf.yml' 'interop_')

# Install mongodb

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.2 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update

sudo apt-get install -y mongodb-org
sudo service mongod start


#Install node.js
echo 'Installing node.js...'

# The following code installs node.js v4
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs

# The following code installs node.js v6
#curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
#sudo apt-get install -y nodejs

# The following code installs build tools, we will skip it for now
#sudo apt-get install -y build-essential


echo 'Installing gulp and bower...'
sudo npm install -g gulp
sudo npm install -g bower
sudo npm install -g mongoose

# Install MEAN stack
echo 'Installing M.E.A.N stack...'
sudo npm install -g mean-cli


