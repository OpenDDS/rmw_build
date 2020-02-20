#!/usr/bin/env bash
script=`realpath $0`
script_path=`dirname $script`
pushd $script_path
pushd ..
if [ ! -d "src" ];then
    echo "no src"
    mkdir src
fi
vcs import src < rmw_build/ros2.repos
popd
popd
