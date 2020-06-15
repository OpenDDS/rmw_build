#!/usr/bin/env bash

source /opt/OpenDDS/setenv.sh
source /opt/ros/foxy/setup.bash
source install/local_setup.bash
printenv|grep DDS
printenv|grep ROS

export RMW_IMPLEMENTATION=rmw_opendds_cpp
printenv|grep RMW

ros2 run examples_rclcpp_minimal_subscriber subscriber_member_function_twenty 1> sub.out&
process_id=$!
ros2 run examples_rclcpp_minimal_publisher publisher_member_function_twenty
wait $process_id
cat sub.out
grep "I heard" sub.out
