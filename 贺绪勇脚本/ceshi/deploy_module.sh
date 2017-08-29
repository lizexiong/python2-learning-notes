#!/bin/bash

script_dir=`dirname $0`

function usage() {
        echo "usage:deploy_module.sh branch_name"
}

if [ -z "$1" ]; then
svn_url=http://svn.dev.dajiabao.com/svn/source/java/djb-module/trunk
else
svn_url=http://svn.dev.dajiabao.com/svn/source/java/djb-module/branches/$1
fi

local_dir=/home/djb/project/djb-module

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
cp $local_dir/web-app/target/djb-module-web-app-*.war $release_dir/djb-module-web-app.war
cp $local_dir/web-api/target/djb-module-web-api-*.war $release_dir/djb-module-web-api.war
