#!/usr/bin/env bash
script=`realpath $0`
script_path=`dirname $script`

if [ ! -d "src" ];then
    echo "no src"
    mkdir src
fi

vcs import src < $script_path/ros2.repos
vcs import src < $script_path/rmw_opendds.repos
