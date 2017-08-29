#!/bin/bash

release_ver=$1

prd_server=222.73.136.130

script_name=`basename $0`
function usage() {
	echo "usage:$script_name release_version [app_package...]"
	echo "example:$script_name 20140101"
}

if [[ ! "$1" =~ ^[0-9]{8}$ ]]; then
	usage
	exit -1;
fi
release_dir=/home/djb/release/module/$release_ver
ssh -p 22123 djb@$prd_server "mkdir -p ~/module_release/$release_ver"
shift
app_packages="$@"
if [ -z $app_packages ]; then
app_packages="."
fi
for app in $app_packages; do
rsync -avz --progress '-e ssh -p 22123' $release_dir/$app djb@$prd_server:~/module_release/$release_ver
done;
