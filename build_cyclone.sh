#!/usr/bin/env bash
script=`realpath $0`
script_path=`dirname $script`

echo "deprecated"
exit

pushd $script_path &> /dev/null
pushd .. &> /dev/null
. /opt/ros/foxy/setup.bash

dpkg -l ros-foxy-cyclonedds &>/dev/null
if [ $? == 1 ];then
    apt update
    apt install -y ros-foxy-cyclonedds
fi

colcon build --cmake-args '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON' '-DCMAKE_BUILD_TYPE=Debug' --packages-up-to rmw_cyclonedds_cpp

popd &> /dev/null
popd &> /dev/null
