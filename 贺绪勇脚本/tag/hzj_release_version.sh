#!/bin/bash

svn_ver=$1

release_ver=$2

name=$3


function usage() {
        echo "usage:hzj_release_version.sh svn_version release_version code_name"
        echo "example: hzj_release_version.sh 123 20141507 base"
}

if [ -z $svn_ver ] || [ -z $name ]; then
	usage
	exit -1;

fi

if [[ ! "$release_ver" =~ ^[0-9]{8}$ ]]; then
        usage
        exit -2;
fi


exec_cmd="svn cp http://88.88.0.80:81/svn/source/java/hzj-$name/trunk@$svn_ver http://88.88.0.80:81/svn/source/java/hzj-$name/tags/$release_ver -m 'release $name v$release_ver from trunk@$svn_ver'"

echo $exec_cmd
#$exec_cmd
