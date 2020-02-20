#!/usr/bin/env bash
script=`realpath $0`
script_path=`dirname $script`
pushd $script_path
. /opt/ros/eloquent/setup.bash
./build_rmw.sh 
./build_demo_nodes_cpp.sh 
popd
