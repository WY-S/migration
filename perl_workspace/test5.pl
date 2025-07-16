use strict;
use DBI;
use DBD::mysql;

my $host = "wenyimysql.mysql.database.azure.com";       
my $driver = "mysql";          
my $database = "runoob";

my $dsn = "DBI:$driver:database=$database:$host";  
my $userid = 'azureuser';           
my $password = 'SUNwenyi1234';      

my $dbh = DBI->connect(
    $dsn, $userid, $password ,
    {
        mysql_ssl => 1,
        mysql_ssl_ca_file => './DigiCertGlobalRootCA.crt.pem',
		mysql_ssl_optional => 1
	}
    ) 
    or die $DBI::errstr;

my $sth = $dbh->prepare("SELECT * FROM Websites");   
$sth->execute();    

while ( my @row = $sth->fetchrow_array() )
{
       print join('\t', @row)."\n";
}

$sth->finish();
$dbh->disconnect();