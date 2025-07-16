ssh azureuser@172.173.167.95 -p 2222


ssh azureuser@172.173.238.85 -p 2222


hadoop101: 
ssh azureuser@20.119.63.200 -p 2222


hadoop102: 
ssh azureuser@20.172.145.124



==========================================================

ssh azureuser@20.127.88.149 -p 2222
ssh azureuser@20.232.102.162 -p 2222
ssh azureuser@104.211.60.38 -p 2222



wget https://repo1.maven.org/maven2/io/debezium/debezium-connector-mysql/1.7.1.Final/debezium-connector-mysql-1.7.1.Final-plugin.tar.gz


mkdir -p /opt/module/debezium/connector
tar -zxvf debezium-connector-mysql-1.7.1.Final-plugin.tar.gz -C /opt/module/debezium/connector/


vim /opt/module/kafka-2.4.1/config/connect-distributed.properties

/opt/module/kafka/bin/connect-distributed.sh -daemon /opt/module/kafka/config/connect-distributed.properties


curl -H "Accept:application/json" hadoop103:8083/
curl -H "Accept:application/json" hadoop103:8083/connectors/




{
    "name": "wenyi-mysql-connector",
    "config": {
      "connector.class": "io.debezium.connector.mysql.MySqlConnector",
      "database.hostname": "replica-testflexible.mysql.database.azure.com",
      "database.port": "3306",
      "database.user": "azureuser",
      "database.password": "SUNwenyi1234",
      "database.server.id": "184054",
      "database.server.name": "bigdata",
      "database.include.list": "school",
      "database.history.kafka.bootstrap.servers": "hadoop103:9092",
      "database.history.kafka.topic": "schema-changes.inventory"
    }
  }
  



 

curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" hadoop103:8083/connectors/ -d '{"name":"wenyi-mysql-connector","config":{"connector.class":"io.debezium.connector.mysql.MySqlConnector","database.hostname":"replica-testflexible.mysql.database.azure.com","database.port":"3306","database.user":"azureuser","database.password":"SUNwenyi1234","database.server.id":"184054","database.server.name":"bigdata","database.include.list":"school","database.history.kafka.bootstrap.servers":"hadoop103:9092","database.history.kafka.topic":"schema-changes.inventory"}}'




bin/kafka-console-consumer.sh --bootstrap-server hadoop103:9092 --topic bigdata.school.persons






insert into customers values(1005,'Jack','SSS','myname@local.com');




ssh azureuser@20.119.63.200 -p 2222


ssh azureuser@172.174.24.22 -p 2222


mysqladmin -hwenyimysql.mysql.database.azure.com -uazureuser -p'SUNwenyi1234' --ssl-mode=DISABLED extended-status --relative -c 5 --sleep=1 | grep -w Com_commit

ssh azureuser@20.51.148.239


ssh azureuser@4.246.180.105 -p 2222exi
ssh azureuser@172.173.238.85 -p 2222



wget http://mysqltuner.pl/ -O mysqltuner.pl
wget https://raw.githubusercontent.com/major/MySQLTuner-perl/master/basic_passwords.txt -O basic_passwords.txt
wget https://raw.githubusercontent.com/major/MySQLTuner-perl/master/vulnerabilities.csv -O vulnerabilities.csv


perl mysqltuner.pl --host wenyimysql.mysql.database.azure.com --user azureuser --pass SUNwenyi1234 --forcemem 100
perl mysqltuner.pl --host singlebasic.mysql.database.azure.com --user azureuser@singlebasic --pass SUNwenyi1234 --forcemem 100




pt-heartbeat -D school --update -u azureuser@wenyitestsingle -p SUNwenyi1234 -P 3306 -h wenyitestsingle.mysql.database.azure.com --create-table --daemonize

pt-heartbeat -D school --update -u azureuser@wenyitestsingle -p SUNwenyi1234 -P 3306 -h wenyitestsingle.mysql.database.azure.com

pt-heartbeat --database school -u azureuser@repliw -p SUNwenyi1234 -P 3306 -h repliw.mysql.database.azure.com --check-read-only --read-only-interval=10

pt-heartbeat --database school --monitor -h repliw.mysql.database.azure.com --check-slave-read-only -u azureuser@repliw -p SUNwenyi1234 -P 3306 

mysql -h wenyitestsingle.mysql.database.azure.com -u azureuser@wenyitestsingle -p

mysql -h repliw.mysql.database.azure.com -u azureuser@repliw -p




grep -i commit /proc/meminfo


ps aux --sort=-%mem | head -n 11


/usr/sbin/mysqld --verbose --help |grep -A 1 'Default options'

systemctl stop mysql
systemctl start mysql

vim /etc/mysql/my.cnf



ALTER USER 'root'@'localhost' IDENTIFIED BY '123456';
FLUSH PRIVILEGES;

show variables like 'innodb_buffer_pool_size';

ls /var/log/mysql
cat /var/log/mysql/error.log

cat /proc/sys/vm/overcommit_memory

cat /proc/sys/vm/swappiness


sysctl vm.overcommit_memory=2


sysctl vm.overcommit_memory=0



# // -----------

ssh azureuser@52.255.160.146 -p 2222

sudo mkdir /home/azureuser/mysqlfilebackup 
if [ ! -d "/etc/smbcredentials" ]; then 
sudo mkdir /etc/smbcredentials 
fi 
if [ ! -f "/etc/smbcredentials/autobackupsa.cred" ]; then 
sudo bash -c 'echo "username=autobackupsa" >> /etc/smbcredentials/autobackupsa.cred'     
sudo bash -c 'echo "password=e+S1cCc/EUa4Dc3JJIzzEr0rRsqoLll34eHOHdIx0P+8qchYDVSR5DrcrgPegqZ7lKNs6cW4f5z5+AStWvfZBA==" >> /etc/smbcredentials/autobackupsa.cred' 
fi 
sudo chmod 600 /etc/smbcredentials/autobackupsa.cred 
sudo bash -c 'echo "//autobackupsa.file.core.windows.net/mysqlfilebackup /home/azureuser/mysqlfilebackup cifs nofail,vers=3.0,credentials=/etc/smbcredentials/autobackupsa.cred,dir_mode=0777,file_mode=0777,serverino" >> /etc/fstab' 
sudo mount -t cifs //autobackupsa.file.core.windows.net/mysqlfilebackup /home/azureuser/mysqlfilebackup -o vers=3.0,credentials=/etc/smbcredentials/autobackupsa.cred,dir_mode=0777,file_mode=0777,serverino
#(Make sure you don’t leave the path under /mnt/ since this disk is erased everytime the vm is shutdown and since we create the directory it will no longer be available to mount it) 


nc -zvw3 autobackupsa.file.core.windows.net


curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash




#!bin/bash
cd /home/azureuser
export DBNAMES="abc school"
export MYPASSWORD="SUNwenyi1234" 
date=$(date +%s)
year=$(date +%Y)
month=$(date +%m)
day=$(date +%d)
hour=$(date +%H)
path=$year/$month/$day/$hour
echo $date
cd /home/azureuser/mysqlfilebackup/
mkdir -p $path
cd $path
mysqldump --databases $DBNAMES -h wenyimysql.mysql.database.azure.com -u azureuser -p$MYPASSWORD > back$date.bak
az vm deallocate -g vmrg -n testlinuxconnection



0 * * * * sh /home/azureuser/backup.sh >> /home/azureuser/backup.log

















































