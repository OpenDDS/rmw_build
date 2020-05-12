#!/usr/bin/env bash
script=`realpath $0`
script_path=`dirname $script`

build_cyclonedds="no"
build_rpc=""
while getopts ":hcr" opt; do
case ${opt} in
    c ) 
        build_cyclonedds="yes"
    ;;  
    r ) 
        build_rpc="examples_rclcpp_minimal_service examples_rclcpp_minimal_client"
    ;;  
    h ) echo "options: [-c] build cyclone [-r] build examples for RPC"
    exit
    ;;
esac
done

export PATH=/usr/lib/ccache:$PATH
. /opt/ros/eloquent/setup.bash

pushd $script_path  &> /dev/null
if [ $build_cyclonedds == "yes" ];then
    echo "BUILD CYCLONE"
    ./build_cyclone.sh
    . ../install/local_setup.bash
fi

pushd .. &> /dev/null
echo "BUILD ALL"
colcon build --cmake-args '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON' '-DCMAKE_BUILD_TYPE=Debug' --packages-up-to rmw_opendds_cpp  
. install/local_setup.bash
colcon build --cmake-args '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON' '-DCMAKE_BUILD_TYPE=Debug' --packages-up-to rcl_interfaces examples_rclcpp_minimal_publisher examples_rclcpp_minimal_subscriber $build_rpc

popd &> /dev/null
popd &> /dev/null
