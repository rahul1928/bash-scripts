#!/bin/bash

function deploy_war {

echo "remove old war"
rm -rf /srv/tomcat/server/webapps/*

echo "Download war in webapps location"
/root/.local/lib/aws/bin/aws s3 cp s3://bucket-name/ROOT.war /srv/tomcat/server/webapps/

echo "service tomcat start"
/etc/init.d/tomcat-server start
}


function zabbix_agent_ip_insert {
IP=`ifconfig eth0 | grep "inet addr" | cut -d ':' -f 2 | cut -d ' ' -f 1`
sed -i "s/ListenIP=.*/ListenIP=$IP/" /etc/zabbix/zabbix_agentd.conf
service zabbix-agent start
}

deploy_war
zabbix_agent_ip_insert
