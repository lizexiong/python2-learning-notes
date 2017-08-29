#!/bin/bash

branch_name=$1
script_dir=`dirname $0`
script_name=`basename $0`
function usage() {
        echo "usage: $script_name [branch_name]"
        echo "example: $script_name trunk"
}

svn_url=http://svn.dev.dajiabao.com/svn/source/java/djb-static/branches/$branch_name
if [ -z $branch_name ]; then
branch_name=trunk
svn_url=http://svn.dev.dajiabao.com/svn/source/java/djb-static/trunk
fi

local_dir=/home/djb/project/djb-static

echo svn sw $svn_url $local_dir
svn sw $svn_url $local_dir

#mkdir release dir
release_dir=/home/djb/release/current
mkdir -p $release_dir

echo "=============== [djb-static]静态资源打包开始 =================="
mvn -f $local_dir/pom.xml clean
mvn -f $local_dir/pom.xml assembly:single
cp $local_dir/target/djb-static.zip $release_dir
echo "=============== [djb-static]静态资源打包结束 =================="

cd /data/djb

rm -rf static/djb-web static/djb-common
/usr/bin/unzip /home/djb/release/current/djb-static.zip

