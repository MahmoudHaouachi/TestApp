#!/bin/bash





#update

yum update


# Script to Install JAVA 8 (JDK 8u40) on CentOS/RHEL 7/6/5 and Fedora
echo "Installing Java 8 (64bit)"

sudo yum install -y java-1.8.0-openjdk

sudo yum remove -y java-1.7.0-openjdk


# maven
TEMPORARY_DIRECTORY="$(mktemp -d)"
DOWNLOAD_TO="$TEMPORARY_DIRECTORY/maven.tgz"

echo 'Downloading Maven to: ' "$DOWNLOAD_TO"

sudo wget -O "$DOWNLOAD_TO" http://apache.mirrors.lucidnetworks.net/maven/maven-3/3.5.3/binaries/apache-maven-3.5.3-bin.tar.gz

echo 'Extracting Maven'
sudo tar xzf $DOWNLOAD_TO -C $TEMPORARY_DIRECTORY
sudo rm $DOWNLOAD_TO

echo 'Configuring Envrionment'

sudo mv $TEMPORARY_DIRECTORY/apache-maven-* /usr/local/maven
echo -e 'export M2_HOME=/usr/local/maven\nexport PATH=${M2_HOME}/bin:${PATH}' > /etc/profile.d/maven.sh
sudo source /etc/profile.d/maven.sh

#not sure about how to set the current environment under the sudo
#sudo -u "$SUDO_USER" env  "M2_HOME=/usr/local/maven"
#sudo -u "$SUDO_USER" env "PATH=/usr/local/maven/bin:${PATH}"


echo 'The maven version: ' `mvn -version` ' has been installed.'
echo -e '\n\n!! Note you must relogin to get mvn in your path !!'
echo 'Removing the temporary directory...'
sudo rm -r "$TEMPORARY_DIRECTORY"
echo 'Your Maven Installation is Complete.'



#install mysql
sudo yum install -y mysql-server



