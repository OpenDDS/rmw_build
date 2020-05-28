#!/usr/bin/env bash

source /opt/OpenDDS/setenv.sh
source /opt/ros/eloquent/setup.bash
source install/local_setup.bash
printenv|grep DDS
printenv|grep ROS

export RMW_IMPLEMENTATION=rmw_opendds_cpp
printenv|grep RMW

ros2 run examples_rclcpp_minimal_service service_main & 
ros2 run examples_rclcpp_minimal_client client_main > client.out

pkill service_main 
pkill client_main
cat client.out
grep "result" client.out
 