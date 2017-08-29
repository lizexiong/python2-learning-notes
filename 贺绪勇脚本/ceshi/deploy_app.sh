#!/bin/bash

script_dir=`dirname $0`

function usage() {
        echo "usage:release_app.sh branch_name"
}

if [ -z "$1" ]; then
	usage;
	exit -1;
fi

if [ $1 == 'trunk' ]; then
svn_url=http://svn.dev.dajiabao.com/svn/source/java/djb-base/trunk
else
svn_url=http://svn.dev.dajiabao.com/svn/source/java/djb-base/branches/$1
fi

local_dir=/home/djb/project/djb-base

echo svn sw $svn_url $local_dir
svn sw $svn_url $local_dir

#mkdir release dir
release_dir=/home/djb/release/current
mkdir -p $release_dir

echo "=============== 应用打包中 =================="
echo mvn -f $local_dir/pom.xml
mvn -f $local_dir/pom.xml clean install -Dmaven.test.skip=true
echo "=============== 应用打包结束 ================"

echo "发布war包到release目录"
web_modules=(djb-web/djb-web-client djb-web/djb-web-agent djb-web/djb-web-admin djb-batch djb-web/djb-web-service djb-web/djb-wap-portal djb-web/djb-web-crm djb-web/djb-web-portal djb-web/djb-web-car djb-web/djb-web-mall djb-web/djb-web-qmyb djb-web/djb-wap-qmyb djb-web/djb-wap-jsb djb-web/djb-api-jsb)
for((i=0;i<${#web_modules[*]};i++)); do
web_module=${web_modules[$i]}
war_prefix=`basename $web_module`
cp $local_dir/djb-app/$web_module/target/$war_prefix*.war $release_dir/$war_prefix.war
done;
