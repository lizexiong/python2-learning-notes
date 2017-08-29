#!/bin/bash

release_ver=$1

script_dir=`dirname $0`

function usage() {
	echo "usage:release_module.sh release_version"
	echo "example: release_app.sh 20140101"
}

if [[ ! "$1" =~ ^[0-9]{8}$ ]]; then
	usage
	exit -1;
fi

svn_url=http://svn.dev.dajiabao.com/svn/source/java/djb-module/tags/$release_ver

local_dir=/home/djb/project/djb-module

echo svn sw $svn_url $local_dir
svn sw $svn_url $local_dir

#mkdir release dir
release_dir=/home/djb/release/module/$release_ver
mkdir -p $release_dir

echo "=============== 应用打包中 =================="
echo mvn -f $local_dir/pom.xml
mvn -f $local_dir/pom.xml clean install -Dmaven.test.skip=true
echo "=============== 应用打包结束 ================"

echo "发布war包到release目录"
cp $local_dir/web-app/target/djb-module-web-app-*.war $release_dir/djb-module-web-app.war
cp $local_dir/web-api/target/djb-module-web-api-*.war $release_dir/djb-module-web-api.war

read -p "是否将应用同步到线上？(y/N)" sure
if [ $sure = 'y' -o $sure = 'Y' ]; then
$script_dir/sync_module_to_online.sh $release_ver 
fi
