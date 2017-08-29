#!/bin/bash
files=/home/lilin/work/source/djb-base/djb-app/djb-dao/src/main/resources/mappers/mysql
#sed -i "s/newid()/rand()/Ig" $files/*.xml
#sed -i "s/newid()/rand()/Ig" $files/*/*.xml
#while read line; do 
#echo sed -i "s/$line/$line/Ig" $files/*/*.xml
#sed -i "s/$line/$line/Ig" $files/*.xml
#done < `dirname $0`/table.txt;
#sed -i "s/\t/ /Ig" $files/*.xml
#sed -i "s/\t/ /Ig" $files/*/*.xml

while read line; do 
sed -i "s/\([^<a-z_]\)$line /\1$line /Ig" $files/*.xml
sed -i "s/\([^<a-z_]\)$line /\1$line /Ig" $files/*/*.xml
sed -i "s/\([^<a-z_]\)$line$/\1$line/Ig" $files/*.xml
sed -i "s/\([^<a-z_]\)$line$/\1$line/Ig" $files/*/*.xml
done < `dirname $0`/sqlkey.txt;

#sed -i "s/\(test=\".*\)AND\(.*\"\)/\1and\2/gI" $files/*.xml
#sed -i "s/\(test=\".*\)AND\(.*\"\)/\1and\2/gI" $files/*/*.xml
#sed -i "s/\(test=\".*\)OR\(.*\"\)/\1or\2/gI" $files/*.xml
#sed -i "s/\(test=\".*\)OR\(.*\"\)/\1or\2/gI" $files/*/*.xml
