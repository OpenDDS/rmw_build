#!/usr/bin/env bash

source /opt/OpenDDS/setenv.sh
source /opt/ros/foxy/setup.bash
source install/local_setup.bash
printenv|grep DDS
printenv|grep ROS

export RMW_IMPLEMENTATION=rmw_opendds_cpp
printenv|grep RMW

rm client.out
ros2 run examples_rclcpp_minimal_service service_main &
stdbuf -o0 ros2 run examples_rclcpp_minimal_client client_main &> client.out

pkill service_main
pkill client_main
cat client.out
grep "result" client.out
