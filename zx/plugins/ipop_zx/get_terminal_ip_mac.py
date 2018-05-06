# -*- coding: utf-8 -*-


import sys
import io

sys.stdout = io.TextIOWrapper(sys.stdout.buffer,encoding='utf-8')

from scapy.all import *

