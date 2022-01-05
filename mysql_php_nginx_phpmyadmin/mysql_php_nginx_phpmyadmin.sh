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
    cp $GIT_REPO/php/info.php  /var/www/html/    &> $log_path/tmp.log
    if [ $? -eq 0 ];
      then
            info "configure_php complete"
      else
            tail -n20 $log_path/tmp.log
            error "configure_php failed"
      exit 1
    fi
}


pre_install_nginx () {
#Install the prerequisites
    apt install curl gnupg2 ca-certificates lsb-release ubuntu-keyring  &> $log_path/tmp.log
    if [ $? -eq 0 ];
      then
            info "Install the prerequisites complete"
      else
            tail -n20 $log_path/tmp.log
            error "Install the prerequisites failed"
      exit 1
    fi

#Import an official nginx signing key so apt could verify the packages authenticity. Fetch the key
    curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null  &> $log_path/tmp.log
    if [ $? -eq 0 ];
      then
            info "Import an official nginx signing key complete"
      else
            tail -n20 $log_path/tmp.log
            error "Import an official nginx signing key failed"
      exit 1
    fi

#Verify that the downloaded file contains the proper key
    gpg --dry-run --quiet --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg  &> $log_path/tmp.log
    if [ $? -eq 0 ];
      then
            info "Verify that the downloaded file complete"
      else
            tail -n20 $log_path/tmp.log
            error "Verify that the downloaded file failed"
      exit 1
    fi

#set up the apt repository for stable nginx packages
    echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" | sudo tee /etc/apt/sources.list.d/nginx.list  &> $log_path/tmp.log
    if [ $? -eq 0 ];
      then
            info "set up the apt repository for stable nginx complete"
      else
            tail -n20 $log_path/tmp.log
            error "set up the apt repository for stable nginx failed"
      exit 1
    fi
}


install_nginx () {
    sudo apt update
    sudo apt install nginx   &> $log_path/tmp.log
    if [ $? -eq 0 ];
      then
            info "install_nginx complete"
      else
            tail -n20 $log_path/tmp.log
            error "install_nginx failed"
      exit 1
    fi
}


configure_nginx () {
    mkdir /etc/nginx/sites-available
    cp $GIT_REPO/nginx/example.com /etc/nginx/sites-available/   &> $log_path/tmp.log
    if [ $? -eq 0 ];
      then
            info "configure_nginx complete"
      else
            tail -n20 $log_path/tmp.log
            error "configure_nginx failed"
      exit 1
    fi
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

enable_nginx () {
     systemctl enable nginx     &> $log_path/tmp.log
     if [ $? -eq 0 ];
      then
            info "enable_nginx complete"
      else
            tail -n20 $log_path/tmp.log
            error "enable_nginx failed"
      exit 1
    fi
}

start_nginx () {
    systemctl restart nginx     &> $log_path/tmp.log
    if [ $? -eq 0 ];
      then
            info "start_nginx complete"
      else
            tail -n20 $log_path/tmp.log
            error "start_nginx failed"
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

configure_php_my_admin () {

}


main () {

install_php_mysql
restart_php_mysql

install_php
configure_php

pre_install_nginx
install_nginx
configure_nginx
create_a_symbolic_link
test_after_install_nginx
enable_nginx
start_nginx

install_php_my_admin
configure_php_my_admin
}

main




































