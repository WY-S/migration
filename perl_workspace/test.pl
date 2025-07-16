#!/usr/bin/perl -w

use strict;
use warnings;

use DBI;

DBI->trace('1|CON');

my $db_host = "wenyimysql.mysql.database.azure.com";
my $db_name = "school";
my $db_user = "azureuser";
my $db_pass = "SUNwenyi1234";
my $dsn = "DBI:mysql:host=$db_host;database=$db_name;mysql_ssl=1;mysql_ssl_ca_file=C:\Users\sunwenyi\Downloads\DigiCertGlobalRootCA.crt.pem;mysql_ssl_verify_server_cert=0";
#my $dsn = "DBI:mysql:host=$db_host;database=$db_name;mysql_ssl=1";


my $dbh = DBI->connect($dsn, $userid, $password ) or die $DBI::errstr;