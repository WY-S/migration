import psycopg2 ##导入

## 通过connect方法，创建连接对象 conn
## 这里连接的是本地的数据库
conn = psycopg2.connect(database="postgres", user="azureuser", password="SUNwenyi1234", host="testpgsql2.postgres.database.azure.com", port="5432")

## 执行之后不报错，就表示连接成功了！
print('postgreSQL数据库“db_test”连接成功!')

cur=conn.cursor()

cur.execute('select * from company')
rows = cur.fetchall()
for row in rows:
  print("ID = ", row[0])
  print("NAME = ", row[1])
  print("AGE = ", row[2])
  print("ADDRESS = ", row[3])
  print("SALARY = ", row[4])
  print("JOIN_DATE = ", row[5], "\n")

conn.commit()
conn.close()
