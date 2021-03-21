#!/usr/bin/env bash
script=`realpath $0`
script_path=`dirname $script`

if [ ! -d "src" ];then
    echo "no src"
    mkdir src
fi

vcs import --recursive src < $script_path/ros2.repos
vcs import --recursive src < $script_path/rmw_opendds.repos

if [ `whoami` == "root" ];then
    apt update
    rosdep install --from-paths src --ignore-src -r -y
else
    echo "not root. Dependencies not added. Build may not succeed."
fi
