#!/usr/bin/env zsh
script_path=${0:a:h}
pushd $script_path
pushd ..
if [ ! -d "src" ];then
    echo "no src"
    mkdir src

fi
vcs import src < rmw_build/ros2.repos
popd
popd
