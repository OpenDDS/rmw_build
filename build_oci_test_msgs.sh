#!/usr/bin/env bash
script=`realpath $0`
script_path=`dirname $script`
pushd $script_path
pushd ..
. /opt/ros/eloquent/setup.bash
colcon build --cmake-args '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON' '-DCMAKE_BUILD_TYPE=Debug' --packages-up-to oci_test_msgs
popd
popd
