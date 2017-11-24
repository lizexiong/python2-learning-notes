# -*- coding: utf-8 -*-


from linux import sysinfo,mac_load,cpu_mac,memory,network,host_alive

'''
    这里其实只是插件执行转换成函数执行了，真正的执行系统取数据的命令在linux和windows文件夹下
    由于可以监控的插件数量过多，这里就拿get_linux_cpu来举例

'''


def LinuxSysinfo():
    return sysinfo.collect()

def WindowsSysInfo():
    from windows import sysinfo as win_sysinfo
    return win_sysinfo.collect()

def get_linux_cpu():
    return cpu_mac.monitor()

def host_alive_check():
    return host_alive.monitor()

def GetMacCPU():
    #return cpu.monitor()
    return cpu_mac.monitor()

def GetNetworkStatus():
    return network.monitor()

def get_memory_info():
    return memory.monitor()


def get_linux_load():
    return mac_load.monitor()