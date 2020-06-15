#!/usr/bin/env bash

export PATH=/usr/lib/ccache:$PATH
. /opt/ros/foxy/setup.bash

echo "BUILD ALL"
./rmw_build/build_rmw.sh
. install/local_setup.bash
colcon build --symlink-install --cmake-args '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON' '-DCMAKE_BUILD_TYPE=Debug' --packages-up-to rcl_interfaces examples_rclcpp_minimal_publisher examples_rclcpp_minimal_subscriber examples_rclcpp_minimal_service examples_rclcpp_minimal_client
