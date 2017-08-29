#!/bin/bash

release_ver=$1

prd_server=222.73.136.130

script_name=`basename $0`
function usage() {
	echo "usage:$script_name release_version"
	echo "example:$script_name 20140101"
}

if [[ ! "$1" =~ ^[0-9]{8}$ ]]; then
	usage
	exit -1;
fi

release_dir=/home/djb/release

ssh -p 22123 djb@$prd_server "mkdir -p ~/release/$release_ver"
scp -P 22123 $release_dir/static/$release_ver.zip djb@$prd_server:~/release/$release_ver/djb-static.zip
