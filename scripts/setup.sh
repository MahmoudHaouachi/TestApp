#!/bin/bash


#root
sudo su


#run back end 
cd /home/
if [ -f node.pid ] 
	then
		kill -9 ` cat node.pid `
fi
java -jar test-0.0.1-SNAPSHOT.jar> /dev/null 2> /dev/null < /dev/null & echo $! > node.pid

#unzip front
unzip -o test-ui.zip 

#install node packages

exit
sudo chmod -R 777 /home/test-ui/
cd /home/test-ui/

npm install -g @angular/cli

npm install -g

#set angular app in prod mode
cd /home/test-ui
ng build --prod

#nginx
sudo yum install epel-release
sudo yum install -y nginx
sudo service nginx start

#configure nginx
sudo su 
cd /etc/nginx/conf.d/ 
touch angular.conf
echo "server {
        listen       80 default_server;
        listen       [::]:80 default_server;
        server_name  localhost;
        #root         /home/test-ui/dist;

        location / {
         root /home/test-ui/dist;
         index index.html index.htm;
         try_files $uri $uri/ /index.html;
}

        # redirect server error pages to the static page /40x.html
        #
        error_page 404 /404.html;
            location = /40x.html {
        }
}" >> angular.conf
#restart nginx

service nginx restart