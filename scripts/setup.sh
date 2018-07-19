#!/bin/bash


#root
sudo su


#run back end 
cd /home/
java -jar test-0.0.1-SNAPSHOT.jar

#unzip front
unzip test-ui.zip

#install node packages
cd /home/test-ui/
npm install

#set angular app in prod mode
cd /home/test-ui
ng build --prod

#configure nginx

echo "server {
    listen 80 default_server;
    listen [::]:80 default_server;
 
    root /home/test-ui/dist;
    index index.html index.htm index.nginx-debian.html;
 
    server_name _;
 
    location / {
        try_files $uri $uri/ /index.html =404;
    }
} " >> /etc/nginx/sites-available/default

#restart nginx
service nginx restart