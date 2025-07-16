use strict;
use DBI;
 
my $host = "wenyimysql.mysql.database.azure.com";         # 主机地址
my $driver = "mysql";           # 接口类型 默认为 localhost
my $database = "RUNOOB";        # 数据库
# 驱动程序对象的句柄
my $dsn = "DBI:$driver:database=$database:$host;mysql_ssl=1;mysql_ssl_ca_file=DigiCertGlobalRootCA.crt.pem;mysql_ssl_verify_server_cert=1";  
my $userid = "azureuser";            # 数据库用户名
my $password = "SUNwenyi1234";        # 数据库密码
 
# 连接数据库
my $dbh = DBI->connect($dsn, $userid, $password ) or die $DBI::errstr;
my $sth = $dbh->prepare("SELECT * FROM Websites");   # 预处理 SQL  语句
$sth->execute();    # 执行 SQL 操作
 
# 注释这部分使用的是绑定值操作
# $alexa = 20;
# my $sth = $dbh->prepare("SELECT name, url
#                        FROM Websites
#                        WHERE alexa > ?");
# $sth->execute( $alexa ) or die $DBI::errstr;
 
# 循环输出所有数据
while ( my @row = $sth->fetchrow_array() )
{
       print join('\t', @row)."\n";
}
 
$sth->finish();
$dbh->disconnect();