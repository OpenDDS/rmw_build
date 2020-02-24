#!/usr/bin/env bash
script=`realpath $0`
script_path=`dirname $script`
pushd $script_path
pushd ..
. /opt/ros/eloquent/setup.bash
. install/local_setup.bash
RMW_IMPLEMENTATION=rmw_opendds_cpp ros2 run demo_nodes_cpp talker
popd
popd
