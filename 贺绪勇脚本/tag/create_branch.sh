#!/bin/bash

svn_ver=$1

name=$2


function usage() {
        echo "usage:create_branch.sh svn_trunk_version branch_name"
        echo "example: create_branch.sh 123 crm_v1"
}

if [ -z $svn_ver ] || [ -z $name ]; then
	usage
	exit -1;

fi

exec_cmd="svn cp http://88.88.0.80:81/svn/source/java/djb-base/trunk@$svn_ver http://88.88.0.80:81/svn/source/java/djb-base/branches/$name -m 'create branch $name from trunk@$svn_ver'"

echo $exec_cmd
#$exec_cmd
