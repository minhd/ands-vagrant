# Selinux
setsebool httpd_can_network_connect true

# Install repository
yum update
yum install -y epel-release
rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
yum install -y http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm

# Install dependencies
yum install -y lsof httpd java-1.7.0-openjdk-devel git vim-enhanced wget php55w php55w-common php55w-ldap php55w-mysql php55w-mbstring php55w-xml php55w-pdo Percona-Server-server-55 php55w-devel mod_ssl openssl-devel ant ant-contrib npm

# Start services
service httpd start
service mysql start

# Keep things fun
service iptables stop
sed -i 's/var\/www\/html/var\/www\/core/g' /etc/httpd/conf/httpd.conf
sed -i 's/AllowOverride\ None/AllowOverride\ All/g' /etc/httpd/conf/httpd.conf
sed -i 's/User\ apache/User\ vagrant/g' /etc/httpd/conf/httpd.conf
sed -i 's/Group\ apache/Group\ vagrant/g' /etc/httpd/conf/httpd.conf
service httpd reload

# Install composer
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

# Install SOLR
cd /opt
curl -O http://mirror.ventraip.net.au/apache/lucene/solr/5.4.0/solr-5.4.0.tgz
tar zxvf solr-5.4.0.tgz
rm -rf solr-5.4.0.tgz

# Download JTS 1.8 Library
cd /opt/solr-5.4.0/server/lib
wget http://devl.ands.org.au/lib/jts-1.13.jar

# Start SOLR and add a default collection
cd /opt/solr-5.4.0/
bin/solr start
bin/solr create -c portal

# Install ZooKeeper
cd /opt
curl -O http://apache.mirror.digitalpacific.com.au/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz
tar zxvf zookeeper-3.4.6.tar.gz
rm -rf zookeeper-3.4.6.tar.gz
cd /opt/zookeeper-3.4.6
mkdir data
cp conf/zoo_sample.cfg conf/zoo.cfg
sed -i 's/\/tmp\/zookeeper/\/opt\/zookeeper-3.4.6\/data/g' /opt/zookeeper-3.4.6/conf/zoo.cfg