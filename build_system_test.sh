#!/usr/bin/env bash
script=`realpath $0`
script_path=`dirname $script`
dpkg -l ros-eloquent-test-msgs ros-eloquent-osrf-testing-tools-cpp ros-eloquent-launch-testing-ament-cmake &>/dev/null
if [ $? == 1 ];then
    apt update
    apt install -y ros-eloquent-test-msgs ros-eloquent-osrf-testing-tools-cpp ros-eloquent-launch-testing-ament-cmake
fi

pushd $script_path
pushd ..
. /opt/ros/eloquent/setup.bash
colcon build --symlink-install --cmake-args '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON' '-DCMAKE_BUILD_TYPE=Debug' --packages-up-to rmw_opendds_cpp
. install/local_setup.bash
colcon build --symlink-install --cmake-args '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON' '-DCMAKE_BUILD_TYPE=Debug' --packages-up-to test_communication
popd
popd
