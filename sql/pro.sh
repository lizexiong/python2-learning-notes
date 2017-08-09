#!/bin/bash
BF_DIR="/home/backup/jianguandong/"
BF_TIME=`date +%Y%m%d-%H%M%S`
DB_DIR="/usr/local/tomcat/webapps/"
BF_DB="ConstructionManager"
NAME="$BF_DB$BF_TIME"
cd $DB_DIR
find $BF_DIR -mtime +1 -name "*.*" -exec rm -rf {} \;
tar zcf $BF_DIR$NAME.tar.gz $BF_DB &> /dev/null
setfacl -R -m user:back:rwx /home/backup
