from django.shortcuts import render,HttpResponse,redirect
from django.forms.models import model_to_dict

from ipop_zx import models
# Create your views here.
import json,os

def index(request):
    data = {'headline':"IPOP"}
    return render(request, 'ipop_zx/ipop.html',data)

def welcome(request):
    host_list = models.UsedIP.objects.all()
    host_count = models.UsedIP.objects.values('id').count()
    return render(request, 'ipop_zx/host_list.html',{'host_list':host_list,'host_count':host_count})

def host_list(request):
    host_list = models.UsedIP.objects.all()
    host_count = models.UsedIP.objects.values('id').count()
    return render(request, 'ipop_zx/host_list.html',{'host_list':host_list,'host_count':host_count})

from ipop_zx.host_add_form import HostInfo
from django import forms
from plugins.ipop_zx.ip_calculate import subnet_calculate,all_ip
def host_add(request):
    if request.method == 'POST':
        new_host_info = HostInfo(request.POST)
        if new_host_info.is_valid():
            data = new_host_info.clean()

            #存储各种时间格式
            createtime = normal_time()
            createtime_timestamp = time_stamp()
            data.update(createtime)
            data.update(createtime_timestamp)

            #网段计算
            ip = request.POST.get('ip')
            mask = request.POST.get('mask')
            network = subnet_calculate(ip,mask)
            data.update(network)

            try:
                models.UsedIP.objects.create(**data)
            except Exception as e:
                status_info = {"status":"sql_error"}
                return HttpResponse(json.dumps(status_info))
            status_info = {'status':'ok','host_ip':data['ip']}
            return HttpResponse(json.dumps(status_info))
        else:
            error_msg = new_host_info.errors
            return HttpResponse(json.dumps(error_msg))
    elif request.method == 'GET':
        '''
        https://docs.djangoproject.com/en/2.0/ref/forms/fields/
        以上文档讲述了怎么通过get给字段赋值,以上是官方文档,
        可以在以上官方文档查询到
        '''
        host_ip = request.GET.get('ip',None)
        print ('host_ip',host_ip)
        ip= {'ip':host_ip}
        host_form_obj = HostInfo(initial=ip)
        return render(request,'ipop_zx/host_add.html',{'host_form_obj':host_form_obj})

from ipop_zx.host_update_ModelForm import HostUpdateModelForm
def host_update(request):
    host_id = request.GET.get('host_id',None)
    if request.method == 'POST':
        #这里的id是get网页的时候埋的
        host_id = request.POST.get('host_id',None)
        #如果是更新信息,一定要用一个实例来对比
        host_obj = models.UsedIP.objects.get(id=host_id)
        #拿到上述的对象对比,如果没有上述对象,那么is_valid验证都无法通过,因为程序就认为你在新增
        update_host_info = HostUpdateModelForm(request.POST,instance=host_obj)
        #这里因为使用的是ModelForm,这里验证的时候顺便会去验证数据库的操作,比如数据有效性,是否冲突,所以
        # 这里和增加主机不同,没到数据库操作就可以知道具体的报错信息了
        if update_host_info.is_valid():
            #如果前端页面的值没有新增的字段,可以直接使用save()来保存
            # update_host_info.save()

            ip = request.POST.get('ip')
            mask = request.POST.get('mask')
            network = subnet_calculate(ip,mask)
            host_info = update_host_info.cleaned_data
            host_info['network'] = network['network']

            #获取最新时间,自定义更新时间
            current_time = normal_time()
            host_info['utime'] = current_time['createtime']

            models.UsedIP.objects.filter(id=host_id).update(**host_info)

            status_info = {'status':'ok',}
            return HttpResponse(json.dumps(status_info))
        else:
            error_msg = update_host_info.errors
            return HttpResponse(json.dumps(error_msg))
    host_obj = models.UsedIP.objects.get(id=host_id)
    host_info = HostUpdateModelForm(instance=host_obj)
    return render(request,'ipop_zx/host_update.html',{'host_info':host_info,'host_id':host_id})

def host_del(request):
    if request.method == "POST":
        host_id = request.POST.get('host_id',None)
        host_id = json.loads(host_id)
        if isinstance(host_id,list):
            for id in host_id:
                update_to_del(id)
                # models.UsedIP.objects.filter(id=id).delete()
        else:
            update_to_del(host_id)
            # models.UsedIP.objects.filter(id=host_id).delete()
        return HttpResponse(json.dumps('ok'))

def host_details(request):
    if request.method == 'GET':
        host_id = request.GET.get('host_id',None)
        host = models.UsedIP.objects.get(id=host_id)
        return render(request, 'ipop_zx/host_details.html',{'host':host})

def hosthistory_details(request):
    if request.method == 'GET':
        host_id = request.GET.get('host_id',None)
        host = models.HistoryIP.objects.get(id=host_id)
        print (host)
        return render(request, 'ipop_zx/hosthistory_details.html',{'host':host})

def host_history(request):
    if request.method == "GET":
        host_list = models.HistoryIP.objects.all()
        host_count = models.HistoryIP.objects.values('id').count()
        return render(request, 'ipop_zx/host_history.html',{'host_list':host_list,'host_count':host_count})

def hosthistory_del(request):
    if request.method == "POST":
        host_id = request.POST.get('host_id',None)
        host_id = json.loads(host_id)
        if isinstance(host_id,list):
            for id in host_id:
                models.HistoryIP.objects.filter(id=id).delete()
        else:
            models.HistoryIP.objects.filter(id=host_id).delete()
        return HttpResponse(json.dumps('ok'))


def group_list(request):
    if request.method == 'POST':
        id = request.POST.get('id')
        name = request.POST.get('n')
        lv = request.POST.get('lv')
        print ('id',id,'name',name,'lv',lv)
        if id == None and name == None and lv == None:
            handle_data = _getgroup()
        elif id != '' and lv == "0":
            handle_data = _getnetwork(id,name)
        # group_data = {'id':'idc','name':'idc','isParent':'true','target':'RightFrame','url':'http://www.baidu.com'}
        # print ('group_data',group_data)
        else:
            handle_data={'None':'zexiong'}
        import json
        return HttpResponse(json.dumps(handle_data))

def group(request):
    if request.method == 'GET':
        group = request.GET.get('group',None)
        group_info = models.UsedIP.objects.filter(group=group)
        return render(request,'ipop_zx/host_list.html',{'host_list':group_info})

def network(request):
    if request.method == 'GET':
        group = request.GET.get('group')
        network = request.GET.get('network')
        network_info = models.UsedIP.objects.filter(group=group,network=network)
        return render(request,'ipop_zx/host_list.html',{'host_list':network_info})


from ipop_zx.ztree_handle import group_handle,network_handle
def _getgroup():
    group_data = []
    group_set = list(models.UsedIP.objects.values('group'))
    print (group_set)
    for i in  group_handle(group_set):
        group_data.append(i)
    return group_data

def _getnetwork(id,group):
    network_data = []
    network_set = list(models.UsedIP.objects.filter(group=group).values('network'))
    print (network_set,group)
    for i in network_handle(network_set,group):
        network_data.append(i)
    return network_data

def update_to_del(id):
    host_info = list(models.UsedIP.objects.filter(id=id).values('ip','name','mac','os_type','hostname',
                                      'interface','network','open_port','url','content',
                                      'group','mask','password','username','mongo_password','mongo_username',
                                      'mysql_password','mysql_username','other_username','other_password','url2',
                                      'url3','url4','url5'))
    host_info[0]['status'] = u"have deleted"
    models.HistoryIP.objects.create(**host_info[0])
    models.UsedIP.objects.filter(id=id).delete()

from ipop_zx.ip_calculate_form import IPCalculate
def ip_calculate(request):
    if  request.method == "GET":
        return render(request,'ipop_zx/ip_calculate.html',)
    elif request.method == "POST":
        group_name = request.POST.get('group',None)
        network_name = request.POST.get('network',None)
        used_ip_list = []       #存储数据库里面已经使用的ip
        all_ip_dict = {}         #存储分类好的ip字典
        total_ip_list = []         #存储分类好的所有ip字典返回给前端
        if group_name is not None and network_name is not None:
            ip_list = list(models.UsedIP.objects.filter(group=group_name,network=network_name).values('ip'))
            for used_ip in ip_list:
                used_ip_list.append(used_ip['ip'])
            all_ip_list = all_ip(network_name)

            ip_num = 1
            for ip in all_ip_list:
                if ip_num < 1000:
                    #strCompressed将IPy的类型转为字符串
                    if ip.strCompressed() in used_ip_list:
                        all_ip_dict = {'id':ip_num,'ip': ip.strCompressed(),'status' :list(models.UsedIP.objects.filter(ip=ip.strCompressed()).values('name'))[0]['name']}
                    else:
                        all_ip_dict = {'id':ip_num,'ip': ip.strCompressed(),'status' :'未使用'}
                    total_ip_list.append(all_ip_dict)
                    ip_num +=1
                else:
                    break;
            return render(request,'ipop_zx/ip_calculate.html',{'total_ip_list':total_ip_list})

        else:
            error_msg = {"error":'Please select group and network segments correctly.'}
            return render(request,'ipop_zx/ip_calculate.html',{'error':error_msg})


def group_network_list(request):
    if request.method == "POST":
        group_list = ['请选择']
        network_list = []
        group = request.POST.get('data',None)

        if group == None:
            for group_name in  list(models.UsedIP.objects.values('group')):
                if group_name['group'] not in group_list:    #这里没用set是因为set后列表的顺序会乱
                    group_list.append(group_name['group'])
            return HttpResponse(json.dumps(group_list))
        else:
            for network in list(models.UsedIP.objects.filter(group=group).values('network')):
                network_list.append(network['network'])
            return HttpResponse(json.dumps(list(set(network_list))))


def excel_to_lead(request):
    if request.method == "GET":
        template = os.getcwd() + "/" + "ipop_zx/uploads/模版.xlsx"
        return render(request,'ipop_zx/excel_to_lead.html',{"template":template})
    elif request.method == "POST":
        filename = str(request.FILES['file']).split('.')[0] + '_' + normal_time()['createtime'][:10] + '.' + str(request.FILES['file']).split('.')[1]
        file_save = handle_upload_file(request.FILES['file'],str(filename))
        result = excel_to_sql(file_save)
        return HttpResponse(json.dumps(result))

def handle_upload_file(file,filename):
    path='ipop_zx\\uploads\\'     #上传文件的保存路径，可以自己指定任意的路径
    if not os.path.exists(path):
        os.makedirs(path)
    with open(path+filename,'wb+')as destination:
        for chunk in file.chunks():
            destination.write(chunk)
    file_absolute_path = os.getcwd() + '\\' +path + filename
    return file_absolute_path

def excel_to_sql(filename):
    import xlrd
    excelfile = filename
    error_num = []
    count = 0
    try:
        data = xlrd.open_workbook(excelfile)		# 打开xls文件
    except Exception:
        return 'file type error'

    try:
        table = data.sheets()[0]	# 打开第一张表
        nrows = table.nrows			# 获取表的行数
        for i in range(nrows):		# 循环逐行打印
            if i == 0:
                continue
            host_info =  {}
            host_info['name'] = table.row_values(i)[0]
            host_info['ip'] = table.row_values(i)[1]
            host_info['mask'] = table.row_values(i)[2]
            host_info['mac'] = table.row_values(i)[3]
            host_info['os_type'] = table.row_values(i)[4]
            host_info['hostname'] = table.row_values(i)[5]
            host_info['interface'] = table.row_values(i)[6]
            host_info['open_port'] = table.row_values(i)[7]
            host_info['status'] = table.row_values(i)[8]
            host_info['content'] = table.row_values(i)[9]
            host_info['group'] = table.row_values(i)[10]
            host_info['username'] = table.row_values(i)[11]
            host_info['password'] = table.row_values(i)[12]
            host_info['mysql_username'] = table.row_values(i)[13]
            host_info['mysql_password'] = table.row_values(i)[14]
            host_info['mongo_username'] = table.row_values(i)[15]
            host_info['mongo_password'] = table.row_values(i)[16]
            host_info['other_username'] = table.row_values(i)[17]
            host_info['other_password'] = table.row_values(i)[18]
            host_info['url'] = table.row_values(i)[19]
            host_info['url2'] = table.row_values(i)[20]
            host_info['url3'] = table.row_values(i)[21]
            createtime = normal_time()
            createtime_timestamp = time_stamp()
            host_info['createtime'] = createtime['createtime']
            host_info['createtime_timestamp'] = createtime_timestamp['createtime_timestamp']
            host_info['network'] = subnet_calculate(table.row_values(i)[1],table.row_values(i)[2])['network']

            try:
                models.UsedIP.objects.create(**host_info)
                count += 1
            except Exception:
                error_num.append(i)
        return (error_num,count)
    except Exception:
        return "file format error"



def normal_time():
    import datetime
    # createtime = datetime.datetime.now()
    createtime = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    result = {'createtime':createtime}
    return result

def time_stamp():
    import time
    createtime_timestamp = time.time()
    result = {'createtime_timestamp':createtime_timestamp}
    return result

