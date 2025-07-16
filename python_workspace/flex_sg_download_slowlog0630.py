# -*- coding:utf-8 -*-
import os
import requests
import time
import sys
import datetime
import logging
import json

requests.packages.urllib3.disable_warnings()
class GetRdsSlowLog:
    # 删除2天前文件，如果要保留更久，就把2改大
    delete_day = 7
    subscriptionId = '25dfc6b1-fc64-4b88-ba09-4c6864d0cadc'

    def __init__(self,):
        pass

    @staticmethod
    def get_aztoken():
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

    @staticmethod
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

    @staticmethod
    def break_point_continuation(slowlog_filename,rds_logdir,slowlogs_info):
        for i in reversed(range(len(slowlogs_info))):
            if slowlogs_info[i]['name'] == slowlog_filename:
                source_slowlog_url = slowlogs_info[i]['properties']['url']
                GetRdsSlowLog.download_slow_log(source_slowlog_url,rds_logdir,slowlog_filename)
                break

    @staticmethod
    def get_rds_info():
        Bearertoken = GetRdsSlowLog.get_aztoken()
        azurerdsurl = f"""https://management.azure.com/subscriptions/{GetRdsSlowLog.subscriptionId}/providers/Microsoft.DBforMySQL/flexibleServers?api-version=2021-05-01"""
        rds_info = requests.get(azurerdsurl, headers={'Authorization': Bearertoken})
        if rds_info.status_code == 200:
            value = rds_info.json().get('value')
            return value
        else:
            return False

    @staticmethod
    def delete_slowlog_files(rds_logdir,delete_day):
        today = datetime.datetime.now()
        offset = datetime.timedelta(days=-delete_day)
        re_date = (today + offset)
        re_date_unix = time.mktime(re_date.timetuple())
        file_name_list = os.listdir(rds_logdir)
        if file_name_list:
            for item in file_name_list:
                slowlog_file = os.path.join(rds_logdir,item)
                slowlog_file_updated_time = os.path.getmtime(slowlog_file)

                if slowlog_file_updated_time <= re_date_unix:
                    os.remove(slowlog_file)

    @staticmethod
    def get_rds_today_slowlogs_info(slowlogs_info):
        slowlog_info = []
        timestamp = time.time()
        localtime = time.localtime(timestamp)
        today = time.strftime('%Y-%m-%d', localtime)
        yesterday = "2023-07-02"
        for item in slowlogs_info:
            last_modified_time = item['properties']['lastModifiedTime'].split('T')[0]
            if last_modified_time == yesterday:
                slowlog_info.append(item)
        return slowlog_info

    @staticmethod
    def get_rds_slowlog(slowlogs_info,rds_logdir):
        if slowlogs_info:
            slowlog_info = GetRdsSlowLog.get_rds_today_slowlogs_info(slowlogs_info)
            if slowlog_info:
                for item in slowlog_info:
                    slowlog_name = item['properties']['name']
                    slowlog_url = item['properties']['url']
                    print("#############################")
                    print(slowlog_url)
                    print("#############################")
                    slowlog_file = os.path.join(rds_logdir, slowlog_name)
                    if not os.path.exists(slowlog_file):
                        GetRdsSlowLog.download_slow_log(slowlog_url, rds_logdir, slowlog_name)

        file_name_list = os.listdir(rds_logdir)
        if file_name_list:
            for file_name in file_name_list:
                GetRdsSlowLog.break_point_continuation(file_name, rds_logdir, slowlogs_info)

    @staticmethod
    def download_rds_slowlog(resourcegroupname,servername,logdir,Bearertoken):
        azurerdsurl = f"""https://management.azure.com/subscriptions/{GetRdsSlowLog.subscriptionId}/resourceGroups/{resourcegroupname}/providers/Microsoft.DBforMySQL/flexibleServers/{servername}/logFiles?api-version=2021-12-01-preview"""
        rds_logdir = os.path.join(logdir, servername)
        if not os.path.exists(rds_logdir):
            os.makedirs(rds_logdir)

        GetRdsSlowLog.delete_slowlog_files(rds_logdir, GetRdsSlowLog.delete_day)
        slowlog_response = requests.get(azurerdsurl, headers={'Authorization': Bearertoken})
        print(slowlog_response.status_code)
        if slowlog_response.status_code == 200:
            value = slowlog_response.json().get('value')
            GetRdsSlowLog.get_rds_slowlog(value, rds_logdir)
        else:
            Bearertoken = GetRdsSlowLog.get_aztoken()
            slowlog_response = requests.get(azurerdsurl, headers={'Authorization': Bearertoken})
            value = slowlog_response.json().get('value')
            GetRdsSlowLog.get_rds_slowlog(value, rds_logdir)

    @staticmethod
    def get_slow_log(server_name=None,resource_groupname=None):
        path_dir = os.path.split(os.path.realpath(sys.argv[0]))[0]
        logdir = os.path.join(path_dir,'flexlogs')
        Bearertoken = GetRdsSlowLog.get_aztoken()
        azurerdslist = GetRdsSlowLog.get_rds_info()
        
        if not os.path.exists(logdir):
            os.makedirs(logdir)

        if not server_name:
            if azurerdslist:
                for i in range(len(azurerdslist)):
                    resource_groupname = azurerdslist[i]['id'].split('/')[4]
                    servername = azurerdslist[i]['name']
                    if servername.startswith('sg-'):
                       GetRdsSlowLog.download_rds_slowlog(resource_groupname, servername, logdir, Bearertoken)
        else:
            resourceroupname = resource_groupname
            servername = server_name
            GetRdsSlowLog.download_rds_slowlog(resourceroupname,servername,logdir,Bearertoken)

if __name__ == '__main__':
    """
    server_name和resource_roupname若为空，则下载当天的慢日志，并更新本地已存在的所有不完整的慢日志
    server_name和resource_roupname填写为对应RDS资源，则只下载对应rds资源当天的慢日志，并更新本地已存在的所有不完整的慢日志
    """
    #GetRdsSlowLog.get_slow_log()
    GetRdsSlowLog.get_slow_log("wenyimysql8", "logworkspace")
