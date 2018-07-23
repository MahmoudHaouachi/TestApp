#!/bin/bash


#run back end 
cd /home/
if [ -f node.pid ] 
	then
		sudo kill -9 ` cat node.pid `
fi
sudo java -jar test-0.0.1-SNAPSHOT.jar> /dev/null 2> /dev/null < /dev/null & echo $! > node.pid

#unzip front
sudo unzip -o test-ui.zip 
sudo rm -rf test-ui.zip

#configure nginx
sudo su 
cd /etc/nginx/conf.d/ 
touch angular.conf
echo "server {
        listen       80 ;
        server_name  localhost;

        location / {
         root /home/test-ui/dist/test-ui;
         index index.html index.htm;
         
}

        # redirect server error pages to the static page /40x.html
        #
        error_page 404 /404.html;
            location = /40x.html {
        }
}" >> angular.conf
#restart nginx
service nginx restart