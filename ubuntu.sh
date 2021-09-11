#!/usr/bin/env bash

#######################################  
 # Bash script to install an LAMP stack on ubuntu

 updateLinuxPackages() {
   printf '=================================== Updating all packages ============================================ \n'
   sudo apt-get update -y && sudo apt-get upgrade -y
}

 # Check if running as root  

 Checkifrunningasroot() {
   if [ "$(id -u)" != "0" ]; then  
     echo "This script must be run as root" 1>&2  
     exit 1  
 fi   
}

 ## Install APache  

 InstallAPache() {
   echo -e "\n Installing Apache2"
   sudo apt-get install apache2 -y
}

 # Install MySQL 

 InstallMySQL() {
   echo -e "\n Installing MySQL"
   sudo apt-get install mysql-server mysql-client  -y
}

 ## Install PHP  

 InstallPHP() {
   echo -e "\n Installing PHP"
   sudo add-apt-repository ppa:ondrej/php
   sudo apt update
   apt install php libapache2-mod-php php-mysql
}

 # Set Permissions  

 SetPermissions() {
   echo -e "\n\nPermissions for /var/www/html\n"
   sudo chown -R www-data:www-data /var/www/html 
}


 # Enabling Mod Rewrite 
 # this is a script that enables the specified module within the apache2 configuration,It does this by creating symlinks within  /etc/apache2/mods-enabled.
 
 EnablingModRewrite() {
   echo -e "\n\nEnabling Modules\n"
   sudo a2enmod rewrite
   sudo phpenmod mcrypt
}


 # Restart Apache  

 restartApache() {
   echo -e "Restarting Apache"
   sudo service apache2 restart
   echo -e "\n Installation successfull"
}

 # RUN

run() {

  updateLinuxPackages
  #Checkifrunningasroot 
  InstallAPache 
  InstallMySQL
  InstallPHP
  SetPermissions 
  EnablingModRewrite 
  restartApache
} 

run
