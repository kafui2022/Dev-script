#!/bin/bash

##Description: Install Jenkins on centos

#Author:gigi
#Date: Nov 2 2022



# Install Java application

sudo yum install java-11-openjdk-devel -y

# Enable the Jenkins repository

curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo

sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key

# Install the latest stable versio of Jenkins

sudo yum install jenkins -y
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo systemctl enable jenkins

# Adjust the firewall

sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
sudo firewall-cmd --reload

echo " Successfull installation of jenkins."

sleep 10

echo " Access jenkins browser by following http://your_ip_or_domain:8