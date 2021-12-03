#!/bin/bash

GIT="/home/sergii/TEAMinternational_Learning/nginx"


install_nginx () {
    sudo apt install nginx -y
}

stop_service () {
    nginx -s quit
}

replace_configs () {
    cp $GIT                       /etc/nginx/nginx.conf
    cp $GIT/cong.d                /etc/nginx/conf.d/
    cp $GIT/cong.d/sites-enabled/ /etc/nginx/sites-enabled/
}

start_service () {
    nginx -s reload
}

