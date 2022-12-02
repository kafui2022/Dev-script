#!/bin/bash

##Description: Sonarqube installation on centos7

#Author:gigi

#Date: 2 dec 2022


# Please run as user vagrant

user_name=`whoami`

Su - vagrant

if [ $user_name != vagrant ];
then

echo "Must be run user vagrant !!!!"
exit 99
fi


#Install Java (Oracle JRE 11 or Open JDK 11)

sudo yum update -y
sudo yum install java-11-openjdk-devel -y
sudo yum install java -11-openjdk -y

# Dowload the latest sonarqube versions

cd /opt
sudo yum install wget -y

sudo wget https://binairies.sonarsource.com/Distribution/sonarqube/sonarqube-9.3.0.51899.zip


# Extract the package

sudo yum install unzip
sudo unzip /opt/sonarqube-9.3.0.51899.zip


# Change owership to the user and Switch to linux binaries directory start service

sudo chown -R vagrant:bagrant /opt/sonarqube-9.3.0.51899
cd /opt/sonarqube-9.3.0.51899/bin/linux-x86-64

# Enable firewall and Open port 9000 for sonarqube to use
sudo firewall-cmd --permanent -- add-port=9000/tcp
sudo firewall-cmd --reload

./sonar.sh start

echo "sonarqube successfully install on your centos7. Connect to the Sonarqube browser using: http://<ip address>:9000"


