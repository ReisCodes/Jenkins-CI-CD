#!/bin/bash

sudo apt-get -y update 

sudo apt-get -y upgrade 

sudo apt install nginx -y 

service nginx start

sudo apt-get install python-software-properties

curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
      
sudo apt-get install nodejs -y

npm install -g npm@9.6.5

sudo npm install -g pm2  

source .bashrc

cd app

npm install

node seeds/seed.js

pm2 start app.js

cd

