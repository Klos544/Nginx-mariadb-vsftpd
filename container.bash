#!/bin/bash

apt update
apt upgrade -y
apt install -y nginx mariadb-server php-fpm vsftpd
cat /etc/nginx/sites-enabled/default | sed -e 56,63's/#//' >| /etc/nginx/sites-enabled/default.bak1
cat /etc/nginx/sites-enabled/default.bak1 | sed -e 62's/fastcgi_pass 127.0.0.1:9000;/#fastcgi_pass 127.0.0.1:9000;/' >| /etc/nginx/sites-enabled/default.bak
rm -rf /etc/nginx/sites-enabled/default
rm -rf /etc/nginx/sites-enabled/default.bak1
mv /etc/nginx/sites-enabled/default.bak /etc/nginx/sites-enabled/default
sed -i 's/index index.html index.htm index.nginx-debian.html;/index index.php index.html index.htm;/' /etc/nginx/sites-enabled/default
systemctl restart nginx
echo "<?php phpinfo(); ?>" > /var/www/html/index.php
sed -i 's/listen=NO/listen=YES/' /etc/vsftpd.conf
sed -i 's/listen_ipv6=YES/listen_ipv6=NO/' /etc/vsftpd.conf
sed -i 's/#write_enable=YES/write_enable=YES/' /etc/vsftpd.conf
sed -i 's/#local_umask=022/local_umask=022/' /etc/vsftpd.conf
sed -i 's/#chroot_local_user=YES/chroot_local_user=YES/' /etc/vsftpd.conf
sed -i 's/#chroot_list_enable=YES/chroot_list_enable=YES/' /etc/vsftpd.conf
sed -i 's/#chroot_list_file=/etc/vsftpd.chroot_list/chroot_list_file=/etc/vsftpd.chroot_list/' /etc/vsftpd.conf
sed -i 's/ssl_enable=NO/ssl_enable=YES/' /etc/vsftpd.conf
