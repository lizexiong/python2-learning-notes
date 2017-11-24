#--*-- coding:utf-8 --*--
import sys
reload(sys)
sys.setdefaultencoding('utf-8')
from django.shortcuts import render,HttpResponse
from django.views.decorators.csrf import  csrf_exempt

import json
from monitor.data_handler import DataProcess
from monitor.backends import redis_conn
from EasyMonitor import settings
from monitor.backends import ip_lookup
from monitor import models
from monitor import data_handler
# Create your views here.
from django.core.cache import cache
import Queue


REDIS_OBJ = redis_conn.redis_conn(settings)
GLOBAL_REALTIME_WATCHING_QUEUES = {}
IP_DB_DATA = ip_lookup.IPLookup(ip_db_filename=settings.IP_DB_FILE).ip_db_data

def data_report(request):
    # print (request.POST,request.GET)
    print ('POST',request.POST,'GET',request.GET)
    data_process_obj = DataProcess(request,REDIS_OBJ,GLOBAL_REALTIME_WATCHING_QUEUES,IP_DB_DATA)
    if data_process_obj.is_valid():
        data_process_obj.save()

    msg = 'jsonpcallback({"Email":"lizexiong@huawei.com","Remark":"from server....."})'
    return  HttpResponse(msg)

def index(request):
    return render(request,'monitor/index.html')

def real_time_contry_view(request,site_id): #返回全国视图界面
    site_obj = models.Site.objects.get(id=site_id)
    return  render(request,'monitor/real_time_contry_view.html',{'current_site':site_obj})

def real_time_analysis(request,site_id):
    site_obj = models.Site.objects.get(id=site_id)
    return  render(request,'monitor/real_time_analysis.html',{'current_site':site_obj})

def region_realtime_watching(request,site_id):
    site_obj = models.Site.objects.get(id=site_id)

    print(request.GET)
    #if request.method == "GET":
    return render(request,'monitor/region_realtime_watching.html',{'current_site':site_obj})

def get_latest_analysis_data(request): #返回最近60分钟的数据
    site_id = request.GET.get('site_id')

    obj = data_handler.LatestStatisticData(site_id,REDIS_OBJ)
    statistic_data = obj.get_latest_data()
    return HttpResponse(json.dumps(statistic_data))

def get_latest_country_map_view(request): #返回全国视图的相应数据
    site_id = request.GET.get('site_id')
    data = {'country_map':None}
    country_map_redis_key = "site__%s__latest_country_map_view" % site_id
    country_map_data = REDIS_OBJ.get(country_map_redis_key)
    if country_map_data:
        data['country_map'] = json.loads(country_map_data.decode('utf-8'))

    region_ranking_key = "site__%s__latest_region_ranking" %site_id
    region_ranking_data = REDIS_OBJ.get(region_ranking_key)
    if region_ranking_data:
        data['region_ranking_data'] = json.loads(region_ranking_data.decode('utf-8'))
    #print("country map:",type(redis_data))

    return HttpResponse(json.dumps(data))
def get_region_list(request):

    region_dic = {}
    region_objs = models.Region.objects.filter(region_type='province')
    for region in region_objs:
        region_dic[region.id] = {'id':region.id,'name':region.name,'childs':[]}
        region_dic[region.id]['childs'] = list(region.region_set.select_related().values('id','name'))
    return HttpResponse(json.dumps(region_dic))

def get_region_trends_data(request):
    #把指定region的近期指定时间 的数据提取出来返回前端
    print(request.GET)
    region_data_obj = data_handler.RegionDataHandler(request,REDIS_OBJ,IP_DB_DATA)
    if region_data_obj.validate_args():
        index_data = region_data_obj.get_data()
    return HttpResponse(json.dumps(index_data))


def get_region_realtime_output(request):
    #每来一个指定区域的请求, 就在这里返回
    site_id = request.GET.get('site_id')
    province_id = request.GET.get('province_id')
    city_id = request.GET.get('city_id')
    print (site_id,province_id,city_id)
    if site_id and province_id and city_id:
        q_key = 'queue_%s_%s_%s' %(site_id,province_id,city_id)

        if q_key not in GLOBAL_REALTIME_WATCHING_QUEUES:
            GLOBAL_REALTIME_WATCHING_QUEUES[q_key] = Queue.Queue()
        q = GLOBAL_REALTIME_WATCHING_QUEUES[q_key]
        print('wating for msg......')
        try:
            data = q.get(timeout=30)
            print ('q...',q)
            return HttpResponse(json.dumps({'data':data}))
        except Queue.Empty as e:
            print('queme timeout ....',e)

        return HttpResponse('qqqqqqqqqqqqq')
