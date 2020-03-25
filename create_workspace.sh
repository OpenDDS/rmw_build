#!/usr/bin/env bash
script=`realpath $0`
script_path=`dirname $script`
pushd $script_path &> /dev/null
pushd .. &> /dev/null
if [ ! -d "src" ];then
    echo "no src"
    mkdir src
fi
vcs import src < rmw_build/ros2.repos
popd &> /dev/null
popd &> /dev/null
