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


install_mysql () {
    yes | apt install mysql-server    &> $log_path/tmp.log
    if [ $? -eq 0 ];
      then
            info "install mysql-server complete"
      else
            tail -n20 $log_path/tmp.log
            error "install mysql-server failed"
      exit 1
    fi

    systemctl enable mysql.service    &> $log_path/tmp.log
    if [ $? -eq 0 ];
      then
            info "enable mysql.service complete"
      else
            tail -n20 $log_path/tmp.log
            error "enable mysql.service failed"
      exit 1
    fi
}

add_user_to_mysql () {
    mysql --user="root" --password="7602" --database="mysql" --execute="CREATE USER 'sergii'@'localhost' IDENTIFIED BY 'aqSWdeFRgtHY23$%67*&(';"    &> $log_path/tmp.log
    if [ $? -eq 0 ];
      then
            info "CREATE USER 'sergii' complete"
      else
            tail -n20 $log_path/tmp.log
            error "CREATE USER 'sergii' failed"
      exit 1
    fi    

    mysql --user="root" --password="7602" --database="mysql" --execute="GRANT ALL PRIVILEGES ON *.* TO 'sergii'@'localhost' WITH GRANT OPTION;"     &> $log_path/tmp.log
    if [ $? -eq 0 ];
      then
            info "GRANT ALL PRIVILEGES complete"
      else
            tail -n20 $log_path/tmp.log
            error "GRANT ALL PRIVILEGES failed"
      exit 1
    fi
}

install_php-fpm () {
    yes | apt install software-properties-common    &> $log_path/tmp.log
    if [ $? -eq 0 ];
      then
            info "software-properties-common complete"
      else
            tail -n20 $log_path/tmp.log
            error "software-properties-common failed"
      exit 1
    fi

    add-apt-repository ppa:ondrej/php    &> $log_path/tmp.log
    if [ $? -eq 0 ];
      then
            info "add-apt-repository complete"
      else
            tail -n20 $log_path/tmp.log
            error "add-apt-repository failed"
      exit 1
    fi

    apt update     &> $log_path/tmp.log

    yes | apt install php8.0-fpm php8.0-common php8.0-mysql php8.0-gmp php8.0-curl php8.0-intl php8.0-mbstring php8.0-xmlrpc php8.0-gd php8.0-xml php8.0-cli php8.0-zip    &> $log_path/tmp.log
    if [ $? -eq 0 ];
      then
            info "install related modules complete"
      else
            tail -n20 $log_path/tmp.log
            error "install related modules failed"
      exit 1
    fi
}

install_nginx () {
    apt update          &> $log_path/tmp.log
    yes | apt install nginx   &> $log_path/tmp.log
    if [ $? -eq 0 ];
      then
            info "install_nginx complete"
      else
            tail -n20 $log_path/tmp.log
            error "install_nginx failed"
      exit 1
    fi

    systemctl enable nginx.service
}


install_php_my_admin () {
    export DEBIAN_FRONTEND=noninteractive 
    yes | apt install phpmyadmin    &> $log_path/tmp.log
    if [ $? -eq 0 ];
      then
            info "install install_php_my_admin complete"
      else
            tail -n20 $log_path/tmp.log
            error "install install_php_my_admin failed"
      exit 1
    fi	
}


configuring_phpmyadmin () {
    cp $GIT_REPO/lemp_stack/phpmyadmin.conf   /etc/nginx/snippets/    &> $log_path/tmp.log
    if [ $? -eq 0 ];
      then
            info "move phpmyadmin.conf complete"
      else
            tail -n20 $log_path/tmp.log
            error "move phpmyadmin.conf failed"
      exit 1
    fi

    cp $GIT_REPO/lemp_stack/default    /etc/nginx/sites-available/    &> $log_path/tmp.log
    if [ $? -eq 0 ];
      then
            info "move default complete"
      else
            tail -n20 $log_path/tmp.log
            error "move default failed"
      exit 1
    fi

    systemctl restart nginx    &> $log_path/tmp.log

    nginx -t     &> $log_path/tmp.log
    if [ $? -eq 0 ];
      then
            info "test nginx complete"
      else
            tail -n20 $log_path/tmp.log
            error "test nginx failed"
      exit 1
    fi
}


main () {

install_mysql

add_user_to_mysql

install_php-fpm

install_nginx

install_php_my_admin

configuring_phpmyadmin

}

main