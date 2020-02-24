#!/usr/bin/env bash
script=`realpath $0`
script_path=`dirname $script`
pushd $script_path
pushd ..
. /opt/ros/eloquent/setup.bash
. install/local_setup.bash
RMW_IMPLEMENTATION=rmw_opendds_cpp ros2 run examples_rclcpp_minimal_publisher publisher_member_function
popd 
popd
 