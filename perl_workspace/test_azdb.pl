#!/usr/bin/perl -w

use strict;
use warnings;

use DBI;

DBI->trace('1|CON');

my $db_host = "azdb-occ.mysql.database.azure.com";
my $db_name = "clubdb";
my $db_user = "ngtprog";
my $db_pass = "zxC9TkoKAGwUd7GbKkp-";
my $dsn = "DBI:mysql:host=$db_host;database=$db_name;mysql_ssl=1;mysql_ssl_ca_file=/etc/mysql/DigiCertGlobalRootCA.crt.pem;mysql_ssl_verify_server_cert=0";
#my $dsn = "DBI:mysql:host=$db_host;database=$db_name;mysql_ssl=1";


my $dbh = DBI->connect($dsn, $db_user, $db_pass, {
    PrintError => 1,
    RaiseError => 1
});

