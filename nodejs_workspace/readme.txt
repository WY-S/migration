这里是我写的node.js相关的code。

mi.txt是我发给客户的sample

test.js是一个简单的连接pgsql的例子。没有用到SDK。需要npm安装pg。npm install pg

connect_pg_mi.js是用managed identity去登陆pgsql的例子。需要npm安装npm install --save @azure/identity，貌似也需要安装Azure CLI。
https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/how-to-connect-with-managed-identity


==================
今天用了3个小时来测试node.js，用MI来连pgsql。


发现几个问题：
1. node.js在ubuntu有些问题，同样的代码在windows是好的，在ubuntu会有报错Cannot find module 'node:os'
2. 如果用MI来登陆PGSQL，必须要在MI所在的VM登陆。比如我有一台VM:pgsql-primary，它的identity client id是77701479-142b-4fea-848d-d951659e134d。如果我用相同的账号密码在我自己电脑登陆会有报错：FATAL:  Service Principals cannot generate AAD_AUTH_TOKENTYPE_APP_USER tokens for role[pgsql-primary]。在这台VM上就可以成功登陆。
3. select * from pgaadauth_create_principal()命令之内是aad admin来跑。











az ad sp list --display-name pgsql-primary --query [*].appId
[
  "77701479-142b-4fea-848d-d951659e134d"
]

az ad sp list --display-name testvmclient --query [*].appId
[
  "d85c44ab-ee82-4451-b922-bae1b7a9afaf"
]

psql -h testpgsql2.postgres.database.azure.com --user pgsql-primary postgres

psql "host=testpgsql2.postgres.database.azure.com port=5432 dbname=postgres user=sunwenyi@microsoft.com sslmode=require"

select * from pgaadauth_create_principal('testvmclient', false, false);

export PGPASSWORD=`curl -s 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fossrdbms-aad.database.windows.net&client_id=77701479-142b-4fea-848d-d951659e134d' -H Metadata:true | jq -r .access_token`

psql "host=testpgsql2.postgres.database.azure.com port=5432 dbname=postgres user=pgsql-primary sslmode=require"


export PGPASSWORD=`curl -s 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fossrdbms-aad.database.windows.net&client_id=d85c44ab-ee82-4451-b922-bae1b7a9afaf' -H Metadata:true | jq -r .access_token`














