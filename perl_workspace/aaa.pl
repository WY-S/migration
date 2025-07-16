use strict;
use DBI;
my $host = "wenyimysql8.mysql.database.azure.com";       
my $driver = "mysql";          
my $database = "school";       
my $dsn = "DBI:$driver:database=$database:$host";  
my $userid = 'azureuser';           
my $password = 'SUNwenyi1234';      
my $dbh = DBI->connect(
       $dsn, $userid, $password ,
       {
              mysql_ssl => 1,
              mysql_ssl_ca_file => 'BaltimoreCyberTrustRoot.crt.pem'       }
       ) 
       or die $DBI::errstr;
my $sth = $dbh->prepare("SELECT * FROM school");   
$sth->execute();    
while ( my @row = $sth->fetchrow_array() )
{
       print join('\t', @row)."\n";
}
$sth->finish();
$dbh->disconnect();