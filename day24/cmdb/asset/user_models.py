# -*- coding: utf-8 -*-
from django.db import models
from django.contrib.auth.models import (
    BaseUserManager, AbstractBaseUser
)

#这里是第二个类，主要创建用户字段和设置密码都在这里
class UserProfileManage(BaseUserManager):
    #创建用户的时候直接把这些字段传入进来，这就是我们在UserProfile里面定义的字段
    def create_user(self, email, name, password=None):
        """
        Creates and saves a User with the given email, date of
        birth and password.
        """
        if not email:
            raise ValueError('Users must have an email address')

        #这里就开始创建了
        user = self.model(
            email=self.normalize_email(email),
            name=name,
        )

        #然后在set_password里面设置密码以及一些校验
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, name, password):
        """
        Creates and saves a superuser with the given email, date of
        birth and password.
        """
        user = self.create_user(
            email,
            password=password,
            name=name,
        )
        user.is_admin = True
        user.save(using=self._db)
        return user


class UserProfile(AbstractBaseUser):
    #这里是一些表定义的字段，比如创建的时候我有 email,那么字段，当然可以自己加
    email = models.EmailField(
        verbose_name='email address',
        max_length=255,
        unique=True,
    )
    name = models.CharField(max_length=32)
    is_active = models.BooleanField(default=True)
    is_admin = models.BooleanField(default=False)

    """
    这个类里面只有email和name的字段，但是输入密码，确认密码全部在下面这个类里面。
    因为我们emmail字段和name字段使我们自已定义，所以在创建的时候的更改全部在下面这个类
    里面，而且这个类的方式objects是固定写死的，django会自动去找这个objects，那么这两个
    类就关联了，
    然后在创建用户的时候调用UserProfile ，那么就是可以调用UserProfile.obejcts了
    """
    objects = UserProfileManage()

    #告诉djanog，email是用户名的那种字段
    USERNAME_FIELD = 'email'
    #这个是必须的字段
    REQUIRED_FIELDS = ['name']

    def get_full_name(self):
        # The user is identified by their email address
        return self.email

    def get_short_name(self):
        # The user is identified by their email address
        return self.email

    def __str__(self):              # __unicode__ on Python 2
        return self.email

    def has_perm(self, perm, obj=None):
        "Does the user have a specific permission?"
        # Simplest possible answer: Yes, always
        return True

    def has_module_perms(self, app_label):
        "Does the user have permissions to view the app `app_label`?"
        # Simplest possible answer: Yes, always
        return True

    #把这个函数变成一个静态属性
    @property
    def is_staff(self):
        "Is the user a member of staff?"
        # Simplest possible answer: All admins are staff
        return self.is_admin