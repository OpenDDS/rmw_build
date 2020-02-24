#!/usr/bin/env bash
script=`realpath $0`
script_path=`dirname $script`
pushd $script_path
pushd ..
. /opt/ros/eloquent/setup.bash
# colcon build --symlink-install --packages-up-to demo_nodes_cpp
colcon build --symlink-install --packages-up-to examples_rclcpp_minimal_publisher
colcon build --symlink-install --packages-up-to examples_rclcpp_minimal_subscriber
popd
popd
