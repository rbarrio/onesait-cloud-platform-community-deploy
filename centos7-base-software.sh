#!/bin/bash

#
# Copyright Indra Sistemas, S.A.
# 2013-2018 SPAIN
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#      http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# ------------------------------------------------------------------------

# Defining standard output colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
reset=`tput sgr0`

##########################################################
### Git
sudo yum install -y git

if [ $? -eq 0 ]; then
	echo "[GIT]${green}Git installed...................... [OK]${reset}" 
else
	echo "[GIT]${red}Git installed...................... [KO]${reset}"
fi	
	
##########################################################
### Docker engine CE

echo "[Docker - Step 1]${green}############################ Installing Device mapper...${reset}"

sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2
  
if [ $? -eq 0 ]; then
	echo "[$(date)]${green}Device mapper installed...................... [OK]${reset}" 
else
	echo "[$(date)]${red}Device mapper installed...................... [KO]${reset}"
fi	  
    
echo "[Docker - Step 2]${green}############################ Adding Docker repository...${reset}"
  
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo  
    
if [ $? -eq 0 ]; then
	echo "[$(date)]${green}Docker repository succesfully added...................... [OK]${reset}" 
else
	echo "[$(date)]${red}Docker repository succesfully added...................... [KO]${reset}"
fi	    

echo "[Docker - Step 3]${green}############################ Installing Docker CE...${reset}"
  
sudo yum install -y docker-ce docker-ce-cli containerd.io 

if [ $? -eq 0 ]; then
	echo "[$(date)]${green}Docker CE installed...................... [OK]${reset}" 
else
	echo "[$(date)]${red}Docker CE installed...................... [KO]${reset}"
fi

echo "[Docker - Step 4]${green}############################ Starting Docker service...${reset}"

sudo systemctl start docker

if [ $? -eq 0 ]; then
	echo "[$(date)]${green}Docker CE engine installed...................... [OK]${reset}" 
else
	echo "[$(date)]${red}Docker CE engine installed...................... [KO]${reset}"
fi	  
  

##########################################################
### Docker compose	

echo "[Docker Compose - Step 1]${green}############################ Downloading Docker Compose binary file...${reset}"

sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

echo "[Docker Compose - Step 2]${green}############################ Giving permissions...${reset}"

sudo chmod +x /usr/local/bin/docker-compose

if [ $? -eq 0 ]; then
	echo "[$(date)]${green}Docker Compose installed...................... [OK]${reset}" 
else
	echo "[$(date)]${red}Docker Compose installed...................... [KO]${reset}"
fi

exit 0