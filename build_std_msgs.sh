#!/usr/bin/env bash

. /opt/ros/eloquent/setup.bash
. install/local_setup.bash
colcon build --symlink-install --cmake-args '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON' '-DCMAKE_BUILD_TYPE=Debug' --packages-select std_msgs
