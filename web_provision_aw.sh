#!/bin/bash

# REPO UPDATE DAN INSTALASI PACKAGE
echo "Repo Update"
sudo apt update
echo "======================="

echo "Instalasi Nginx Web Server"
sudo apt install nginx -y
echo "========================"

echo "Instalasi PHP"
sudo apt update
sudo apt install php7.2-fpm php7.2-mysql -y

echo "Instalasi s3fs"
sudo apt install automake autotools-dev fuse g++ git libcurl4-gnutls-dev libfuse-dev libssl-dev libxml2-dev make pkg-config -y
sudo apt install s3fs mysql-client -y
echo "Repo Update dan Instalasi Package Selesai"
echo "======================="

# KONFIGURASI DIREKTORI WEB CONTENT
echo "Membuat Direktori Server Blocks"
sudo mkdir -p /app/
echo "========================="

echo "Set Ownership Direktori Server Blocks"
sudo chown -R ubuntu:ubuntu /app/
echo "========================="

echo "Set Permission Folder /app/"
sudo chmod -R 755 /app
echo "Konfigurasi Direktori Web Content Selesai"
echo "========================"

# CLONE SOURCE CODE
#echo "Clone Source Code sosial-media"
#cd /app
#sudo git clone https://github.com/ibnuzamra/sosial-media.git .
#sudo sed -i 's/database_name_here/namadb/g' /app/config.php
#sudo sed -i 's/username_here/username/g' /app/config.php
#sudo sed -i 's/password_here/password/g' /app/config.php
#sudo sed -i 's/localhost/hostdb/g' /app/config.php
#echo "Clone Source Code Selesai"
echo "========================"

echo "Import DB"
mysql -u username -h hostdb -ppassword namadb < dump.sql

# KONFIGURASI NGINX
echo "Konfigurasi Nginx"
cd
sudo git clone https://github.com/ibnuzamra/SP1-CILSY.git
sudo unlink /etc/nginx/sites-enabled/default
sudo mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
sudo cp SP1-CILSY/sosial-media /etc/nginx/sites-available/default
sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/
sudo rm -rf SP1-CILSY/
echo "========================"

echo "Restart Service"
sudo nginx -t
sudo nginx -s reload
sudo systemctl restart php7.2-fpm.service
sudo systemctl restart nginx.service
echo "Konfigurasi Nginx Selesai"
echo "========================"
