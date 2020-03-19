#!/usr/bin/env bash
script=`realpath $0`
script_path=`dirname $script`
pushd $script_path &> /dev/null
pushd .. &> /dev/null
. /opt/ros/eloquent/setup.bash
colcon build --cmake-args '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON' '-DCMAKE_BUILD_TYPE=Debug' --packages-up-to examples_rclcpp_minimal_publisher
colcon build --cmake-args '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON' '-DCMAKE_BUILD_TYPE=Debug' --packages-up-to examples_rclcpp_minimal_subscriber
popd &> /dev/null
popd &> /dev/null
