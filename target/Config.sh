#!/bin/bash

#update
sudo apt-get update

#Java8
sudo apt-get install -y default-jre
sudo apt-get install  -y default-jdk

#Nginx
sudo apt-get install -y nginx

#Run Backend
cd /home/mahmoud/vstsagent/_work/r1/a/Drop/drop
if [ -f node.pid ] 
	then
		sudo kill -9 ` cat node.pid  `
fi
java -jar test-0.0.1-SNAPSHOT.jar> /dev/null 2> /dev/null < /dev/null & echo $! > node.pid

#Config Nginx
sudo rm -rf /etc/nginx/nginx.conf
sudo mv /home/mahmoud/vstsagent/_work/r1/a/Drop/drop/nginx.conf /etc/nginx/

#restart nginx
sudo service nginx restart


