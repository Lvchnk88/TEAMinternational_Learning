#!/bin/bash

GIT_REPO=/srv/TEAMinternational_Learning

install_nginx () {
    sudo apt install nginx -y &> $log_path/tmp.log

if [ $? -eq 0 ];
      then
            info "install_nginx complete"
      else
            tail -n20 $log_path/tmp.log
            error "install_nginx failed"
      exit 1
fi
}

stop_service () {
    nginx -s quit  &> $log_path/tmp.log

if [ $? -eq 0 ];
      then
            info "stop_service complete"
      else
            tail -n20 $log_path/tmp.log
            error "stop_service failed"
      exit 1
fi
}

replace_configs () {
    cp $GIT_REPO/nginx/nginx.conf  /etc/nginx/ &> $log_path/tmp.log
if [ $? -eq 0 ];
      then
            info "nginx.conf  complete"
      else
            tail -n20 $log_path/tmp.log
            error "nginx.conf  failed"
      exit 1
fi

    cp $GIT_REPO/nginx/conf.d  /etc/nginx/conf.d/ &> $log_path/tmp.log
if [ $? -eq 0 ];
      then
            info "conf.d complete"
      else
            tail -n20 $log_path/tmp.log
            error "conf.d failed"
      exit 1
fi

    cp $GIT_REPO/nginx/sites-enabled/ /etc/nginx/sites-enabled/ &> $log_path/tmp.log
if [ $? -eq 0 ];
      then
            info "sites-enabled complete"
      else
            tail -n20 $log_path/tmp.log
            error "sites-enabled failed"
      exit 1
fi

}

start_service () {
    nginx -s reload    &> $log_path/tmp.log

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

stop_service

replace_configs

start_service

}

main

