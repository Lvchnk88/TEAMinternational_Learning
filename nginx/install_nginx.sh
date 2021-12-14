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

install_nginx () {
    apt install nginx -y     &> $log_path/tmp.log

if [ $? -eq 0 ];
      then
            info "install_nginx complete"
      else
            tail -n20 $log_path/tmp.log
            error "install_nginx failed"
      exit 1
fi
}

test_after_install () {
     nginx -t                &> $log_path/tmp.log

if [ $? -eq 0 ];
      then
            info "test_after_install complete"
      else
            tail -n20 $log_path/tmp.log
            error "test_after_install failed"
      exit 1
fi
}

replace_configs () {
    cp /srv/TEAMinternational_Learning/nginx/nginx.conf   /etc/nginx/   &> $log_path/tmp.log
if [ $? -eq 0 ];
      then
            info "nginx.conf  complete"
      else
            tail -n20 $log_path/tmp.log
            error "nginx.conf  failed"
      exit 1
fi

    cp -r /srv/TEAMinternational_Learning/nginx/conf.d/*   /etc/nginx/conf.d/   &> $log_path/tmp.log
if [ $? -eq 0 ];
      then
            info "conf.d complete"
      else
            tail -n20 $log_path/tmp.log
            error "conf.d failed"
      exit 1
fi

    cp -r /srv/TEAMinternational_Learning/nginx/sites-enabled/*  /etc/nginx/sites-enabled/  &> $log_path/tmp.log
if [ $? -eq 0 ];
      then
            info "sites-enabled complete"
      else
            tail -n20 $log_path/tmp.log
            error "sites-enabled failed"
      exit 1
fi

}

test_after_configs () {
     nginx -t                 &> $log_path/tmp.log

if [ $? -eq 0 ];
      then
            info "test_after_configs complete"
      else
            tail -n20 $log_path/tmp.log
            error "test_after_configs failed"
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

start_service () {
    systemctl restart nginx     &> $log_path/tmp.log

if [ $? -eq 0 ];
      then
            info "start_service complete"
      else
            tail -n20 $log_path/tmp.log
            error "start_service failed"
      exit 1
fi
}

main () {

install_nginx

test_after_install

replace_configs

test_after_configs

enable_nginx

start_service

}

main
