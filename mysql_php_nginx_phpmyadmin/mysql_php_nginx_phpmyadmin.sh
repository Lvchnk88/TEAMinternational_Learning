#!/bin/bash

info () {
    lgreen='\e[92m'
    nc='\033[0m'
    printf "${lgreen}[Info] ${@}${nc}\n"
}

error () {
    lgreen='\033[0;31m'
    nc='\033[0m'
    printf "${lgreen}[Error] ${@}${nc}\n"
}

#=======================================

GIT_REPO="/srv/TEAMinternational_Learning"


# PHP
install_php () {
    apt update
    apt install php-fpm    &> $log_path/tmp.log
if [ $? -eq 0 ];
      then
            info "install install_php complete"
      else
            tail -n20 $log_path/tmp.log
            error "install install_php failed"
      exit 1
fi
}


configure_php () {
    touch /var/www/html/info.php    &> $log_path/tmp.log
    cat << EOF > /var/www/html/info.php
<?php

phpinfo();
EOF

if [ $? -eq 0 ];
      then
            info "configure_php complete"
      else
            tail -n20 $log_path/tmp.log
            error "configure_php failed"
      exit 1
fi
}


configure_nginx () {
    toush /etc/nginx/sites-available/example.com       &> $log_path/tmp.log
    cat << EOF > /etc/nginx/sites-available/example.com
server {
    listen 80;

    server_name example.com www.example.com;

    root /var/www/example.com/public_html;

    index index.html;

    access_log /var/log/nginx/example.com.access.log;
    error_log /var/log/nginx/example.com.error.log;
}
EOF
}


create_a_symbolic_link () {
ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/   &> $log_path/tmp.log
if [ $? -eq 0 ];
      then
            info "create_a_symbolic_link complete"
      else
            tail -n20 $log_path/tmp.log
            error "create_a_symbolic_link failed"
      exit 1
    fi
}


test_after_install_nginx () {
    systemctl restart nginx
    nginx -t                 &> $log_path/tmp.log
if [ $? -eq 0 ];
      then
            info "test_after_install_nginx complete"
      else
            tail -n20 $log_path/tmp.log
            error "test_after_install_nginx failed"
      exit 1
    fi
}


install_php_mysql () {
    apt install php-mysql    &> $log_path/tmp.log
if [ $? -eq 0 ];
      then
            info "install_php_mysql complete"
      else
            tail -n20 $log_path/tmp.log
            error "install_php_mysql failed"
      exit 1
    fi
}


restart_php_mysql () {
    systemctl restart php-mysql    &> $log_path/tmp.log
if [ $? -eq 0 ];
      then
            info "restart_php_mysql complete"
      else
            tail -n20 $log_path/tmp.log
            error "restart_php_mysql failed"
      exit 1
    fi	
}


install_php_my_admin () {
    sudo apt install phpmyadmin    &> $log_path/tmp.log
if [ $? -eq 0 ];
      then
            info "install install_php_my_admin complete"
      else
            tail -n20 $log_path/tmp.log
            error "install install_php_my_admin failed"
      exit 1
fi	
}
