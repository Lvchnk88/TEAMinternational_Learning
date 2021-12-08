#!/bin/bas

nstall_tomcat () {
sudo apt install default-jdk

sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat
cd /tmp
wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.0.20/bin/apache-tomcat-8.0.20.zip
#   sudo apt-add-repository "deb https://repository.apache.org/content/repositories/snapshots/org/apache/tomcat/tomcat-catalina/8.0-SNAPSHOT/tomcat-catalina-8.0-20140804.190218-19.jar"

unzip apache-tomcat-8.0.20.zip
sudo mkdir -p /opt/tomcat
sudo mv apache-tomcat-8.0.20 /opt/tomcat/
sudo ln -s /opt/tomcat/apache-tomcat-8.0.20 /opt/tomcat/latest
sudo chown -R tomcat: /opt/tomcat
sudo sh -c 'chmod +x /opt/tomcat/latest/bin/*.sh'

cat << EOF > /etc/systemd/system/tomcat.service
[Unit]
Description=Tomcat 8.0.20 servlet container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/default-java"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom"

Environment="CATALINA_BASE=/opt/tomcat/latest"
Environment="CATALINA_HOME=/opt/tomcat/latest"
Environment="CATALINA_PID=/opt/tomcat/latest/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/opt/tomcat/latest/bin/startup.sh
ExecStop=/opt/tomcat/latest/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl stop tomcatw
udo systemctl enable tomcat
sudo ufw allow 8080
}
