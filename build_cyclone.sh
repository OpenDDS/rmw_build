#!/usr/bin/env bash
script=`realpath $0`
script_path=`dirname $script`
pushd $script_path
pushd ..
. /opt/ros/eloquent/setup.bash

#dpkg-query -W -f='${Status}\n' ros-eloquent-cyclonedds &> /dev/null
#if [ ${Status} == "install ok installed" ];then
    apt update
    apt install -y ros-eloquent-cyclonedds
#fi

colcon build --symlink-install --cmake-args '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON' '-DCMAKE_BUILD_TYPE=Debug' --packages-up-to rmw_cyclonedds_cpp
popd
popd
