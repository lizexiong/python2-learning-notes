#/bin/bash

tag_version=$1

description=$2

function usage(){
	echo "usage:release_version.sh svn_version release_version code_name"
        echo "example:tag_version.sh 20171501 v20171501"
}

if [ -z $tag_version ] || [ -z $description ]; then
        usage
        exit -1;

fi

if [[ ! "$tag_version" =~ ^[0-9]{8}$ ]]; then
        usage
        exit -2;
fi
git checkout master
git pull
git tag -a $tag_version -m "$description"
git tag
git push origin $tag_version

