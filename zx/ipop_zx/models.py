from django.db import models

# Create your models here.


class UsedIP(models.Model):
    name = models.CharField(max_length=32)
    ip = models.GenericIPAddressField
    mac = models.CharField(max_length=32,null=True,blank=True)
    os_type = models.CharField(max_length=32,null=True,blank=True)
    hostname = models.CharField(max_length=32,null=True,blank=True)
    #创建时间
    createtime = models.CharField(max_length=32)
    #创建时间戳
    createtime_timestamp = models.CharField(max_length=32)
    sql_createtime = models.DateField(auto_now=True)
    utime = models.DateField(auto_now_add=True)
    interface = models.CharField(max_length=16,null=True,blank=True)
    network =models.CharField(max_length=32,null=True,blank=True)
    open_port = models.CharField(max_length=256,null=True,blank=True)
    status = models.CharField(max_length=16,null=True,blank=True)
    content = models.CharField(max_length=256,null=True,blank=True)
