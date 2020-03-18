#!/usr/bin/env bash
script=`realpath $0`
script_path=`dirname $script`
pushd $script_path
. /opt/ros/eloquent/setup.bash
./build_rmw.sh 
./build_examples.sh 
./build_cyclone.sh
./build_oci_test_msgs.sh
popd
