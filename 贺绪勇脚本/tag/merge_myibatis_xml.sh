#!/bin/sh

#xml_path=/home/lilin/work/source/djb-base/djb-app/djb-dao/src/main/resources/com/djb/dao/ibatis/maps/
xml_path=/home/lilin/work/source/djb-base/djb-app/djb-dao/src/main/resources/mappers/mysql/

for f in `find $xml_path -name '*.xml'`
do
echo "\n==================================== BEGIN ${f#*$xml_path} ========================="
cat $f
echo "\n==================================== END ${f#*$xml_path} =========================\n"
done;
