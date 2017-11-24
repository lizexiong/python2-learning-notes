#!/usr/bin/env python
import os
import sys

if __name__ == "__main__":
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "EasyMonitor.settings")

    from django.core.management import execute_from_command_line
    if len(sys.argv)>1 and sys.argv[1] == 'graph_test':
        import django
        django.setup()
        from monitor.views import REDIS_OBJ
        from monitor import data_handler
        obj = data_handler.LatestStatisticData(1,REDIS_OBJ)
        obj.get_latest_60mins_trends()
    if len(sys.argv)>1 and sys.argv[1] == 'run_analyzer':
        import django
        django.setup()
        from monitor.views import REDIS_OBJ
        from monitor.backends import Monitor
        analyzer_obj = Monitor.Analyzer(REDIS_OBJ)
        analyzer_obj.start()
        exit()

    execute_from_command_line(sys.argv)
