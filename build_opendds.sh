#!/usr/bin/env bash

. /opt/ros/foxy/setup.bash
colcon build --packages-select opendds
