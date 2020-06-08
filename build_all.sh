#!/usr/bin/env bash

build_rpc=""
while getopts ":hr" opt; do
case ${opt} in
    r )
        build_rpc="examples_rclcpp_minimal_service examples_rclcpp_minimal_client"
    ;;
    h ) echo "options: [-r] build examples for RPC"
    exit
    ;;
esac
done

export PATH=/usr/lib/ccache:$PATH
. /opt/ros/foxy/setup.bash

echo "BUILD ALL"
colcon build --cmake-args '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON' '-DCMAKE_BUILD_TYPE=Debug' --packages-up-to rmw_opendds_cpp
. install/local_setup.bash
colcon build --cmake-args '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON' '-DCMAKE_BUILD_TYPE=Debug' --packages-up-to rcl_interfaces examples_rclcpp_minimal_publisher examples_rclcpp_minimal_subscriber $build_rpc
