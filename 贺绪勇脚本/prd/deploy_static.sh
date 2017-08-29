#!/bin/bash

release_ver=$1
script_dir=`dirname $0`
script_name=`basename $0`
function usage() {
	echo "usage: $script_name release_version"
	echo "example: $script_name 20140101"
}

if [[ ! "$1" =~ ^[0-9]{8}$ ]]; then
	usage
	exit -1;
fi

svn_url=http://svn.dev.dajiabao.com/svn/source/java/djb-static/tags/$release_ver
local_dir=/home/djb/project/djb-static

echo svn sw $svn_url $local_dir
svn sw $svn_url $local_dir

#mkdir release dir
release_dir=/home/djb/release/static
mkdir -p $release_dir 

echo "=============== [djb-static]静态资源打包开始 =================="
mvn -f $local_dir/pom.xml clean
mvn -f $local_dir/pom.xml assembly:single
cp $local_dir/target/djb-static.zip $release_dir/$release_ver.zip
echo "=============== [djb-static]静态资源打包结束 =================="

read -p "是否将应用同步到线上？(y/N)" sure
if [ $sure = 'y' -o $sure = 'Y' ]; then
$script_dir/sync_static_to_online.sh $release_ver 
fi
