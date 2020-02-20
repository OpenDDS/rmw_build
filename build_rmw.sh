#!/usr/bin/env bash
script=`realpath $0`
script_path=`dirname $script`
pushd $script_path
pushd ..
. /opt/ros/eloquent/setup.bash
colcon build --symlink-install --packages-up-to rmw_opendds_cpp
popd
popd
