#!/bin/bash


#run back end 
cd /home/
if [ -f node.pid ] 
	then
		kill -9 ` cat node.pid `
fi
java -jar test-0.0.1-SNAPSHOT.jar> /dev/null 2> /dev/null < /dev/null & echo $! > node.pid



#configure nginx
sudo rm -rf /etc/nginx/nginx.conf
sudo mv /home/nginx.conf /etc/nginx/
#restart nginx
sudo service nginx restart