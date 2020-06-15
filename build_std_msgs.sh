#!/usr/bin/env bash
script=`realpath $0`
script_path=`dirname $script`
pushd $script_path &> /dev/null
pushd .. &> /dev/null
. /opt/ros/foxy/setup.bash
. install/local_setup.bash
colcon build --cmake-args '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON' '-DCMAKE_BUILD_TYPE=Debug' --packages-select std_msgs
popd &> /dev/null
popd &> /dev/null
