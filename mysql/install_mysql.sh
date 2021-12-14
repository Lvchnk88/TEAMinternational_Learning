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

install_mysql () {
    apt install mysql-server -y    &> $log_path/tmp.log
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

replace_configs () {
    cp -r /home/sergii/TEAMinternational_Learning/mysql/*       /etc/mysql/    &> $log_path/tmp.log
    if [ $? -eq 0 ];
      then
            info "replace mysql.cnf complete"
      else
            tail -n20 $log_path/tmp.log
            error "replace mysql.cnf failed"
      exit 1
    fi

    cp -r /home/sergii/TEAMinternational_Learning/mysql/mysql.conf.d/*  /etc/mysql/mysql.conf.d/    &> $log_path/tmp.log
    if [ $? -eq 0 ];
      then
            info "replace mysql.conf.d/ complete"
      else
            tail -n20 $log_path/tmp.log
            error "replace mysql.conf.d/ failed"
      exit 1
    fi

}

enable_mysql () {
      systemctl enable mysql.service    &> $log_path/tmp.log
      if [ $? -eq 0 ];
          then
              info "start enable_mysql complete"
          else
              tail -n20 $log_path/tmp.log
              error "start enable_mysql failed"
          exit 1
    fi

      
}

start_mysql () {
    systemctl start mysql.service    &> $log_path/tmp.log
      if [ $? -eq 0 ];
          then
                info "start start_mysql complete"
          else
                tail -n20 $log_path/tmp.log
                error "start start_mysql failed"
          exit 1
    fi
}

main () {

install_mysql

replace_configs

enable_mysql

start_mysql

}

main
