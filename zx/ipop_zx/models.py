from django.db import models

# Create your models here.


class UsedIP(models.Model):
    name = models.CharField(max_length=32)
    username = models.CharField(max_length=16,null=True,blank=True,default='None')
    password = models.CharField(max_length=32,null=True,blank=True,default='None')
    mysql_username = models.CharField(max_length=16,null=True,blank=True,default='None')
    mysql_password = models.CharField(max_length=16,null=True,blank=True,default='None')
    mongo_username =  models.CharField(max_length=16,null=True,blank=True,default='None')
    mongo_password =  models.CharField(max_length=16,null=True,blank=True,default='None',)
    other_username =  models.CharField(max_length=16,null=True,blank=True,default='None')
    other_password =  models.CharField(max_length=16,null=True,blank=True,default='None')
    group = models.CharField(max_length=32,)
    ip = models.GenericIPAddressField()
    mask = models.CharField(max_length=32,default="255.255.255.0")
    mac = models.CharField(max_length=32,null=True,blank=True)
    os_type = models.CharField(max_length=32,null=True,blank=True)
    hostname = models.CharField(max_length=32,null=True,blank=True)
    #创建时间
    createtime = models.CharField(max_length=32)
    #创建时间戳
    createtime_timestamp = models.CharField(max_length=32)
    '''
    auto_now更新时间仅在admin中操作才会有效,所以这里不使用models的时间更新
    以下是官方说明
    官方文档说调用Model.save()时，字段会自动更新。 当以其他方式更新字段如QuerySet.update()时，该字段不会更新.
    解决方法其实很简单，使用Model.save()来更新；或者使用QuerySet.update(),更新内容里获取当前时间作为该字段的值。
    所以后台在执行时调用save的方式可以更新
    # sql_createtime = models.DateTimeField(auto_now_add=True)
    # utime = models.DateTimeField(auto_now=True)
    '''
    sql_createtime = models.DateTimeField(auto_now_add=True)
    utime = models.DateTimeField(auto_now=True)
    import datetime
    # sql_createtime = models.DateTimeField(default=datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
    # utime = models.DateTimeField(default=datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
    interface = models.CharField(max_length=16,null=True,blank=True)
    network =models.CharField(max_length=16,null=True,blank=True)
    open_port = models.CharField(max_length=256,null=True,blank=True)
    url = models.CharField(max_length=64,null=True,blank=True)
    url2 = models.CharField(max_length=64,null=True,blank=True)
    url3 = models.CharField(max_length=64,null=True,blank=True)
    url4 = models.CharField(max_length=64,null=True,blank=True)
    url5 = models.CharField(max_length=64,null=True,blank=True)
    status = models.CharField(max_length=16,null=True,blank=True,default='使用中')
    content = models.CharField(max_length=256,null=True,blank=True)
    #主键联合唯一
    class Meta:
        unique_together = ('ip','mac')
    def __str__(self):
        return "<name:%s,ip:%s>" %(self.name,self.ip)

class HistoryIP(models.Model):
    name = models.CharField(max_length=32)
    username = models.CharField(max_length=16,null=True,blank=True,default='None')
    password = models.CharField(max_length=32,null=True,blank=True,default='None')
    mysql_username = models.CharField(max_length=16,null=True,blank=True,default='None')
    mysql_password = models.CharField(max_length=16,null=True,blank=True,default='None')
    mongo_username =  models.CharField(max_length=16,null=True,blank=True,default='None')
    mongo_password =  models.CharField(max_length=16,null=True,blank=True,default='None',)
    other_username =  models.CharField(max_length=16,null=True,blank=True,default='None')
    other_password =  models.CharField(max_length=16,null=True,blank=True,default='None')
    group = models.CharField(max_length=32,)
    ip = models.GenericIPAddressField()
    mask = models.CharField(max_length=32,default="255.255.255.0")
    mac = models.CharField(max_length=32,null=True,blank=True)
    os_type = models.CharField(max_length=32,null=True,blank=True)
    hostname = models.CharField(max_length=32,null=True,blank=True)
    #创建时间
    createtime = models.DateTimeField(auto_now_add=True)
    interface = models.CharField(max_length=16,null=True,blank=True)
    network =models.CharField(max_length=16,null=True,blank=True)
    open_port = models.CharField(max_length=256,null=True,blank=True)
    url = models.CharField(max_length=64,null=True,blank=True)
    url2 = models.CharField(max_length=64,null=True,blank=True)
    url3 = models.CharField(max_length=64,null=True,blank=True)
    url4 = models.CharField(max_length=64,null=True,blank=True)
    url5 = models.CharField(max_length=64,null=True,blank=True)
    status = models.CharField(max_length=16,null=True,blank=True,default='已删除')
    content = models.CharField(max_length=256,null=True,blank=True)

    def __str__(self):
        return "<name:%s,ip:%s>" %(self.name,self.ip)