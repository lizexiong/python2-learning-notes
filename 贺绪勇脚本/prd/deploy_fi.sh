#!/bin/bash

script_dir=`dirname $0`

function usage() {
        echo "usage:release_fi.sh branch_name"
}

#if [ -z "$1" ]; then
#	usage;
#	exit -1;
#fi

#svn_url=http://svn.dev.dajiabao.com:81/svn/source/java/free-insurance/branches/$1
svn_url=http://svn.dev.dajiabao.com:81/svn/source/java/free-insurance/trunk

local_dir=/home/djb/project/free-insurance

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
cp $local_dir/target/free-insurance-1.0.0.war $release_dir/free-insurance.war
