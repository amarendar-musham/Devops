echo need to run as sudo
read -p "is it ok for you ? " test
echo need user input
add-apt-repository -y ppa:webupd8team/java && apt-get update && apt-get -y install oracle-java8-installer
echo wait for a while till process completes
## elastic search  installation
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add - && echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" |  tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list && apt-get update && apt-get -y install elasticsearch
echo "network.host: localhost" >> /etc/elasticsearch/elasticsearch.yml
service elasticsearch restart && update-rc.d elasticsearch defaults 95 10 

##Install Kibana

echo "deb http://packages.elastic.co/kibana/4.5/debian stable main" | sudo tee -a /etc/apt/sources.list.d/kibana-4.5.x.list
apt-get update && apt-get -y install kibana 

echo 'server.host: "localhost"' >> /opt/kibana/config/kibana.yml
update-rc.d kibana defaults 96 9 && service kibana start

apt-get -y install nginx apache2-utils 

echo ; echo ; echo 'set password for user """ amar """'; echo 
htpasswd -c /etc/nginx/htpasswd.users amar && service nginx restart

echo 'deb http://packages.elastic.co/logstash/2.2/debian stable main' | sudo tee /etc/apt/sources.list.d/logstash-2.2.x.list && apt-get update && apt-get install -y logstash 
mkdir -p /etc/pki/tls/certs && mkdir /etc/pki/tls/private

echo " subjectAltName = IP: localhost " >> /etc/ssl/openssl.cnf
cd /etc/pki/tls && openssl req -config /etc/ssl/openssl.cnf -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout private/logstash-forwarder.key -out certs/logstash-forwarder.crt

## input logstash

> /etc/logstash/conf.d/02-beats-input.conf
echo "input {" >> /etc/logstash/conf.d/02-beats-input.conf
echo "   beats {" >> /etc/logstash/conf.d/02-beats-input.conf
echo "     port => 5044" >> /etc/logstash/conf.d/02-beats-input.conf
echo "     ssl => true" >> /etc/logstash/conf.d/02-beats-input.conf
echo '     ssl_certificate => "/etc/pki/tls/certs/logstash-forwarder.crt"' >> /etc/logstash/conf.d/02-beats-input.conf
echo '     ssl_key => "/etc/pki/tls/private/logstash-forwarder.key"' >> /etc/logstash/conf.d/02-beats-input.conf
echo "   }" >> /etc/logstash/conf.d/02-beats-input.conf
echo "} " >> /etc/logstash/conf.d/02-beats-input.conf

## filter logstash

> /etc/logstash/conf.d/10-syslog-filter.conf
echo "filter {" >> /etc/logstash/conf.d/10-syslog-filter.conf
echo " if [type] == "syslog" {" >> /etc/logstash/conf.d/10-syslog-filter.conf
echo "   grok {" >> /etc/logstash/conf.d/10-syslog-filter.conf
echo "     match => { "message" => "%{SYSLOGTIMESTAMP:syslog_timestamp} %{SYSLOGHOST:syslog_hostname} %{DATA:syslog_program}(?:\[%{POSINT:syslog_pid}\])?: %{GREEDYDATA:syslog_message}" }" >> /etc/logstash/conf.d/10-syslog-filter.conf
echo "     add_field => [ "received_at", "%{@timestamp}" ]" >> /etc/logstash/conf.d/10-syslog-filter.conf
echo "     add_field => [ "received_from", "%{host}" ]" >> /etc/logstash/conf.d/10-syslog-filter.conf
echo "   }" >> /etc/logstash/conf.d/10-syslog-filter.conf
echo "   syslog_pri { }" >> /etc/logstash/conf.d/10-syslog-filter.conf
echo "    date {" >> /etc/logstash/conf.d/10-syslog-filter.conf
echo "      match => [ "syslog_timestamp", "MMM  d HH:mm:ss", "MMM dd HH:mm:ss" ]" >> /etc/logstash/conf.d/10-syslog-filter.conf
echo "    }" >> /etc/logstash/conf.d/10-syslog-filter.conf
echo "  }" >> /etc/logstash/conf.d/10-syslog-filter.conf
echo "}" >> /etc/logstash/conf.d/10-syslog-filter.conf

## output logstash
> /etc/logstash/conf.d/30-elasticsearch-output.conf

echo 'output {' >> /etc/logstash/conf.d/30-elasticsearch-output.conf
echo '  elasticsearch {' >> /etc/logstash/conf.d/30-elasticsearch-output.conf
echo '    hosts => ["localhost:9200"]' >> /etc/logstash/conf.d/30-elasticsearch-output.conf
echo '    sniffing => true' >> /etc/logstash/conf.d/30-elasticsearch-output.conf
echo '    manage_template => false' >> /etc/logstash/conf.d/30-elasticsearch-output.conf
echo '    index => "%{[@metadata][beat]}-%{+YYYY.MM.dd}"'  >> /etc/logstash/conf.d/30-elasticsearch-output.conf
echo '    document_type => "%{[@metadata][type]}"' >> /etc/logstash/conf.d/30-elasticsearch-output.conf
echo '  }' >> /etc/logstash/conf.d/30-elasticsearch-output.conf
echo '}' >> /etc/logstash/conf.d/30-elasticsearch-output.conf

## configuration testing
service logstash configtest
read -p "is configuration showing ok " test1
cd ~ && curl -L -O https://download.elastic.co/beats/dashboards/beats-dashboards-1.1.0.zip
apt-get -y install unzip && unzip beats-dashboards-*.zip
cd beats-dashboards-* && ./load.sh

##Load Filebeat Index Template in Elasticsearch
cd ~ && curl -O https://gist.githubusercontent.com/thisismitch/3429023e8438cc25b86c/raw/d8c479e2a1adcea8b1fe86570e42abab0f10f364/filebeat-index-template.json

curl -XPUT 'http://localhost:9200/_template/filebeat?pretty' -d@filebeat-index-template.json

read -p "is acknowledged true/false ? " test2

