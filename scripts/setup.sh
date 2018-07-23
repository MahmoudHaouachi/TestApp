#!/bin/bash


#run back end 
cd /home/
if [ -f node.pid ] 
	then
		kill -9 ` cat node.pid `
fi
java -jar test-0.0.1-SNAPSHOT.jar> /dev/null 2> /dev/null < /dev/null & echo $! > node.pid

#unzip front
sudo unzip -o test-ui.zip 
sudo rm -rf test-ui.zip

#configure nginx
sudo rm -rf /etc/nginx/nginx.conf
sudo mv /home/test-ui/nginx.conf /etc/nginx/
#restart nginx
service nginx restart