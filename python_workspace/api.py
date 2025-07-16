import os
import requests
import time
import sys
import datetime
import logging
import json

requests.packages.urllib3.disable_warnings()
def get_token():
    url = "https://login.microsoftonline.com/72f988bf-86f1-41af-91ab-2d7cd011db47/oauth2/token"

    payload='grant_type=client_credentials&client_id=9a5a7284-c368-42d4-9f89-96bc19a29c05&client_secret=85~8Q~CirHzeOiIwQi.itHUjEKnU.BkOkhUNfcrZ&resource=https%3A%2F%2Fmanagement.azure.com%2F'
    headers = {
        'Content-Type': 'application/x-www-form-urlencoded'
    }
    response = requests.request("POST", url, headers=headers, data=payload)
    if response.status_code == 200:
        token = response.json().get('access_token')
        Bearertoken = 'Bearer ' + token
        return Bearertoken
    else:
        return False
    

"""

def get_token():
  headers2 = {'Content-Type': 'application/json', }
  data = {"grant_type": "client_credentials", "client_id": "9a5a7284-c368-42d4-9f89-96bc19a29c05", "client_secret": "85~8Q~CirHzeOiIwQi.itHUjEKnU.BkOkhUNfcrZ", "resource": "https://management.azure.com/"}
  r = requests.post('https://login.microsoftonline.com/72f988bf-86f1-41af-91ab-2d7cd011db47/oauth2/token', headers=headers2,json=json.dumps(data))
  # r = requests.post('http://localhost:3010/v1/carstatistic-3003/carInfo/countCarInfo', headers=headers2,json=data,verify=False)
  r.headers
  print(r.status_code)
  return r.text

"""

def list_slowlog():
    token = get_token()
    url = "https://management.azure.com/subscriptions/25dfc6b1-fc64-4b88-ba09-4c6864d0cadc/resourceGroups/mysql/providers/Microsoft.DBforMySQL/servers/singlebasic/logFiles?api-version=2017-12-01"
    payload={}
    headers = {
        'Authorization': token}
    response = requests.request("GET", url, headers=headers, data=payload)
    link = response.json().get('value')
    return link


def list_slowlog_flex():
    token = get_token()
    url = "https://management.azure.com/subscriptions/25dfc6b1-fc64-4b88-ba09-4c6864d0cadc/resourceGroups/logworkspace/providers/Microsoft.DBforMySQL/flexibleServers/wenyimysql8/logFiles?api-version=2021-12-01-preview"
    payload={}
    headers = {
        'Authorization': token}
    response = requests.request("GET", url, headers=headers, data=payload)
    link = response.json().get('value')
    for item in link:
        slowlog_name = item['name']
        slowlog_url = item['properties']['url']
        #print(slowlog_url)
        # 下载到当前目录的flexlogs文件夹中
        path_dir = os.path.split(os.path.realpath(sys.argv[0]))[0]
        logdir = os.path.join(path_dir,'flexlogs')
        download_slow_log(slowlog_url,logdir,slowlog_name)


    #return link


def download_slow_log(slowlog_url,rds_logdir,slowlog_name):
        try:
            get_size = requests.get(slowlog_url,stream=True,verify=False)
            total_size = int(get_size.headers['Content-Length'])
            target_name = os.path.join(rds_logdir, slowlog_name)
            if os.path.exists(target_name):
                temp_size = os.path.getsize(target_name)
            else:
                temp_size = 0
            if total_size > temp_size:
                headers = {'Range': 'bytes=%d-' %temp_size}
                req = requests.get(slowlog_url, stream=True, verify=False,headers=headers)
                with open(target_name,'ab') as f:
                    for chunk in req.iter_content(chunk_size=1024):
                        if chunk:
                            temp_size += len(chunk)
                            f.write(chunk)
                            f.flush()
                            done = int(50 * temp_size / total_size)
                            sys.stdout.write('\r[%s%s] %d%%' % (
                          '>' * done, ' ' * (50 - done), 100 * temp_size / total_size))
                            sys.stdout.flush()
                print('\n')
                return target_name
        except Exception as e:
            print('\n',slowlog_name + ':', e)
            return False


if __name__=="__main__":
    #print(get_token())
    #print(list_slowlog())
    print('====================')
    #print(list_slowlog_flex())
    
    list_slowlog_flex()

