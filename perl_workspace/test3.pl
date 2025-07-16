use DBI;
use DBD::mysql;

$db = "RUNOOB";
$host = "singlebasic.mysql.database.azure.com";
$port = "3306";
$user = "azureuser@singlebasic";
$pass = "SUNwenyi1234";

#$key = "client-key.pem";
#$cert = "client-cert.pem";
$ca = "C:\Users\wenyi\DigiCertGlobalRootCA.crt.pem";

#$ssl = "mysql_ssl=1;mysql_ssl_client_key=$key;mysql_ssl_client_cert=$cert;mysql_ssl_ca_file=$ca";
$ssl = "mysql_ssl=1;mysql_ssl_ca_file=$ca";

my $dsn = "dbi:mysql:database=$db;host=$host;port=$port;$ssl";
my $dbh = DBI->connect($dsn, $user, $pass, { RaiseError => 1 }) or
  die "Could not connect to MySQL: $DBI::errstr";
  
my $sth = $dbh->prepare("SELECT * FROM Websites");
$sth->execute();
 
 
while ( my @row = $sth->fetchrow_array() )
{
       print join('\t', @row)."\n";
}
 
$sth->finish();
$dbh->disconnect();