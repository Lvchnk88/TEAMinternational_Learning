#!/bin/bash

install_nginx () {
    sudo apt install nginx -y

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
    nginx -s quit

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
    cp /srv/TEAMinternational_Learning/nginx/nginx.conf            /etc/nginx/
if [ $? -eq 0 ];
      then
            info "nginx.conf  complete"
      else
            tail -n20 $log_path/tmp.log
            error "nginx.conf  failed"
      exit 1
fi

    cp /srv/TEAMinternational_Learning/nginx/conf.d                /etc/nginx/conf.d/
if [ $? -eq 0 ];
      then
            info "conf.d complete"
      else
            tail -n20 $log_path/tmp.log
            error "conf.d failed"
      exit 1
fi

    cp /srv/TEAMinternational_Learning/nginx/sites-enabled/        /etc/nginx/sites-enabled/
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
    nginx -s reload

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
sleep 5

stop_service
sleep 5

replace_configs
sleep 5

start_service

}

main


