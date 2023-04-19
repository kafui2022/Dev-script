#!/bin/bash

    #Authors: Claudele
    #Date: 13-June-2022

## Writing a script to automate Jenkins installation and Configuration

## Installing jenkins on centos 7 server
# Step1: Install Java since Jenkins is a Java application
echo "Java installation start"

yum install java-11-openjdk -y
if [ $? -eq 0 ]
then 
echo "Java installation successfull"
else 
echo "Java installation failed"
exit 1
fi


## Step2: Enable the Jenkins repository
# Check if the wget command is installed; if not installed it

ls -l /usr/bin | grep -q wget

if [ $? -eq 0 ]
then 
echo "wget command already exist"
else
yum install wget -y
fi

wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo

# Desabling the key check on the repo using the sed command 

if [ -f /etc/yum.repos.d/jenkins.repo ]
then
sed -i 's/gpgcheck=1/gpgcheck=0/g' /etc/yum.repos.d/jenkins.repo
else 
echo "jenkins.repo file does not exist. verify the previous command line and start the script all over "
exit 1
fi


## Step3: Install the latest stable version of Jenkins

yum install jenkins -y

if [ $? -eq 0 ]
then 
echo "jenkins successfully installed"
else
echo "jenkins installation failed. Verify the installation command line and start the script all over"
exit 1
fi

# Start Jenkins

systemctl start jenkins

# Check Jenkins status to find out if the daemon is running
systemctl status jenkins

# Enable the Jenkins service to start on system boot

systemctl enable jenkins

##Step4: Adjust the firewall
# verifiy if the firewall daemon exist in the system then start it
if [ -f /etc/sysconfig/firewalld ]
then 
systemctl start firewalld
else
yum install firewalld -y
systemctl start firewalld
fi

#Adjust the the firewall by adding the port 8080

firewall-cmd --permanent --zone=public --add-port=8080/tcp
firewall-cmd --reload

if [ $? -eq 0 ]
then
echo "Jenkins Installation and configuration completed"
fi

sleep 10

echo "copy the the IP address displayed, Launch your google chrome browser an type the IP address(startin with 192) below and paste it on your browser followed by the port number :8080 (ip:8080)"

ip a | grep 192

sleep 30

echo "To set up Jenkins in the browser,"

sleep 5

echo "copy the password displayed below and paste it for your jenkins first login as administrator: "

cat /var/lib/jenkins/secrets/initialAdminPassword

sleep 10

echo "Once login as admin, click on INSTALLED SUGGESTED PLUGINS and create your first admin user by providing a USERNAME and a PASSWORD"

sleep 3

echo "Enjoy Jenkins"

#End
