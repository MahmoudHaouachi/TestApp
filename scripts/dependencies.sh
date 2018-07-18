#!/bin/bash
sudo su
#update
yum update
#java
# Script to Install JAVA 8 (JDK 8u40) on CentOS/RHEL 7/6/5 and Fedora
echo "Installing Java 8 (64bit)"

cd /opt/

wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u40-b25/jdk-8u40-linux-x64.tar.gz"
tar xzf jdk-8u40-linux-x64.tar.gz

cd /opt/jdk1.8.0_40/

alternatives --install /usr/bin/java java /opt/jdk1.8.0_40/bin/java 2
alternatives --config java

alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_40/bin/jar 2
alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_40/bin/javac 2
alternatives --set jar /opt/jdk1.8.0_40/bin/jar
alternatives --set javac /opt/jdk1.8.0_40/bin/javac 

export JAVA_HOME=/opt/jdk1.8.0_40


# maven
TEMPORARY_DIRECTORY="$(mktemp -d)"
DOWNLOAD_TO="$TEMPORARY_DIRECTORY/maven.tgz"

echo 'Downloading Maven to: ' "$DOWNLOAD_TO"

wget -O "$DOWNLOAD_TO" http://apache.mirrors.lucidnetworks.net/maven/maven-3/3.5.3/binaries/apache-maven-3.5.3-bin.tar.gz

echo 'Extracting Maven'
tar xzf $DOWNLOAD_TO -C $TEMPORARY_DIRECTORY
rm $DOWNLOAD_TO

echo 'Configuring Envrionment'

mv $TEMPORARY_DIRECTORY/apache-maven-* /usr/local/maven
echo -e 'export M2_HOME=/usr/local/maven\nexport PATH=${M2_HOME}/bin:${PATH}' > /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh

#not sure about how to set the current environment under the sudo
#sudo -u "$SUDO_USER" env  "M2_HOME=/usr/local/maven"
#sudo -u "$SUDO_USER" env "PATH=/usr/local/maven/bin:${PATH}"


echo 'The maven version: ' `mvn -version` ' has been installed.'
echo -e '\n\n!! Note you must relogin to get mvn in your path !!'
echo 'Removing the temporary directory...'
rm -r "$TEMPORARY_DIRECTORY"
echo 'Your Maven Installation is Complete.'

