#!/usr/bin/env bash

alt_rmw="rmw_opendds_cpp"

while getopts ":ha:" opt; do
case ${opt} in
    a )
        alt_rmw=$OPTARG
        echo "NOTE: For optional DDS implementations, only rmw_fastrtps_cpp is installed by default. All others require extra installation steps. https://index.ros.org/doc/ros2/Installation/DDS-Implementations/."
    ;;
    h ) echo "options: [-a] use alternate rmw (i.e. rmw_cyclonedds_cpp, rmw_fastrtps_cpp, or rmw_connext_cpp)."
    exit
    ;;
esac
done

script=`realpath $0`
script_path=`dirname $script`
pushd $script_path &> /dev/null
pushd .. &> /dev/null

. /opt/ros/foxy/setup.bash
. install/local_setup.bash

export RMW_IMPLEMENTATION=$alt_rmw
colcon test --packages-up-to test_communication
colcon test-result --all

popd &> /dev/null
popd &> /dev/null
